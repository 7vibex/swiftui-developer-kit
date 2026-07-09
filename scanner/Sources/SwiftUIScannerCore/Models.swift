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
        self.fingerprint = StableFingerprint.make(ruleID, file, message)
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
    public let scannerVersion = "0.5.0"
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
    public let schemaVersion: String
    public let fingerprints: [String]

    public init(fingerprints: [String]) {
        self.schemaVersion = "1.0.0"
        self.fingerprints = fingerprints.sorted()
    }

    enum CodingKeys: String, CodingKey {
        case schemaVersion = "schema_version"
        case fingerprints
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
