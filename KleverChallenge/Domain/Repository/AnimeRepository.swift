//
//  AnimeRepository.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import Foundation

protocol AnimeRepository {
    func animes(fromSeason season: Season, ofYear year: Int) async throws -> [Anime]
}
