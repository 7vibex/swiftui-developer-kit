import Foundation
import SwiftParser
import SwiftSyntax

public enum SwiftUIScanner {
    public static func scan(source: String, file: String) -> [Finding] {
        let tree = Parser.parse(source: source)
        let visitor = RuleVisitor(source: source, file: file, tree: tree)
        visitor.walk(tree)
        return visitor.finalizedFindings()
    }
}

private final class RuleVisitor: SyntaxVisitor {
    private let source: String
    private let file: String
    private let lines: [String]
    private let converter: SourceLocationConverter
    private var findings: [Finding] = []
    private var findingKeys: Set<String> = []
    private var sheetLines: [Int] = []

    init(source: String, file: String, tree: SourceFileSyntax) {
        self.source = source
        self.file = file
        self.lines = source.components(separatedBy: .newlines)
        self.converter = SourceLocationConverter(fileName: file, tree: tree)
        super.init(viewMode: .sourceAccurate)
    }

    override func visit(_ node: FunctionCallExprSyntax) -> SyntaxVisitorContinueKind {
        let callee = node.calledExpression.trimmedDescription
        let text = node.trimmedDescription
        let position = node.calledExpression.as(MemberAccessExprSyntax.self)?
            .declName.baseName.positionAfterSkippingLeadingTrivia
            ?? node.positionAfterSkippingLeadingTrivia
        let location = converter.location(for: position)
        let line = location.line
        let column = location.column

        if callee == "Button",
           text.contains("Image(systemName:"),
           !text.contains("Label("),
           !text.contains(".accessibilityLabel") {
            emit(
                ruleID: "image-button-missing-accessibility-label",
                severity: .high,
                line: line,
                column: column,
                message: "A symbol-only Button has no syntax-local accessibility label.",
                recommendation: "Use Label or add a clear accessibilityLabel and state value."
            )
        }

        if callee.hasSuffix(".onAppear"), text.contains("Task {") {
            emit(
                ruleID: "unstructured-task-in-view-lifecycle",
                severity: .medium,
                line: line,
                column: column,
                message: "An onAppear closure starts an unstructured Task.",
                recommendation: "Prefer task(id:), cancellation-aware state, or explicit task ownership."
            )
        }

        if [".foregroundColor", ".foregroundStyle", ".background"].contains(where: callee.hasSuffix),
           ["red", "blue", "green", "orange", "purple", "pink", "yellow", "black", "white", "gray"]
            .contains(where: { text.contains(".\($0)") }) {
            emit(
                ruleID: "hardcoded-semantic-color",
                severity: .low,
                line: line,
                column: column,
                message: "A style call uses a hardcoded color token.",
                recommendation: "Use a semantic role or environment-aware asset color."
            )
        }

        if callee.hasSuffix(".delete"),
           text.contains("modelContext") || callee.contains("modelContext") {
            if !source.contains("confirmationDialog")
                && !source.contains("alert(")
                && !source.localizedCaseInsensitiveContains("undo") {
                emit(
                    ruleID: "swiftdata-delete-without-recovery-signal",
                    severity: .high,
                    line: line,
                    column: column,
                    message: "A ModelContext delete has no file-level confirmation or recovery signal.",
                    recommendation: "Add confirmation, undo, or a documented recovery path and regression test."
                )
            }
        }

        if callee.hasSuffix(".sheet"), text.contains("isPresented:") {
            sheetLines.append(line)
        }

        if callee.hasSuffix(".id"), text.contains("UUID()") {
            emit(
                ruleID: "unstable-view-identity",
                severity: .high,
                line: line,
                column: column,
                message: "A view identity is regenerated with UUID().",
                recommendation: "Use stable model identity so SwiftUI can preserve state and diff correctly."
            )
        }

        if callee.hasSuffix(".frame"),
           text.range(of: #"(width|height)\s*:\s*[0-9]{2,}"#, options: .regularExpression) != nil {
            emit(
                ruleID: "fixed-frame-dynamic-type-risk",
                severity: .medium,
                line: line,
                column: column,
                message: "A fixed numeric frame dimension may clip Dynamic Type content.",
                recommendation: "Prefer flexible constraints or prove the fixed dimension contains accessibility sizes."
            )
        }

        if callee.contains("glassEffect") || callee.contains("GlassEffectContainer") {
            if !source.contains("#available") && !source.contains("@available") {
                emit(
                    ruleID: "glass-effect-missing-availability-guard",
                    severity: .high,
                    line: line,
                    column: column,
                    message: "Liquid Glass syntax has no file-level availability policy.",
                    recommendation: "Add an availability guard and older-OS semantic fallback."
                )
            }
        }

        if callee.hasPrefix("logger.") {
            let sensitive = ["email", "prompt", "noteText", "messageBody", "transcript", "token", "secret"]
            if sensitive.contains(where: text.localizedCaseInsensitiveContains),
               !text.contains("privacy: .private"),
               !text.contains("privacy: .sensitive") {
                emit(
                    ruleID: "logger-sensitive-interpolation",
                    severity: .high,
                    line: line,
                    column: column,
                    message: "A Logger call includes a sensitive-looking identifier without privacy annotation.",
                    recommendation: "Omit raw content or mark interpolation private and hash identifiers where needed."
                )
            }
        }

        return .visitChildren
    }

