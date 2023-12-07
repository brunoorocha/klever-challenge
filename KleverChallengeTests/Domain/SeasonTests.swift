//
//  SeasonTests.swift
//  KleverChallengeTests
//
//  Created by Bruno Rocha on 07/12/23.
//

import XCTest
@testable import KleverChallenge

final class SeasonTests: XCTestCase {
    enum Months: Int {
        case january = 0
        case may = 3
        case august = 7
        case november = 10
    }

    func testSeasonForMonth_ShouldReturnCorrectSeasonForMonth() {
        XCTAssertEqual(Season.seasonFor(month: Months.january.rawValue), .winter)
        XCTAssertEqual(Season.seasonFor(month: Months.may.rawValue), .spring)
        XCTAssertEqual(Season.seasonFor(month: Months.august.rawValue), .summer)
        XCTAssertEqual(Season.seasonFor(month: Months.november.rawValue), .fall)
    }
}
