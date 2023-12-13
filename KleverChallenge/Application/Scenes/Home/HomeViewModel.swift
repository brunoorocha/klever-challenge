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
    @Published var hasNoMoreResults = false
    
    var season: String {
        "\(Season.current) \(currentYear)".capitalized
    }
    
    private let currentYear = Calendar.current.component(.year, from: .now)
    
    init(repository: AnimeRepository = APIAnimeRepository()) {
        self.repository = repository
    }
    
    @MainActor
    func loadAnimes() async {
        if hasNoMoreResults || isLoading {
            return
        }
        isLoading = true
        isShowingError = false
        defer {
            isLoading = false
        }

        do {
            let resultQuantity = 10
            let results = try await repository.animes(fromSeason: .current, ofYear: currentYear, quantity: resultQuantity, startingFrom: animes.count)
            let animes = results.map {
                AnimeListItemViewModel(model: $0)
            }
            hasNoMoreResults = animes.isEmpty || animes.count < resultQuantity
            self.animes.append(contentsOf: animes)
        } catch {
            isShowingError = true
            print(error)
        }
    }
}
