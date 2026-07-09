import Foundation
import SwiftUIScannerCore

struct Options {
    var paths: [String] = []
    var format = "markdown"
    var baselinePath: String?
    var writeBaselinePath: String?
    var failOn: Severity?
}

enum CLIError: Error, CustomStringConvertible {
    case usage(String)

    var description: String {
        switch self {
        case let .usage(message): message
        }
    }
}

func parseOptions(_ arguments: [String]) throws -> Options {
    var options = Options()
    var index = 0

    while index < arguments.count {
        let argument = arguments[index]
        switch argument {
        case "--format":
            index += 1
            guard index < arguments.count else { throw CLIError.usage("--format requires markdown or json") }
            options.format = arguments[index]
        case "--baseline":
            index += 1
            guard index < arguments.count else { throw CLIError.usage("--baseline requires a path") }
            options.baselinePath = arguments[index]
        case "--write-baseline":
            index += 1
            guard index < arguments.count else { throw CLIError.usage("--write-baseline requires a path") }
            options.writeBaselinePath = arguments[index]
        case "--fail-on":
            index += 1
            guard index < arguments.count, let severity = Severity(rawValue: arguments[index]) else {
                throw CLIError.usage("--fail-on requires critical, high, medium, or low")
            }
            options.failOn = severity
        case "--ci":
            options.format = "json"
            options.failOn = .high
        case "-h", "--help":
            throw CLIError.usage("""
            Usage: swiftui-scanner [options] [PATH...]
              --format markdown|json
              --baseline PATH              Read a schema v2.0.0 baseline.
              --write-baseline PATH        Regenerate a schema v2.0.0 baseline.
              --fail-on critical|high|medium|low
              --ci
            """)
        default:
            options.paths.append(argument)
        }
        index += 1
    }

    guard ["markdown", "json"].contains(options.format) else {
        throw CLIError.usage("unsupported format: \(options.format)")
    }
    if options.paths.isEmpty {
        options.paths = ["."]
    }
    return options
}

func swiftFiles(in paths: [String]) -> [String] {
    let manager = FileManager.default
    let skipped = Set([".git", ".build", "DerivedData", "build", "xcuserdata"])
    var files: Set<String> = []

    for path in paths {
        var isDirectory: ObjCBool = false
        guard manager.fileExists(atPath: path, isDirectory: &isDirectory) else { continue }
        if !isDirectory.boolValue {
            if path.hasSuffix(".swift") { files.insert(path) }
            continue
        }

        let root = URL(fileURLWithPath: path)
        let enumerator = manager.enumerator(
            at: root,
            includingPropertiesForKeys: [.isRegularFileKey, .isDirectoryKey],
            options: [.skipsHiddenFiles]
        )
        while let url = enumerator?.nextObject() as? URL {
            if skipped.contains(url.lastPathComponent) {
                enumerator?.skipDescendants()
                continue
            }
            if url.pathExtension == "swift" {
                files.insert(url.path)
            }
        }
    }
    return files.sorted()
}

func loadBaseline(path: String?) throws -> Set<String> {
    guard let path else { return [] }
    let data = try Data(contentsOf: URL(fileURLWithPath: path))
    return Set(try JSONDecoder().decode(Baseline.self, from: data).fingerprints)
}

func printMarkdown(_ report: ScanReport) {
    print("# SwiftUI Structured Scan")
    print("")
    if report.findings.isEmpty {
        print("No unsuppressed findings.")
        return
    }
    for finding in report.findings {
        print("- **\(finding.ruleID)** (\(finding.file):\(finding.line)) [\(finding.severity.rawValue)]: \(finding.message) \(finding.recommendation)")
    }
    print("")
    print("Findings: \(report.findings.count)")
}

do {
    let options = try parseOptions(Array(CommandLine.arguments.dropFirst()))
    let files = swiftFiles(in: options.paths)
    let baseline = try loadBaseline(path: options.baselinePath)
    var findings: [Finding] = []

    for file in files {
        let source = try String(contentsOfFile: file, encoding: .utf8)
        findings.append(contentsOf: SwiftUIScanner.scan(source: source, file: file))
    }
    findings.removeAll { baseline.contains($0.fingerprint) }
    let report = ScanReport(scannedFiles: files, findings: findings)

    if let path = options.writeBaselinePath {
        let data = try JSONEncoder.pretty.encode(Baseline(fingerprints: findings.map(\.fingerprint)))
        try data.write(to: URL(fileURLWithPath: path), options: .atomic)
    }

    if options.format == "json" {
        let data = try JSONEncoder.pretty.encode(report)
        FileHandle.standardOutput.write(data)
        FileHandle.standardOutput.write(Data([0x0A]))
    } else {
        printMarkdown(report)
    }

    if let threshold = options.failOn,
       findings.contains(where: { $0.severity.rank >= threshold.rank }) {
        exit(1)
    }
} catch let error as CLIError {
    FileHandle.standardError.write(Data("\(error.description)\n".utf8))
    exit(error.description.hasPrefix("Usage:") ? 0 : 2)
} catch {
    FileHandle.standardError.write(Data("scanner error: \(error)\n".utf8))
    exit(2)
}

private extension JSONEncoder {
    static var pretty: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return encoder
    }
}
