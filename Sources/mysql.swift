//
//  mysql.swift
//  serverSideSwift
//
//  Created by Michal Šimík on 27.01.17.
//
//

import PerfectLib
import MySQL
import PerfectHTTP
import PerfectHTTPServer

let testHost = "127.0.0.1"
let testUser = "root"
let testPassword: String? = nil
let testSchema = "footballTeam"

let dataMysql = MySQL()

public func showAllPlayers(_ request: HTTPRequest, response: HTTPResponse) {

    guard dataMysql.connect(host: testHost, user: testUser, password: nil ) else {
        Log.info(message: "Failure connecting to data server \(testHost)")
        return
    }

    defer {
        dataMysql.close()
    }

    guard dataMysql.selectDatabase(named: testSchema) && dataMysql.query(statement: "select * from player;") else {
        Log.info(message: "Failure: \(dataMysql.errorCode()) \(dataMysql.errorMessage())")
        return
    }

    //store complete result set
    let results = dataMysql.storeResults()

    //setup an array to store results
    var resultArray = [[String?]]()

    while let row = results?.next() {
        resultArray.append(row)

    }

    let encoded = try! resultArray.jsonEncodedString()

    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: encoded)
    response.completed()
}


public func showPlayer(_ request: HTTPRequest, response: HTTPResponse) {

    guard let id: String = request.urlVariables["id"] else {
        Log.info(message: "No id param")
        return
    }

    guard dataMysql.connect(host: testHost, user: testUser, password: nil ) else {
        Log.info(message: "Failure connecting to data server \(testHost)")
        return
    }

    defer {
        dataMysql.close()
    }

    guard dataMysql.selectDatabase(named: testSchema) && dataMysql.query(statement: "select * from player where ID=\(id);") else {
        Log.info(message: "Failure: \(dataMysql.errorCode()) \(dataMysql.errorMessage())")
        return
    }

    let results = dataMysql.storeResults()

    let row = results?.next() ?? nil

    let encoded = try! row.jsonEncodedString()

    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: encoded)
    response.completed()
}

