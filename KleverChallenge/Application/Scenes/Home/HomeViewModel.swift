//
//  HomeViewModel.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    private let repository: AnimeRepository

    @Published var animes = [AnimeListItemViewModel]()
    @Published var isLoading = false
    @Published var isShowingError = false
    
    init(repository: AnimeRepository = APIAnimeRepository()) {
        self.repository = repository
    }
    
    @MainActor
    func loadAnimes() async {
        isLoading = true
        defer {
            isLoading = false
        }

        do {
            let animes = try await repository.animes(fromSeason: .current, ofYear: 2023)
            self.animes = animes.map(AnimeListItemViewModel.init(model:))
        } catch {
            isShowingError = true
            print(error)
        }
    }
}
