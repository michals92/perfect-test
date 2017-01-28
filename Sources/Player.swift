//
//  Player.swift
//  perfect-test
//
//  Created by Michal Šimík on 28.01.17.
//
//

import Foundation
import PerfectLib


struct Player {
    let dateFormatter = DateFormatter()
    let id: Int
    let lastName: String
    let firstName: String
    let nationality: String
    let post: String
    let birthday: Date?
    let weigth: Int?
    let height: Int?

    init(fromArray array: [String]) {
        guard let id = Int(array[0]) else {
            fatalError("No id for player")
        }
        self.id = id
        self.lastName = array[1]
        self.firstName = array[2]
        self.nationality = array[3] 
        self.post = array[4]

        dateFormatter.dateFormat = "yyyy-mm-dd"
        self.birthday = dateFormatter.date(from: array[5])

        self.weigth = Int(array[6])
        self.height = Int(array[7])

    }

    func toDictionary()  -> [String: Any] {
        var dictionary = [ "id" : id, "lastName": lastName, "firstName": firstName, "nationality": nationality, "post": post] as [String : Any]

        if let birthday = birthday {
            dictionary["birthday"] = dateFormatter.string(from: birthday)
        }
        if let height = height {
            dictionary["height"] = height
        }
        if let weigth = weigth {
            dictionary["weigth"] = weigth
        }
        return dictionary
    }
}
