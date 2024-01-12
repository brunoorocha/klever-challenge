//
//  MyListViewModel.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 08/12/23.
//

import SwiftUI
import Combine

class MyListViewModel: ObservableObject {
    private let myListRepository: MyListRepository
    
    @Published var animes = [AnimeListItemViewModel]()
    
    @Published var selectedSorting = Sorting.ascending
    
    var sortingOptions = Sorting.allCases
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(myListRepository: MyListRepository = CoreDataMyListRepository()) {
        self.myListRepository = myListRepository
        subscribe()
    }
    
    private func subscribe() {
        $selectedSorting
            .sink {
                self.sort(selectedSorting: $0)
            }
            .store(in: &subscriptions)
    }
    
    func loadMyList() {
        animes = myListRepository.myList().map {
            AnimeListItemViewModel(model: $0)
        }
        sort(selectedSorting: selectedSorting)
    }
    
    func sort(selectedSorting: Sorting) {
        switch selectedSorting {
        case .ascending:
            animes = animes.sorted { $0.title < $1.title }
        case .descending:
            animes = animes.sorted { $0.title > $1.title }
        }
    }
}

extension MyListViewModel {
    enum Sorting: String, Identifiable, CaseIterable {
        var id: Self { self }
        case ascending = "name ascending"
        case descending = "name descending"
    }
}
