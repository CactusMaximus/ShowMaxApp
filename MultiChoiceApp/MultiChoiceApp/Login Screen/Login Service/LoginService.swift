//
//  LoginService.swift
//  MultiChoiceApp
//
//  Created by Shamith Ramdhani on 2021/03/23.
//

import Foundation

typealias LoginServiceSuccessBlock = (LoginResponseModel) -> Void
typealias GenericFailureBlock = (String) -> Void

protocol LoginServiceContract {
    func performLogin(requestModel: LoginRequestModel,
                      successBlock: @escaping LoginServiceSuccessBlock,
                      failureBlock: @escaping GenericFailureBlock)
}

class LoginService: LoginServiceContract {
    
    let session = URLSession.shared
    var request = URLRequest(url: URL(string: "http://mobileexam.dstv.com/login")!)
    
    func performLogin(requestModel: LoginRequestModel,
                      successBlock: @escaping LoginServiceSuccessBlock,
                      failureBlock: @escaping GenericFailureBlock) {
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestModel.dictionaryRepresentation(),
                                                          options: .prettyPrinted)
        } catch {
           failureBlock("Failed to serialise")
        }
        
        let task = session.dataTask(with: request as URLRequest,
                                    completionHandler: { data, response, error in
            guard error == nil else {
                failureBlock("Cannot connect, please check your internet connection")
                return
            }
            guard let data = data else {
                return
            }
                                        
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    successBlock(LoginResponseModel(dictionary: json))
                }
            } catch {
                failureBlock("Deserialisation error")
            }
                                        
        })
        task.resume()
    }
}
