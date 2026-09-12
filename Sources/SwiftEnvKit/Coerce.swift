import Foundation

extension Environment {
    /// Loads an integer environment variable or throws `EnvironmentError.invalidType`.
    public static func loadInt(_ key: String, default defaultValue: Int? = nil) throws -> Int? {
        guard let raw = values[key] else { return defaultValue }
        guard let value = Int(raw) else { throw EnvironmentError.invalidType(key: key, expected: "Int") }
        return value
    }

    /// Loads an integer environment variable with a default fallback.
    public static func loadInt(_ key: String, default defaultValue: Int) throws -> Int {
        try loadInt(key, default: defaultValue as Int?) ?? defaultValue
    }

    /// Loads a boolean environment variable ("true"/"false", "1"/"0", "yes"/"no").
    public static func loadBool(_ key: String, default defaultValue: Bool? = nil) throws -> Bool? {
        guard let raw = values[key] else { return defaultValue }
        switch raw.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
        case "true", "1", "yes": return true
        case "false", "0", "no": return false
        default: throw EnvironmentError.invalidType(key: key, expected: "Bool")
        }
    }

    /// Loads a boolean environment variable with a default fallback.
    public static func loadBool(_ key: String, default defaultValue: Bool) throws -> Bool {
        try loadBool(key, default: defaultValue as Bool?) ?? defaultValue
    }

    /// Loads a URL environment variable or throws `EnvironmentError.invalidType`.
    public static func loadURL(_ key: String, default defaultValue: URL? = nil) throws -> URL? {
        guard let raw = values[key] else { return defaultValue }
        guard let url = URL(string: raw) else { throw EnvironmentError.invalidType(key: key, expected: "URL") }
        return url
    }

    /// Loads a URL environment variable with a default fallback.
    public static func loadURL(_ key: String, default defaultValue: URL) throws -> URL {
        try loadURL(key, default: defaultValue as URL?) ?? defaultValue
    }
}
