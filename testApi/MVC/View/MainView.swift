//
//  MainView.swift
//  testApi
//
//  Created by Михаил Ганин on 19.02.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var controller = CharacterController()
    
    var body: some View {
        NavigationView {
            List(controller.characters) { character in
                HStack(alignment: .top, spacing: Constants.Sizes.HStackSpacing) {
                    NavigationLink(destination: CharacterDetailView(character: character)) {
                        if let imageUrl = character.image, let url = URL(string: imageUrl) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: Constants.Sizes.imageWidth, height: Constants.Sizes.imageHeight)
                                        .cornerRadius(Constants.Sizes.cornerRadius)
                                        .padding(.trailing, Constants.Sizes.trailingPadding)
                                        .padding(.top, Constants.Sizes.topPadding)
                                case .failure:
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: Constants.Sizes.smallImageSize, height: Constants.Sizes.smallImageSize)
                                        .foregroundColor(.gray)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: Constants.Sizes.smallImageSize, height: Constants.Sizes.smallImageSize)
                            .padding(.trailing, Constants.Sizes.trailingPaddingFrame)
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: Constants.Sizes.smallImageSize, height: Constants.Sizes.smallImageSize)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: Constants.Sizes.textSpacing) {
                        Text(character.name ?? "Unknown")
                            .font(.headline)
                        Text("\(character.species ?? "Unknown"), \(character.gender ?? "Unknown")")
                            .font(.subheadline)
                        Text(character.origin?.name ?? "Unknown")
                    }
                    Spacer()
                    Text(character.status ?? "Unknown status")
                        .frame(width: Constants.Sizes.statusWidth, height: Constants.Sizes.statusHeight)
                        .font(.caption)
                        .foregroundColor(statusColor(for: character.status ?? "Unknown"))
                        .background(statusColorBackgrond(for: character.status ?? ""))
                        .cornerRadius(Constants.Sizes.statusCornerRadius)
                        
                }
                .padding(.vertical, Constants.Sizes.verticalPadding)
            }
            .navigationTitle("Characters")
            .onAppear {
                controller.fetchCharacters()
            }
            .overlay {
                if controller.isLoading {
                    ProgressView()
                }
                if let errorMessage = controller.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
        }
    }
    
    private func openURL(_ url: URL) {
        UIApplication.shared.open(url)
    }
    
    func statusColor(for status: String) -> Color {
        switch status {
        case "Alive":
            return Constants.StatusColors.aliveText
        case "Dead":
            return Constants.StatusColors.deadText
        default:
            return Constants.StatusColors.unknownText
        }
    }
    
    func statusColorBackgrond(for status: String) -> Color {
        switch status {
        case "Alive":
            return Constants.StatusColors.aliveBackground
        case "Dead":
            return Constants.StatusColors.deadBackground
        default:
            return Constants.StatusColors.unknownBackground
        }
    }
}

private struct Constants {
    // Цвета для статусов
    struct StatusColors {
        static let aliveText = Color.green
        static let deadText = Color.red
        static let unknownText = Color(red: 160/255, green: 160/255, blue: 160/255)
        
        static let aliveBackground = Color(red: 199/255, green: 1, blue: 185/255)
        static let deadBackground = Color(red: 1, green: 232/255, blue: 224/255)
        static let unknownBackground = Color(red: 238/255, green: 238/255, blue: 238/255)
    }
    
    // Размеры и отступы
    struct Sizes {
        static let imageWidth: CGFloat = 120
        static let imageHeight: CGFloat = 120
        static let cornerRadius: CGFloat = 20
        static let smallImageSize: CGFloat = 60
        static let statusWidth: CGFloat = 56
        static let statusHeight: CGFloat = 25
        static let statusCornerRadius: CGFloat = 25
        static let verticalPadding: CGFloat = 8
        static let horizontalSpacing: CGFloat = 15
        static let trailingPadding: CGFloat = -40
        static let topPadding: CGFloat = 35
        static let textSpacing: CGFloat = 8
        static let trailingPaddingFrame: CGFloat = 12
        static let HStackSpacing: CGFloat = 15
    }
}

#Preview {
    MainView()
}
