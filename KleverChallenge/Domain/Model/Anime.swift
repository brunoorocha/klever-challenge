//
//  Anime.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import Foundation

struct Anime: Hashable, Equatable {
    let id: String
    let title: String
    let synopsis: String?
    let coverImageURL: String?
    let posterImageURL: String?
    let episodeCount: Int?
    let status: String
    let type: String
}
