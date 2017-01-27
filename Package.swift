import PackageDescription

let package = Package(
    name: "perfect-test",
    dependencies: [
        .Package(
            url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git",
            majorVersion: 2, minor: 0
        ),
        .Package(
            url:"https://github.com/PerfectlySoft/Perfect-MySQL.git",
            majorVersion: 2, minor: 0)
    ]
)
