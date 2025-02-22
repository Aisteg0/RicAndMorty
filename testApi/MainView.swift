//
//  MainView.swift
//  testApi
//
//  Created by Михаил Ганин on 19.02.2025.
//

import SwiftUI
import SafariServices

struct MainView: View {
    @StateObject private var viewModel = CharacterViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.characters) { character in
                HStack(alignment: .top, spacing: 15) {
                    
                    if let imageUrl = character.image, let url = URL(string: imageUrl) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(20)
                                    .padding(.trailing, -40)
                                    .padding(.top, 35)
                            case .failure:
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(width: 60, height: 60)
                        .padding(.trailing, 12)
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(character.name ?? "Unknown")
                            .font(.headline)
                        Text("\(character.species ?? "Unknown"), \(character.gender ?? "Unknown")")
                            .font(.subheadline)
                        if let locationUrlString = character.location?.url,
                           let locationUrl = URL(string: locationUrlString) {
                            Text("Watch episod")
                                .font(.caption)
                                .foregroundColor(Color(red: 255/255, green: 107/255, blue: 0))
                                .background(Color(red: 1, green: 107/255, blue: 0, opacity: 0.1))
                                .cornerRadius(17.5)
                                .onTapGesture {
                                    openURL(locationUrl)
                                }
                        } else {
                            Text(character.location?.name ?? "Unknown location")
                                .font(.caption)
                        }
                        Text(character.origin?.name ?? "Unknown")
                    }
                    Spacer()
                    Text(character.status ?? "Unknown status")
                        .frame(width: 56, height: 25)
                        .font(.caption)
                        .foregroundColor(statusColor(for: character.status ?? "Unknown"))
                        .background(statusColorBackgrond(for: character.status ?? ""))
//                        .background(Color(red: 199/255, green: 1, blue: 185/255))
                        .cornerRadius(25)
                        
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Characters")
            .onAppear {
                viewModel.fetchCharacters()
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
                if let errorMessage = viewModel.errorMessage {
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
            return .green
        case "Dead":
            return .red
        default:
            return Color(red: 160/255, green: 160/255, blue: 160/255)
        }
    }
    
    func statusColorBackgrond(for status: String) -> Color {
        switch status {
        case "Alive":
            return Color(red: 199/255, green: 1, blue: 185/255)
        case "Dead":
            return Color(red: 1, green: 232/255, blue: 224/255)
        default:
            return Color(red: 238/255, green: 238/255, blue: 238/255)
        }
    }
}

#Preview {
    MainView()
}
