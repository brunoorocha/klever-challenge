//
//  APIRequest.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import Foundation

protocol APIRequest {
    var baseURL: String { get }
    var endpoint: String { get }
    var params: [String: String] { get }
    var urlRequest: URLRequest? { get }
}

extension APIRequest {
    var params: [String : String] { [:] }

    var urlRequest: URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path += endpoint
        params.forEach { (key, value) in
            urlComponents.addQueyItem(named: key, value: value)
        }
        guard let url = urlComponents.url else { return nil }
        return URLRequest(url: url)
    }
}

extension HTTPService {
    func request<T: Decodable>(_ request: APIRequest) async throws -> T {
        guard let urlRequest = request.urlRequest else {
            throw Error.invalidRequest
        }
        return try await self.request(urlRequest)
    }
}
