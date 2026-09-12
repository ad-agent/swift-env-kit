import Foundation

/// Errors thrown by SwiftEnvKit when reading or converting environment variables.
public enum EnvironmentError: Error, Sendable, Equatable {
    /// The required environment variable does not exist.
    case missing(String)

    /// The environment variable exists but cannot be coerced to the requested type.
    case invalidType(key: String, expected: String)
}

extension EnvironmentError: LocalizedError, CustomStringConvertible {
    public var errorDescription: String? {
        description
    }

    public var description: String {
        switch self {
        case .missing(let key):
            return "Missing required environment variable: '\(key)'"
        case .invalidType(let key, let expected):
            return "Environment variable '\(key)' cannot be parsed as expected type '\(expected)'"
        }
    }
}
