import XCTest
@testable import SwiftUIScannerCore

final class ScannerTests: XCTestCase {
    func testSymbolButtonIsScopedToButtonSyntax() {
        let source = """
        import SwiftUI
        struct Example: View {
            var body: some View {
                VStack {
                    Image(systemName: "chevron.right")
                    Button("Add") {}
                }
            }
        }
        """

        let findings = SwiftUIScanner.scan(source: source, file: "Example.swift")
        XCTAssertFalse(findings.contains { $0.ruleID == "image-button-missing-accessibility-label" })
    }

    func testPositiveRulesAndInlineSuppression() {
        let source = """
        import SwiftUI
        struct Example: View {
            @State private var showOne = false
            @State private var showTwo = false
            var body: some View {
                Button(action: {}) { Image(systemName: "trash") }
                    .foregroundStyle(.red)
                    // swiftui-kit:disable fixed-frame-dynamic-type-risk
                    .frame(width: 80)
                    .sheet(isPresented: $showOne) { Text("One") }
                    .sheet(isPresented: $showTwo) { Text("Two") }
            }
        }
        """

        let findings = SwiftUIScanner.scan(source: source, file: "Example.swift")
        XCTAssertTrue(findings.contains { $0.ruleID == "image-button-missing-accessibility-label" })
        XCTAssertTrue(findings.contains { $0.ruleID == "hardcoded-semantic-color" })
        XCTAssertTrue(findings.contains { $0.ruleID == "multiple-presentation-booleans" })
        XCTAssertFalse(findings.contains { $0.ruleID == "fixed-frame-dynamic-type-risk" })
    }
}