    func finalizedFindings() -> [Finding] {
        if sheetLines.count >= 2,
           source.range(
            of: #"@State[^\n]*(show|is)[A-Za-z0-9_]*\s*=\s*false"#,
            options: [.regularExpression, .caseInsensitive]
           ) != nil {
            emit(
                ruleID: "multiple-presentation-booleans",
                severity: .medium,
                line: sheetLines.first ?? 1,
                column: 1,
                message: "Multiple boolean-driven sheets share one file.",
                recommendation: "Use one item-backed or enum-backed presentation route."
            )
        }

        if source.contains("PKToolPicker.shared") || source.contains("shared(for:") {
            emit(
                ruleID: "deprecated-pktoolpicker-shared-for-window",
                severity: .medium,
                line: firstLine(containing: "PKToolPicker.shared") ?? firstLine(containing: "shared(for:") ?? 1,
                column: 1,
                message: "The file uses the legacy shared PKToolPicker lookup.",
                recommendation: "Use current tool-picker lifecycle and verify first-responder ownership."
            )
        }

        if source.contains("PKCanvasView") && !source.contains("canvasViewDrawingDidChange") {
            emit(
                ruleID: "pkcanvasview-no-change-hook",
                severity: .high,
                line: firstLine(containing: "PKCanvasView") ?? 1,
                column: 1,
                message: "PKCanvasView has no file-level drawing-change callback.",
                recommendation: "Feed drawing changes into a debounced save or document persistence boundary."
            )
        }

        if lines.count > 120 && source.contains("@Query") {
            emit(
                ruleID: "query-in-heavy-root-view",
                severity: .medium,
                line: firstLine(containing: "@Query") ?? 1,
                column: 1,
                message: "A large SwiftUI file owns a Query.",
                recommendation: "Keep simple view-facing queries local and move heavy orchestration behind a boundary."
            )
        }

        return findings.sorted {
            ($0.file, $0.line, $0.ruleID) < ($1.file, $1.line, $1.ruleID)
        }
    }

    private func emit(
        ruleID: String,
        severity: Severity,
        line: Int,
        column: Int,
        message: String,
        recommendation: String
    ) {
        guard !isSuppressed(ruleID: ruleID, line: line) else { return }
        let key = "\(ruleID):\(line)"
        guard findingKeys.insert(key).inserted else { return }
        findings.append(
            Finding(
                ruleID: ruleID,
                severity: severity,
                file: file,
                line: line,
                column: column,
                message: message,
                recommendation: recommendation
            )
        )
    }

    private func isSuppressed(ruleID: String, line: Int) -> Bool {
        let fileMarker = "swiftui-kit:disable-file \(ruleID)"
        if lines.prefix(12).contains(where: { $0.contains(fileMarker) }) {
            return true
        }

        let marker = "swiftui-kit:disable \(ruleID)"
        let indexes = [line - 1, line - 2].filter { lines.indices.contains($0) }
        return indexes.contains { lines[$0].contains(marker) }
    }

    private func firstLine(containing needle: String) -> Int? {
        lines.firstIndex(where: { $0.contains(needle) }).map { $0 + 1 }
    }
}
