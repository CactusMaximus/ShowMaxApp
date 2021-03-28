//
//  FriendsViewModel.swift
//  MultiChoiceApp
//
//  Created by Shamith Ramdhani on 2021/03/23.
//

import Foundation
import UIKit

protocol FriendsViewModelDelegate: AnyObject {
    func refreshFriendList()
    func showError(message: String)
    func stopLoadingIndicator()
}

class FriendsViewModel {
    
    private weak var delegate: FriendsViewModelDelegate?
    private var friendsService: FriendsServiceContract?
    private var dataTransportModel: ApplicationTransportModel?
    private(set) var friendsResponse: FriendsResponseModel?
    private(set) var selectedFriendDetails: FriendDetails?
    private var task: URLSessionDownloadTask!
    private var session: URLSession!
    private var totalImagesDownloaded = 0
    
    init(delegate: FriendsViewModelDelegate,
         dataTransportModel: ApplicationTransportModel,
         friendsService: FriendsServiceContract) {
        self.delegate = delegate
        self.dataTransportModel = dataTransportModel
        self.friendsService = friendsService
        session = URLSession.shared
        task = URLSessionDownloadTask()
    }
    
    func fetchFriendList() {
        let requestModel = FriendsRequestModel(guid: dataTransportModel?.loginDetails?.guid ?? "",
                                               firstName: dataTransportModel?.loginDetails?.firstName ?? "")
        friendsService?.fetchFriends(requestModel: requestModel,
                                     successBlock: { (friendsResponseModel) in
                                        self.friendsResponse = friendsResponseModel
                                        self.pullImages()
                                     }, failureBlock: { (error) in
                                        self.delegate?.showError(message:error.description)
                                     })
    }
    
    func friendCollectionViewCellContentModel(row: Int) -> FriendCollectionViewCellContentModel {
        var contentModel = FriendCollectionViewCellContentModel()
        let friendModel = friendsResponse?.friends[row]
        if let friend = friendModel {
            contentModel = FriendCollectionViewCellContentModel(alias: friend.alias,
                                                                lastSeenLabel: friend.status)
        }
        return contentModel
    }
    
    func setSelectedFriend(index: Int) {
        self.selectedFriendDetails = friendsResponse?.friends[index] ?? FriendDetails(dictionary: [String : String]())
    }
    
    private func pullImages() {
        if let friends = friendsResponse?.friends {
            for index in 0..<friends.count {
                getImage(url: friends[index].imageURL, index: index)
            }
        }
    }
    
    private func getImage(url: String, index: Int) {
        let url:URL! = URL(string: url)
        task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
            if let data = try? Data(contentsOf: url){
                DispatchQueue.main.async(execute: { () -> Void in
                    let image: UIImage! = UIImage(data: data)
                    if image.size.width > 100 {
                        guard let compressedImageData = image.jpegData(compressionQuality: 0.1) else { return }
                        self.friendsResponse?.friends[index].image = UIImage(data: compressedImageData) ?? UIImage()
                    } else {
                        self.friendsResponse?.friends[index].image = image
                    }
                    DispatchQueue.main.async {
                        self.delegate?.refreshFriendList()
                        self.totalImagesDownloaded += 1
                        if self.totalImagesDownloaded == self.friendsResponse?.friends.count {
                            self.delegate?.stopLoadingIndicator()
                        }
                    }
                    
                })
            }
        })
        task.resume()
    }
}
