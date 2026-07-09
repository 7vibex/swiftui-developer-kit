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

    func testRepeatedFindingsAtDifferentLocationsHaveDistinctFingerprints() {
        let source = """
        import SwiftUI
        struct Example: View {
            var body: some View {
                VStack {
                    Text("One").frame(width: 80)
                    Text("Two").frame(width: 80)
                }
            }
        }
        """

        let findings = SwiftUIScanner.scan(source: source, file: "Example.swift")
            .filter { $0.ruleID == "fixed-frame-dynamic-type-risk" }

        XCTAssertEqual(findings.count, 2)
        XCTAssertEqual(Set(findings.map(\.fingerprint)).count, 2)
        XCTAssertNotEqual(findings[0].fingerprint, findings[1].fingerprint)
    }

    func testLegacyBaselineSchemaIsRejectedWithRegenerationGuidance() throws {
        let data = Data(#"{"schema_version":"1.0.0","fingerprints":[]}"#.utf8)

        XCTAssertThrowsError(try JSONDecoder().decode(Baseline.self, from: data)) { error in
            XCTAssertTrue(String(describing: error).contains("Regenerate the baseline"))
        }
    }
}
