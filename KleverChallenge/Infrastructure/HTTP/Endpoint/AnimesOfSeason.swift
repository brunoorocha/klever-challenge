//
//  AnimesOfSeason.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import Foundation

struct AnimesOfSeason {
    let season: Season
    let year: Int
    let pageLimit: Int
    let pageOffset: Int
}

extension AnimesOfSeason: APIRequest {
    var baseURL: String { "https://kitsu.io/api/edge" }
    
    var endpoint: String { "/anime" }
    
    var params: [String : String] {
        [
            "filter[season]" : season.rawValue,
            "filter[seasonYear]" : String(year),
            "page[limit]" : String(pageLimit),
            "page[offset]" : String(pageOffset),
        ]
    }
}

extension APIRequest where Self == AnimesOfSeason {
    static func animes(fromSeason season: Season, ofYear year: Int, quantity: Int, startingFrom: Int) -> Self {
        AnimesOfSeason(season: season, year: year, pageLimit: quantity, pageOffset: startingFrom)
    }
}
