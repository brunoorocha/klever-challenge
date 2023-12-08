//
//  AnimeDetailsViewModel.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 08/12/23.
//

import SwiftUI

class AnimeDetailsViewModel: ObservableObject {
    private let imageRepository: ImageRepository
    let model: Anime
    
    var title: String {
        model.title
    }
    
    var episodeCount: String? {
        guard let episodeCount = model.episodeCount else { return nil }
        return "\(episodeCount) episodes".uppercased()
    }
    
    var status: String {
        model.status.uppercased()
    }
    
    var type: String {
        model.type.uppercased()
    }
    
    var synopsis: String {
        model.synopsis ?? "No synopsys availabe."
    }

    @Published var posterImage: UIImage?
    
    init(model: Anime, imageRepository: ImageRepository = CachedImageRepository()) {
        self.model = model
        self.imageRepository = imageRepository
        Task {
            await loadPosterImage()
        }
    }

    @MainActor
    func loadPosterImage() async {
        do {
            guard let posterImageURL = model.posterImageURL, let url = URL(string: posterImageURL) else { return }
            let data = try await imageRepository.loadImageData(fromURL: url)
            posterImage = UIImage(data: data)
        } catch {
            print(error)
        }
    }
}
