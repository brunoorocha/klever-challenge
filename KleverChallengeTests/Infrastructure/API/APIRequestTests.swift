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
        let urlRequest = apiRequest.urlRequest
        
        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest!.url!.absoluteString, "https://www.my-api.com/resources?param2=123&param1=value")
    }
}
