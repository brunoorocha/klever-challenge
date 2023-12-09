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
        case january = 1
        case may = 4
        case august = 8
        case december = 12
    }

    func testSeasonForMonth_ShouldReturnCorrectSeasonForMonth() {
        XCTAssertEqual(Season.seasonFor(month: Months.january.rawValue), .winter)
        XCTAssertEqual(Season.seasonFor(month: Months.may.rawValue), .spring)
        XCTAssertEqual(Season.seasonFor(month: Months.august.rawValue), .summer)
        XCTAssertEqual(Season.seasonFor(month: Months.december.rawValue), .fall)
    }
}
