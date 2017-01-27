
import PerfectLib
import MySQL
import PerfectHTTP
import PerfectHTTPServer

// Initialize routes

var routes = Routes()
routes.add(method: .get, uri: "/allPlayers", handler: showAllPlayers)
routes.add(method: .get, uri: "/player/{id}", handler: showPlayer)

// Initialize server

let server = HTTPServer()

server.serverPort = 8080
server.serverName = "localhost"
server.addRoutes(routes)

// Launch the HTTP server

do {
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}

