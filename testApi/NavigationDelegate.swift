//
//  NavigationDelegate.swift
//  testApi
//
//  Created by Михаил Ганин on 05.03.2025.
//

import UIKit

class CustomNavigationDelegate: NSObject, UINavigationControllerDelegate {
    private let animator = Animation()

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
}
