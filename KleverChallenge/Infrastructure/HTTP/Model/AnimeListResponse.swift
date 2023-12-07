//
//  AnimeListResponse.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import Foundation

struct AnimeListResponse {
    let animes: [Anime]
}

extension AnimeListResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case animes = "data"
    }
}
