//
//  AnimeDetailsViewModel.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 08/12/23.
//

import SwiftUI

class AnimeDetailsViewModel: ObservableObject {
    private let imageRepository: ImageRepository
    private let myListRepository: MyListRepository
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
    @Published var isInMyList = false
    @Published var isShowingSnackBar = false
    @Published var snackBarMessage = ""
    
    init(
        model: Anime,
        imageRepository: ImageRepository = CachedImageRepository(),
        myListRepository: MyListRepository = CoreDataMyListRepository()
    ) {
        self.model = model
        self.imageRepository = imageRepository
        self.myListRepository = myListRepository
        verifyIfItsInMyList()
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
    
    func verifyIfItsInMyList() {
        isInMyList = myListRepository.isInMyList(anime: model)
    }
    
    func didTapOnMyListButton() {
        isInMyList.toggle()
        showSnackBar()
        if isInMyList {
            myListRepository.add(anime: model)
            return
        }
        myListRepository.remove(anime: model)
    }
    
    func showSnackBar() {
        isShowingSnackBar = true
        snackBarMessage = isInMyList ? "Added to My List" : "Removed from My List"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isShowingSnackBar = false
        }
    }
}
