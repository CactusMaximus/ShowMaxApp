//
//  FriendDetailsAnimator.swift
//  MultiChoiceApp
//
//  Created by Shamith Ramdhani on 2021/03/28.
//

import UIKit

class FriendDetailsAnimator: NSObject {

}

extension FriendDetailsAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let toVC = transitionContext.viewController(forKey: .to) as? FriendDetailsViewController,
            let fromVC = transitionContext.viewController(forKey: .from) as? FriendsViewController else {
            return
        }
        
        let toView = transitionContext.view(forKey: .to)
        
        if let view = toView {
            transitionContext.containerView.addSubview(view)
        }
        
        toView?.frame = fromVC.friendsCollectionView.frame
        toView?.layoutIfNeeded()
        
        let duration = transitionDuration(using: transitionContext)
        let frame = transitionContext.finalFrame(for: toVC)
        toVC.aliasLabel.alpha = 0.0
        
        UIView.animate(withDuration: duration, animations: {
            toVC.aliasLabel.alpha = 1.0
            toView?.frame = frame
            toView?.layoutIfNeeded()
        }) { (success) in
            transitionContext.completeTransition(true)
        }
    }
}
