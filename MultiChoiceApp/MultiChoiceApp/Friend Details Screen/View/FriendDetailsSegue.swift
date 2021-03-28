//
//  FriendDetailsSegue.swift
//  MultiChoiceApp
//
//  Created by Shamith Ramdhani on 2021/03/28.
//

import UIKit

class FriendDetailsSegue: UIStoryboardSegue {
    
    override func perform() {
        let firstView = self.source.view!
        let secondView = self.destination.view!
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        secondView.frame = CGRect(x: 0.0, y: screenHeight, width: screenWidth, height: screenHeight)
        secondView.alpha = 0
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            firstView.transform = secondView.transform.scaledBy(x: 0.001, y: 0.001)
        }) { (Finished) -> Void in
            UIView.animate(withDuration: 3, animations: { () -> Void in
                secondView.alpha = 1
                self.source.present(self.destination as UIViewController, animated: false, completion: nil)
            }, completion: { (Finished) -> Void in
                UIView.animate(withDuration: 1) {
                    firstView.transform = CGAffineTransform.identity
                }
            })
        }
    }
}
