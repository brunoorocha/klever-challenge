//
//  APIService.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import Foundation

final class APIService {
    private let session: URLSession
    
    init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }
    
    func request<T: Decodable>(_ urlRequest: URLRequest) async throws -> T {
        let (data, urlResponse) = try await session.data(for: urlRequest)
        if let httpResponse = urlResponse as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw Error.requestFailed(statusCode: httpResponse.statusCode)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

extension APIService {
    enum Error: Swift.Error {
        case invalidRequest
        case requestFailed(statusCode: Int)
    }
}
