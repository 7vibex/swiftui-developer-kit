import Foundation

public enum Severity: String, Codable, CaseIterable, Sendable {
    case critical
    case high
    case medium
    case low

    public var rank: Int {
        switch self {
        case .critical: 4
        case .high: 3
        case .medium: 2
        case .low: 1
        }
    }
}

public struct Finding: Codable, Equatable, Sendable {
    public let fingerprint: String
    public let ruleID: String
    public let severity: Severity
    public let file: String
    public let line: Int
    public let column: Int
    public let message: String
    public let recommendation: String

    public init(
        ruleID: String,
        severity: Severity,
        file: String,
        line: Int,
        column: Int,
        message: String,
        recommendation: String
    ) {
        self.ruleID = ruleID
        self.severity = severity
        self.file = file
        self.line = line
        self.column = column
        self.message = message
        self.recommendation = recommendation
        // A baseline must identify one concrete finding, not every instance of
        // the same rule/message in a file. Include source location so accepting
        // one repeated issue cannot suppress its siblings.
        self.fingerprint = StableFingerprint.make(
            ruleID,
            file,
            String(line),
            String(column),
            message
        )
    }

    enum CodingKeys: String, CodingKey {
        case fingerprint
        case ruleID = "rule_id"
        case severity
        case file
        case line
        case column
        case message
        case recommendation
    }
}

public struct ScanReport: Codable, Sendable {
    public let schemaVersion = "1.0.0"
    public let scannerVersion = "0.6.0"
    public let scannedFiles: [String]
    public let findings: [Finding]

    public init(scannedFiles: [String], findings: [Finding]) {
        self.scannedFiles = scannedFiles
        self.findings = findings
    }

    enum CodingKeys: String, CodingKey {
        case schemaVersion = "schema_version"
        case scannerVersion = "scanner_version"
        case scannedFiles = "scanned_files"
        case findings
    }
}

public struct Baseline: Codable, Sendable {
    public static let currentSchemaVersion = "2.0.0"

    public let schemaVersion: String
    public let fingerprints: [String]

    public init(fingerprints: [String]) {
        self.schemaVersion = Self.currentSchemaVersion
        self.fingerprints = Array(Set(fingerprints)).sorted()
    }

    enum CodingKeys: String, CodingKey {
        case schemaVersion = "schema_version"
        case fingerprints
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let schemaVersion = try container.decode(String.self, forKey: .schemaVersion)
        guard schemaVersion == Self.currentSchemaVersion else {
            throw DecodingError.dataCorruptedError(
                forKey: .schemaVersion,
                in: container,
                debugDescription: "Unsupported baseline schema version \(schemaVersion). Regenerate the baseline with the current swiftui-scanner using --write-baseline."
            )
        }

        let fingerprints = try container.decode([String].self, forKey: .fingerprints)
        guard fingerprints == fingerprints.sorted(), Set(fingerprints).count == fingerprints.count else {
            throw DecodingError.dataCorruptedError(
                forKey: .fingerprints,
                in: container,
                debugDescription: "Baseline fingerprints must be sorted and unique. Regenerate the baseline with the current swiftui-scanner using --write-baseline."
            )
        }

        self.schemaVersion = schemaVersion
        self.fingerprints = fingerprints
    }
}

enum StableFingerprint {
    static func make(_ values: String...) -> String {
        var hash: UInt64 = 14_695_981_039_346_656_037
        for byte in values.joined(separator: "|").utf8 {
            hash ^= UInt64(byte)
            hash &*= 1_099_511_628_211
        }
        return String(format: "%016llx", hash)
    }
}
