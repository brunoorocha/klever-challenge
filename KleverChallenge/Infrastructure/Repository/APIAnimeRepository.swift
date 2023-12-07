//
//  APIAnimeRepository.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import Foundation

final class APIAnimeRepository {
    private let service: APIService
    
    init(service: APIService) {
        self.service = service
    }
}

extension APIAnimeRepository: AnimeRepository {
    func animes(fromSeason season: Season, ofYear year: Int) async throws -> [Anime] {
        let response = try await service.request(.animes(fromSeason: season, ofYear: year)) as AnimeListResponse
        return response.animes
    }
}
