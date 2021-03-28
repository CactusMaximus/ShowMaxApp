//
//  FriendsViewController.swift
//  MultiChoiceApp
//
//  Created by Shamith Ramdhani on 2021/03/23.
//

import UIKit

class FriendsViewController: UIViewController {
    
    @IBOutlet var friendsCollectionView: UICollectionView!
    
    private var dataTransportModel: ApplicationTransportModel?
    private lazy var viewModel = FriendsViewModel(delegate: self,
                                                  dataTransportModel: self.dataTransportModel ?? ApplicationTransportModel(),
                                                  friendsService: FriendsService())

    func set(dataTransportModel: ApplicationTransportModel) {
        viewModel = FriendsViewModel(delegate: self,
                                     dataTransportModel: dataTransportModel,
                                     friendsService: FriendsService())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsCollectionView.dataSource = self
        friendsCollectionView.delegate = self
        friendsCollectionView.register(UINib.init(nibName: "FriendsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomFriendCell")
        viewModel.fetchFriendList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FriendDetailsSegue" {
            if let destinationViewController = segue.destination as? FriendDetailsViewController {
                destinationViewController.friendDetails = viewModel.selectedFriendDetails
            }
        }
    }
}

extension FriendsViewController: FriendsViewModelDelegate {
    func refreshFriendList() {
        friendsCollectionView.reloadData()
    }
    
    func showErrorMessage() {
        
    }
    
    func refreshFriendImages() {
    
    }
}

extension FriendsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.friendsResponse?.friends.count ?? 0
    }
}

extension FriendsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomFriendCell", for: indexPath) as! FriendsCollectionViewCell
        cell.populate(with: viewModel.friendCollectionViewCellContentModel(row: indexPath.row), delegate: self, index: indexPath.row)
        cell.updateImage(image: viewModel.friendsResponse?.friends[indexPath.row].image ?? UIImage(named: "showMaxLogo")!)
        return cell
    }

}

extension FriendsViewController: FriendsCollectionViewCellDelegate {
    func infoTapped(index: Int) {
        viewModel.setSelectedFriend(index: index)
        performSegue(withIdentifier: "FriendDetailsSegue", sender: self)
    }
}
