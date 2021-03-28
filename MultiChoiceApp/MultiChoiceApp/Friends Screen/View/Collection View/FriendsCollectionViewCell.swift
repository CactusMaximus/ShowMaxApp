//
//  FriendsCollectionViewCell.swift
//  MultiChoiceApp
//
//  Created by Shamith Ramdhani on 2021/03/27.
//

import UIKit

protocol FriendsCollectionViewCellDelegate {
    func infoTapped(index: Int)
}

class FriendsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var aliasLabel: UILabel!
    @IBOutlet var lastSeenLabel: UILabel!
    private var delegate: FriendsCollectionViewCellDelegate?
    private(set) var index: Int?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func populate(with contentModel: FriendCollectionViewCellContentModel,
                         delegate: FriendsCollectionViewCellDelegate,
                         index: Int) {
        aliasLabel.text = contentModel.alias
        lastSeenLabel.text = "Last seen: \(contentModel.lastSeenLabel)"
        self.delegate = delegate
        self.index = index
    }
    
    public func updateImage(image: UIImage) {
        backgroundImageView.image = image
    }
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        self.delegate?.infoTapped(index: index ?? 0)
    }
}

struct FriendCollectionViewCellContentModel {
    var alias = ""
    var lastSeenLabel = ""
}
