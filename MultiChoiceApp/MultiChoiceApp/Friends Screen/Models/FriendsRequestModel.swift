//
//  FriendsRequestModel.swift
//  MultiChoiceApp
//
//  Created by Shamith Ramdhani on 2021/03/23.
//

import Foundation

struct FriendsRequestModel {
    var guid = ""
    var firstName = ""
    
    func dictionaryRepresentation() -> [String: String] {
        return ["uniqueID": self.guid, "name": self.firstName]
    }
}
