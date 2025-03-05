//
//  DetailViewController.swift
//  testApi
//
//  Created by Михаил Ганин on 05.03.2025.
//

import UIKit

class DetailViewController: UIViewController {
    var character: Results?
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let statusLabel = UILabel()
    private let speciesLabel = UILabel()
    private let genderLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        configure(with: character)
    }
    
    private func setupUI() {
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        nameLabel.font = UIFont.systemFont(ofSize: Constants.size24, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        statusLabel.font = UIFont.systemFont(ofSize: Constants.size18)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusLabel)
        
        speciesLabel.font = UIFont.systemFont(ofSize: Constants.size18)
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(speciesLabel)
        
        genderLabel.font = UIFont.systemFont(ofSize: Constants.size18)
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(genderLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.size20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constants.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.heightAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.size20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.size10),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            speciesLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: Constants.size10),
            speciesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            genderLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: Constants.size10),
            genderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func configure(with character: Results?) {
        guard let character = character else { return }
        
        if let imageUrl = character.image, let url = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }.resume()
        }
        
        nameLabel.text = character.name
        statusLabel.text = "Status: \(character.status ?? "Unknown")"
        speciesLabel.text = "Species: \(character.species ?? "Unknown")"
        genderLabel.text = "Gender: \(character.gender ?? "Unknown")"
        
        
        if character.status?.lowercased() == "dead" {
            colorForDead()
        } else if character.status?.lowercased() == "alive" {
            colorForAlive()
        } else {
            colorForUnknown()
        }
    }
    private func colorForAlive() {
        view.backgroundColor = .green
        nameLabel.textColor = .black
        statusLabel.textColor = .black
        speciesLabel.textColor = .black
        genderLabel.textColor = .black
    }
    
    private func colorForDead() {
        view.backgroundColor = .darkGray
        nameLabel.textColor = .white
        statusLabel.textColor = .red
        speciesLabel.textColor = .white
        genderLabel.textColor = .white
    }
    
    private func colorForUnknown() {
        view.backgroundColor = .white
        nameLabel.textColor = .black
        statusLabel.textColor = .gray
        speciesLabel.textColor = .black
        genderLabel.textColor = .black
        
    }
}

private struct Constants {
    static let size10: CGFloat = 10
    static let size18: CGFloat = 18
    static let size20: CGFloat = 20
    static let size24: CGFloat = 24
    static let widthAnchor: CGFloat = 200
    static let heightAnchor: CGFloat = 200
}
