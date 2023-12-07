//
//  AnimeListItem.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import SwiftUI

class AnimeListItemViewModel: Identifiable, ObservableObject {
    private let model: Anime
    private let repository: ImageRepository

    let id = UUID()
    
    var title: String {
        model.title
    }

    @Published var posterImage: UIImage?
    
    init(model: Anime, repository: ImageRepository = RemoteImageRepository()) {
        self.model = model
        self.repository = repository
        Task {
            await loadImage()
        }
    }
    
    @MainActor
    func loadImage() async {
        do {
            guard let posterImageURL = model.posterImageURL, let url = URL(string: posterImageURL) else { return }
            let data = try await repository.loadImageData(fromURL: url)
            posterImage = UIImage(data: data)
        } catch {
            print(error)
        }
    }
}
