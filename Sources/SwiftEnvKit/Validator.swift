import Foundation

/// Validates environment configuration against a schema at startup.
public struct EnvironmentValidator: Sendable {
    private let rules: [String: ValidationRule]

    public init(rules: [String: ValidationRule]) {
        self.rules = rules
    }

    public func validate(environment: [String: String] = ProcessInfo.processInfo.environment) throws {
        for (key, rule) in rules {
            guard let value = environment[key] else {
                if rule.required { throw EnvironmentError.missing(key) }
                continue
            }
            if let pattern = rule.pattern, value.range(of: pattern, options: .regularExpression) == nil {
                throw EnvironmentError.invalidType(key: key, expected: "matching \(pattern)")
            }
        }
    }
}

public struct ValidationRule: Sendable {
    public let required: Bool
    public let pattern: String?

    public init(required: Bool = true, pattern: String? = nil) {
        self.required = required
        self.pattern = pattern
    }
}
