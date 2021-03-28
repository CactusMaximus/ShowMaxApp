//
//  FriendsService.swift
//  MultiChoiceApp
//
//  Created by Shamith Ramdhani on 2021/03/23.
//

import Foundation

typealias FriendsServiceSuccessBlock = (FriendsResponseModel) -> Void

protocol FriendsServiceContract {
    func fetchFriends(requestModel: FriendsRequestModel,
                      successBlock: @escaping FriendsServiceSuccessBlock,
                      failureBlock: @escaping GenericFailureBlock)
}

class FriendsService: FriendsServiceContract {
    
    let session = URLSession.shared
    var request = URLRequest(url: URL(string: "http://mobileexam.dstv.com/friends.php?uniqueID=3f2504e0-4f89-11d3-9a0c-0305e82c3301;name=John")!)
    
    func fetchFriends(requestModel: FriendsRequestModel,
                      successBlock: @escaping FriendsServiceSuccessBlock,
                      failureBlock: @escaping GenericFailureBlock) {
        request.httpMethod = "GET"
        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: requestModel.dictionaryRepresentation(),
//                                                          options: .prettyPrinted)
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
                    successBlock(FriendsResponseModel(dictionary: json))
                }
            } catch {
                failureBlock("Deserialisation error")
            }
                                        
        })
        task.resume()
    }
}
