//
//  Anime+mock.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import Foundation

extension Anime {
    static var mock: Anime {
        return .init(
            id: "1234",
            title: "Shingeki no Kyojin: The Final Season Kanketsu-Hen (Kouhen)",
            synopsis: "Eren has become the Doomsday Titan and marches into Fort Salta with countless Titans. Mikasa, Armin, Jean, Connie, Reiner, Pieck, and Levi, who narrowly escaped the Rumbling, appear before the refugees in the depths of despair. The battle between Eren and his former comrades and childhood friends comes to an end here.\n\n(Source: Official Site, edited)",
            coverImageURL: "https://media.kitsu.io/anime/47132/poster_image/large-6359717481b255b5249614e996022afd.jpeg",
            posterImageURL: "https://media.kitsu.io/anime/47132/poster_image/small-6359717481b255b5249614e996022afd.jpeg",
            episodeCount: 12,
            status: "current"
        )
    }
}
