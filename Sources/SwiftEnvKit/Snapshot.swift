import Foundation
/// Snapshot of the current environment.
public struct EnvironmentSnapshot: Sendable {
    public let values: [String: String]
    public init(_ env: [String: String] = ProcessInfo.processInfo.environment) { self.values = env }
    public subscript(key: String) -> String? { values[key] }
}
