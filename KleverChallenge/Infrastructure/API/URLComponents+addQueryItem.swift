//
//  URLComponents+addQueryItem.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import Foundation

extension URLComponents {
    mutating func addQueyItem(named name: String, value: CustomStringConvertible) {
        var queryItems = self.queryItems ?? []
        queryItems.append(.init(name: name, value: value.description))
        self.queryItems = queryItems
    }
}
