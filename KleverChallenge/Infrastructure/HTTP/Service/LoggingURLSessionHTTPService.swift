//
//  LoggingURLSessionHTTPService.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 13/12/23.
//

import Foundation

final class LoggingURLSessionHTTPService {
    private let service: URLSessionHTTPService
    
    init(service: URLSessionHTTPService = URLSessionHTTPService()) {
        self.service = service
    }
    
    private func log(for urlRequest: URLRequest) {
        guard let method = urlRequest.httpMethod,
              let url = urlRequest.url?.absoluteString
        else { return }
        print("[networking]: \(method.uppercased()) to \(url)")
    }
    
    private func log(for url: URL) {
        print("[networking]: GET data from \(url.absoluteString)")
    }
}

extension LoggingURLSessionHTTPService: HTTPService {
    func request<T>(_ urlRequest: URLRequest) async throws -> T where T : Decodable {
        log(for: urlRequest)
        return try await service.request(urlRequest)
    }
    
    func requestData(fromURL url: URL) async throws -> Data {
        log(for: url)
        return try await service.requestData(fromURL: url)
    }
}

extension HTTPService where Self == LoggingURLSessionHTTPService {
    static var loggingHTTPService: Self {
        return LoggingURLSessionHTTPService()
    }
}
