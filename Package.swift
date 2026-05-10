// swift-tools-version:5.5
import PackageDescription

// This Package.swift mirrors the `ThriftObjC` CocoaPods podspec's
// default `ObjC` subspec: it exposes the Objective-C Cocoa library
// under the module name `Thrift`. Objective-C sources live in
// `lib/cocoa/src`; public headers live in `lib/cocoa/include/Thrift`
// so consumers can use `#import <Thrift/Header.h>`.
//
// SwiftPM can't mix Objective-C and Swift in a single target and can't
// platform-conditionally include source files, so — following the
// pattern used by BlocksKit's Package.swift — we simplify:
//
//   * Only the Objective-C `.m` files are compiled (the Swift sources
//     under `lib/cocoa/src/*.swift` are excluded, matching the pod's
//     `ObjC` subspec).
//   * The pod's watchOS subspec excludes the server and several
//     socket-based transports because CFNetwork isn't available on
//     watchOS. SwiftPM can't do per-platform source exclusions, so
//     instead we guard those files at the source level with
//     `#if !TARGET_OS_WATCH`. That lets iOS/macOS keep the full source
//     set while watchOS still compiles a coherent, if smaller,
//     `Thrift` module.
//   * Deployment targets are bumped to modern minimums (iOS 12 / macOS
//     10.13 / watchOS 4), similar to how BlocksKit bumped away from
//     the ancient floors in its podspec.
let package = Package(
    name: "Thrift",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13),
        .watchOS(.v4),
    ],
    products: [
        .library(
            name: "Thrift",
            targets: ["Thrift"]
        ),
    ],
    targets: [
        .target(
            name: "Thrift",
            path: "lib/cocoa",
            exclude: [
                "src/TBinary.swift",
                "src/TEnum.swift",
                "src/TList.swift",
                "src/TMap.swift",
                "src/TProtocol.swift",
                "src/TSerializable.swift",
                "src/TSet.swift",
                "src/TStruct.swift",
            ],
            sources: ["src"],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include"),
            ],
            linkerSettings: [
                .linkedFramework("CFNetwork", .when(platforms: [.iOS])),
                .linkedFramework("CoreServices", .when(platforms: [.macOS])),
            ]
        ),
    ]
)
