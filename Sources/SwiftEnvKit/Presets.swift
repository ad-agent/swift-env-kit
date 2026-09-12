/// Common environment schemas for quick bootstrapping.
public enum EnvironmentPresets {
    public static let database: [String: ValidationRule] = [
        "DATABASE_URL": ValidationRule(required: true),
        "DATABASE_POOL_SIZE": ValidationRule(required: false, pattern: "^\\d+$"),
    ]
    public static let server: [String: ValidationRule] = [
        "PORT": ValidationRule(required: false, pattern: "^\\d+$"),
        "HOST": ValidationRule(required: false),
    ]
}
