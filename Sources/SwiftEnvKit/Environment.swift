import Foundation

/// A type-safe accessor for process environment variables.
public struct Environment: Sendable {
    /// Underlying process environment dictionary.
    public static var values: [String: String] {
        ProcessInfo.processInfo.environment
    }

    /// Loads an environment variable value, falling back to a default value if not set.
    ///
    /// - Parameters:
    ///   - key: The name of the environment variable.
    ///   - defaultValue: The fallback string if the variable is not set.
    /// - Returns: The resolved environment value or the default string.
    public static func load(_ key: String, default defaultValue: String) -> String {
        values[key] ?? defaultValue
    }

    /// Loads an environment variable value, optionally returning `nil` if unset and no fallback is given.
    ///
    /// - Parameters:
    ///   - key: The name of the environment variable.
    ///   - defaultValue: An optional fallback string if the variable is not set.
    /// - Returns: The resolved environment value, fallback value, or `nil`.
    public static func load(_ key: String, default defaultValue: String? = nil) -> String? {
        values[key] ?? defaultValue
    }

    /// Requires an environment variable to exist, or throws `EnvironmentError.missing`.
    ///
    /// - Parameter key: The name of the environment variable.
    /// - Returns: The string value of the environment variable.
    /// - Throws: `EnvironmentError.missing` if the variable is not present.
    public static func require(_ key: String) throws -> String {
        guard let value = values[key] else {
            throw EnvironmentError.missing(key)
        }
        return value
    }

    /// Determines whether an environment variable exists.
    ///
    /// - Parameter key: The name of the environment variable.
    /// - Returns: `true` if the variable is set in the environment; otherwise `false`.
    public static func contains(_ key: String) -> Bool {
        values[key] != nil
    }

    /// Retrieves an environment variable by key using subscript syntax.
    ///
    /// - Parameter key: The name of the environment variable.
    public static subscript(key: String) -> String? {
        values[key]
    }
}
