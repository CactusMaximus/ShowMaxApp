//
//  LoginRequestModel.swift
//  MultiChoiceApp
//
//  Created by Shamith Ramdhani on 2021/03/23.
//

import Foundation

struct LoginRequestModel {
    var username = ""
    var password = ""
    
    func dictionaryRepresentation() -> [String: String] {
        return ["username": self.username, "password": self.password]
    }
}
