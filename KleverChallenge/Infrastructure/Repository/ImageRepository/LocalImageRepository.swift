//
//  LocalImageRepository.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import Foundation

final class LocalImageRepository {
    private let fileManager = FileManager.default
    
    func storeImageData(_ data: Data, fromURL url: URL) {
        guard let localImageURL = localImageURL(forRemoteURL: url) else { return }
        do {
            if fileManager.fileExists(atPath: localImageURL.path()) {
                try fileManager.removeItem(atPath: localImageURL.path())
            }
            try data.write(to: localImageURL)
        } catch {
            print(error)
        }
    }
    
    private func localImageURL(forRemoteURL url: URL) -> URL? {
        if fileManager.fileExists(atPath: url.path()) {
            return url
        }
        guard let generatedName = generateLocalImageName(forURL: url),
              let cachesDirectoryPath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
        else {
            return nil
        }
        return cachesDirectoryPath.appendingPathComponent(generatedName)
    }
    
    private func generateLocalImageName(forURL url: URL) -> String? {
        let nameMaxLenght = 50
        guard let generatedName = url.absoluteString.data(using: .utf8)?.base64EncodedString() else { return nil }
        if generatedName.count <= nameMaxLenght {
            return generatedName
        }
        return String(generatedName.dropLast(nameMaxLenght))
    }
}

extension LocalImageRepository: ImageRepository {
    enum Error: Swift.Error {
        case imageNotFound
        case failedToLoad
    }

    func loadImageData(fromURL url: URL) async throws -> Data {
        guard let localURL = localImageURL(forRemoteURL: url), fileManager.fileExists(atPath: localURL.path()) else {
            throw Error.imageNotFound
        }
        guard let data = try? Data(contentsOf: localURL) else {
            throw Error.failedToLoad
        }
        return data
    }
}
