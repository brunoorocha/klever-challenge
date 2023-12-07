//
//  CachedImageRepository.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import Foundation

final class CachedImageRepository {
    private let remoteImageRepository: RemoteImageRepository
    private let localImageRepository: LocalImageRepository
    
    init(
        remoteImageRepository: RemoteImageRepository = RemoteImageRepository(),
        localImageRepository: LocalImageRepository = LocalImageRepository()
    ) {
        self.remoteImageRepository = remoteImageRepository
        self.localImageRepository = localImageRepository
    }
}

extension CachedImageRepository: ImageRepository {
    func loadImageData(fromURL url: URL) async throws -> Data {
        if let localImageData = try? await localImageRepository.loadImageData(fromURL: url) {
            return localImageData
        }
        let remoteImageData = try await remoteImageRepository.loadImageData(fromURL: url)
        localImageRepository.storeImageData(remoteImageData, fromURL: url)
        return remoteImageData
    }
}
