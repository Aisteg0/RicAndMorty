//
//  CharacterDetailView.swift
//  testApi
//
//  Created by Михаил Ганин on 05.03.2025.
//

import SwiftUI

struct CharacterDetailView: UIViewControllerRepresentable {
    let character: Results

    func makeUIViewController(context: Context) -> DetailViewController {
        let viewController = DetailViewController()
        viewController.character = character

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.delegate = context.coordinator

        return viewController
    }

    func updateUIViewController(_ uiViewController: DetailViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, UINavigationControllerDelegate {
        var animator = Animation()

        func navigationController(
            _ navigationController: UINavigationController,
            animationControllerFor operation: UINavigationController.Operation,
            from fromVC: UIViewController,
            to toVC: UIViewController
        ) -> UIViewControllerAnimatedTransitioning? {
            return animator
        }
    }
}
