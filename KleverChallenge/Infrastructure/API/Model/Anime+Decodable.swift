//
//  Anime+Decodable.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import Foundation

extension Anime: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case attributes

        enum AttributesCodingKeys: String, CodingKey {
            case title = "canonicalTitle"
            case synopsis
            case episodeCount
            case posterImage
            case status
            case type = "showType"
        }

        enum PosterImageCodingKeys: String, CodingKey {
            case posterImageURL = "small"
            case coverImageURL = "large"
        }
    }

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: CodingKeys.self)
        let attributesContainer = try rootContainer.nestedContainer(keyedBy: CodingKeys.AttributesCodingKeys.self, forKey: .attributes)
        let posterImageContainer = try? attributesContainer.nestedContainer(keyedBy: CodingKeys.PosterImageCodingKeys.self, forKey: .posterImage)
        
        id = try rootContainer.decode(String.self, forKey: .id)
        title = try attributesContainer.decode(String.self, forKey: .title)
        synopsis = try attributesContainer.decodeIfPresent(String.self, forKey: .synopsis)
        status = try attributesContainer.decode(String.self, forKey: .status)
        episodeCount = try attributesContainer.decode(Int?.self, forKey: .episodeCount)
        posterImageURL = try posterImageContainer?.decodeIfPresent(String.self, forKey: .posterImageURL)
        coverImageURL = try posterImageContainer?.decodeIfPresent(String.self, forKey: .coverImageURL)
    }
}
