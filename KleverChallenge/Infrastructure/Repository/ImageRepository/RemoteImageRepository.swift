//
//  RemoteImageRepository.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import Foundation

final class RemoteImageRepository {
    private let service: HTTPService
    
    init(service: HTTPService = .loggingHTTPService) {
        self.service = service
    }
}

extension RemoteImageRepository: ImageRepository {
    func loadImageData(fromURL url: URL) async throws -> Data {
        return try await service.requestData(fromURL: url)
    }
}
