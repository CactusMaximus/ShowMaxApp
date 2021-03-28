//
//  LoginResponseModel.swift
//  MultiChoiceApp
//
//  Created by Shamith Ramdhani on 2021/03/23.
//

import Foundation

struct LoginResponseModel {
    var result = 0
    var firstName = ""
    var guid = ""
    var lastName = ""
    var error = ""
    
    init(dictionary: [String: Any]) {
        self.result = dictionary["result"] as? Int ?? 0
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.guid = dictionary["guid"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.error = dictionary["error"] as? String ?? ""
    }
}
