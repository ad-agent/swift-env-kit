# SwiftEnvKit

A lightweight, type-safe environment variable loader for Swift server-side applications, built with full Swift 6 strict concurrency support.

## Features

- **Type Safety**: Coerce environment variables directly to `Int`, `Bool`, and `URL`.
- **Swift 6 Ready**: Completely compliant with Swift 6 strict concurrency (`Sendable`).
- **Fail Fast**: Explicit `require(_:)` to catch missing configuration early during startup.
- **Fallbacks**: Convenient fallback defaults for optional configuration.

## Installation

Add `SwiftEnvKit` to your `Package.swift` dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/ad-agent/swift-env-kit.git", from: "1.0.0")
]
```

Add it to your target dependencies:

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "SwiftEnvKit", package: "swift-env-kit")
    ]
)
```

## Quick Start

```swift
import SwiftEnvKit

// Load with optional fallback
let host = Environment.load("HOST", default: "127.0.0.1")

// Require a variable or throw EnvironmentError.missing
let secretKey = try Environment.require("SECRET_KEY")

// Typed coercion with defaults
let port = try Environment.loadInt("PORT", default: 8080)
let isDebug = try Environment.loadBool("DEBUG", default: false)
let apiURL = try Environment.loadURL("API_URL")
```

## License

SwiftEnvKit is available under the MIT license. See [LICENSE](LICENSE) for details.
