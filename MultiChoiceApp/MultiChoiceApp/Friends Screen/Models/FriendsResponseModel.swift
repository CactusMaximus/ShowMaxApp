//
//  FriendsResponseModel.swift
//  MultiChoiceApp
//
//  Created by Shamith Ramdhani on 2021/03/27.
//

import Foundation
import UIKit

struct FriendsResponseModel {
    var result = 0
    var friends: [FriendDetails] = [FriendDetails]()

    init(dictionary: [String: Any]) {
        self.result = dictionary["result"] as? Int ?? 0
        let friendObjects: [[String: String]] = dictionary["friends"] as? [[String: String]] ?? [["":""]]
        for friend in friendObjects {
            self.friends.append(FriendDetails(dictionary: friend))
        }
    }
}

struct FriendDetails {
    var firstName = ""
    var lastName = ""
    var alias = ""
    var dateOfBirth = ""
    var imageURL = ""
    var status = ""
    var image = UIImage()
    
    init(dictionary: [String: String]) {
        self.firstName = dictionary["firstName"] ?? ""
        self.lastName = dictionary["lastName"] ?? ""
        self.alias = dictionary["alias"] ?? ""
        self.dateOfBirth = dictionary["dateOfBirth"] ?? ""
        self.imageURL = dictionary["imageURL"] ?? ""
        self.status = dictionary["status"] ?? ""
    }
}
