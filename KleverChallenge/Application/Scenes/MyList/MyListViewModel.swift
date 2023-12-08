//
//  MyListViewModel.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 08/12/23.
//

import SwiftUI

class MyListViewModel: ObservableObject {
    private let myListRepository: MyListRepository
    
    @Published var animes = [AnimeListItemViewModel]()
    
    init(myListRepository: MyListRepository = CoreDataMyListRepository()) {
        self.myListRepository = myListRepository
    }
    
    func loadMyList() {
        animes = myListRepository.myList().map {
            AnimeListItemViewModel(model: $0)
        }
    }
}
