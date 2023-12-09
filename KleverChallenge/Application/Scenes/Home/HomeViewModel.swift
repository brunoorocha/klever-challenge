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
    
    var season: String {
        "\(Season.current) \(currentYear)".capitalized
    }
    
    private let currentYear = Calendar.current.component(.year, from: .now)
    
    init(repository: AnimeRepository = APIAnimeRepository()) {
        self.repository = repository
    }
    
    @MainActor
    func loadAnimes() async {
        isLoading = true
        isShowingError = false
        defer {
            isLoading = false
        }

        do {
            let animes = try await repository.animes(fromSeason: .current, ofYear: currentYear)
            self.animes = animes.map {
                AnimeListItemViewModel(model: $0)
            }
        } catch {
            isShowingError = true
            print(error)
        }
    }
}
