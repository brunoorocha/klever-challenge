//
//  AnimeListItem.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import SwiftUI

class AnimeListItemViewModel: Identifiable, ObservableObject {
    let id = UUID()
    let title: String

    @Published var coverImage: UIImage?
    
    init(model: Anime) {
        title = model.title
    }
}
