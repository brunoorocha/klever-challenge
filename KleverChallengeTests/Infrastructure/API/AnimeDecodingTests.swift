//
//  AnimeDecodingTests.swift
//  KleverChallengeTests
//
//  Created by Bruno Rocha on 07/12/23.
//

import XCTest
@testable import KleverChallenge

final class AnimeDecodingTests: XCTestCase {
    func testAnimeDecoding_ShouldDecodeCorrectly() {
        let data = readJSONFile(named: "animes")!
        do {
            let response = try JSONDecoder().decode(AnimeListResponse.self, from: data)
            XCTAssertFalse(response.animes.isEmpty)
        } catch {
            print(error)
            XCTFail(error.localizedDescription)
        }
    }
}
