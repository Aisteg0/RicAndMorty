//
//  Animation.swift
//  testApi
//
//  Created by Михаил Ганин on 05.03.2025.
//

import UIKit

class Animation: NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval = 0.5

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        guard let toViewController = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }

        toViewController.view.alpha = 0
        toViewController.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        containerView.addSubview(toViewController.view)

        UIView.animate(withDuration: duration, animations: {
            toViewController.view.alpha = 1
            toViewController.view.transform = CGAffineTransform.identity
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
