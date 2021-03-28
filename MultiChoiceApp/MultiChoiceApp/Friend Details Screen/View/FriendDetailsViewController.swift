//
//  FriendDetailsViewController.swift
//  MultiChoiceApp
//
//  Created by Shamith Ramdhani on 2021/03/28.
//

import UIKit

class FriendDetailsViewController: UIViewController {
    
    var friendDetails: FriendDetails!
    
    @IBOutlet var friendImageView: UIImageView!
    @IBOutlet var aliasLabel: UILabel!
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    @IBOutlet var birthDateLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateUI()
        logoImageView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateLogo()
    }
    
    private func populateUI() {
        friendImageView.image = friendDetails.image
        aliasLabel.text = "\(friendDetails.alias)"
        firstNameLabel.text = "First name: \(friendDetails.firstName)"
        lastNameLabel.text = "Last name: \(friendDetails.lastName)"
        birthDateLabel.text = "Birth date: \(friendDetails.dateOfBirth)"
        statusLabel.text = "Status: \(friendDetails.status)"
    }
    
    private func animateLogo() {
        UIView.animate(withDuration: 3,
                       delay: 0,
                       options: [.autoreverse,.repeat],
                       animations: {
                        self.logoImageView.alpha = 1
                       })
    }
}
