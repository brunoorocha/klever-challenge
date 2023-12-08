//
//  APIRequestTests.swift
//  KleverChallengeTests
//
//  Created by Bruno Rocha on 07/12/23.
//

import XCTest
@testable import KleverChallenge

final class APIRequestTests: XCTestCase {
    struct MockAPIRequest: APIRequest {
        var baseURL = "https://www.my-api.com"
        var endpoint = "/resources"
        var params: [String : String] {
            ["param1" : "value", "param2" : "123"]
        }
    }

    func testAPIRequest_WhenPropertiesAreValid_ShouldCreateRequest() {
        let apiRequest = MockAPIRequest()
        let urlComponents = URLComponents(url: apiRequest.urlRequest!.url!, resolvingAgainstBaseURL: true)!
        let queryItemsDictionary = Dictionary(uniqueKeysWithValues: urlComponents.queryItems!.map { ($0.name, $0.value!) })
        
        XCTAssertEqual(queryItemsDictionary.count, apiRequest.params.count)
        XCTAssertEqual(queryItemsDictionary, apiRequest.params)
    }
}
