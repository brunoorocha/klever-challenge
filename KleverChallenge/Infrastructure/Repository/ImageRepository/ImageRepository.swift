//
//  ImageRepository.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import Foundation

protocol ImageRepository {
    func loadImageData(fromURL url: URL) async throws -> Data
}
