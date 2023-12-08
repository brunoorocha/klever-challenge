//
//  MyListRepository.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 08/12/23.
//

import Foundation

protocol MyListRepository {
    func myList() -> [Anime]
    func add(anime: Anime)
    func remove(anime: Anime)
}
