//
//  HTTPService.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import Foundation

protocol HTTPService {
    func request<T: Decodable>(_ urlRequest: URLRequest) async throws -> T
    func requestData(fromURL url: URL) async throws -> Data
}

enum HTTPServiceError: Error {
    case invalidRequest
    case requestFailed(statusCode: Int)
}
