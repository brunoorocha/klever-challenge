//
//  HomeViewModelTests.swift
//  KleverChallengeTests
//
//  Created by Bruno Rocha on 08/12/23.
//

import XCTest
@testable import KleverChallenge

final class SpyAnimeRepository: AnimeRepository {
    private(set) var animesFromSeasonCallCount = 0
    private(set) var animesFromSeasonCallParams: (season: Season, year: Int, quantity: Int, startingFrom: Int)?
    var animesFromSeasonMockReturn = [Anime]()
    var animesFromSeasonMockError: Error?

    func animes(fromSeason season: Season, ofYear year: Int, quantity: Int, startingFrom: Int) async throws -> [Anime] {
        animesFromSeasonCallCount += 1
        animesFromSeasonCallParams = (season, year, quantity, startingFrom)
        if let error = animesFromSeasonMockError {
            throw error
        }
        return animesFromSeasonMockReturn
    }
}

final class HomeViewModelTests: XCTestCase {
    var sut: HomeViewModel!
    var spyRepository: SpyAnimeRepository!

    override func setUpWithError() throws {
        spyRepository = SpyAnimeRepository()
        sut = HomeViewModel(repository: spyRepository)
    }

    func testViewModelInitialisation_WhenInit_ShouldCallLoadAnimes() async {
        await sut.loadAnimes()
        
        XCTAssertEqual(spyRepository.animesFromSeasonCallCount, 1)
    }
    
    func testLoadAnimes_WhenLoadAnimes_ShouldCallRepositoryWithRightParams() async {
        let currentYear = Calendar.current.component(.year, from: .now)
        
        await sut.loadAnimes()

        XCTAssertEqual(spyRepository.animesFromSeasonCallParams?.season, .current)
        XCTAssertEqual(spyRepository.animesFromSeasonCallParams?.year, currentYear)
        XCTAssertEqual(spyRepository.animesFromSeasonCallParams?.quantity, 10)
        XCTAssertEqual(spyRepository.animesFromSeasonCallParams?.startingFrom, 0)
    }
    
    func testLoadAnimes_WhenLoadMoreAnimes_ShouldCallRepositoryWithRightParams() async {
        sut.animes = Array(repeating: AnimeListItemViewModel(model: .mock), count: 5)
        await sut.loadAnimes()

        XCTAssertEqual(spyRepository.animesFromSeasonCallParams?.quantity, 10)
        XCTAssertEqual(spyRepository.animesFromSeasonCallParams?.startingFrom, sut.animes.count)
    }
    
    func testLoadAnimes_WhenLoadMoreAnimes_ShouldAppendReturnToAnimes() async {
        sut.animes = Array(repeating: AnimeListItemViewModel(model: .mock), count: 5)
        spyRepository.animesFromSeasonMockReturn = Array(repeating: Anime.mock, count: 10)
        await sut.loadAnimes()

        XCTAssertEqual(sut.animes.count, 15)
    }
    
    func testLoadAnimes_WhenLoadAnimesSuccessfuly_ShouldUpdateAnimesProperty() async {
        let mockAnimes = [Anime.mock, Anime.mock, Anime.mock]
        spyRepository.animesFromSeasonMockReturn = mockAnimes

        await sut.loadAnimes()

        XCTAssertEqual(sut.animes.count, mockAnimes.count)
        sut.animes.enumerated().forEach {
            XCTAssertEqual($0.element.model, mockAnimes[$0.offset])
        }
    }
    
    func testLoadAnimes_WhenLoadAnimesFails_ShouldShowError() async {
        spyRepository.animesFromSeasonMockError = HTTPServiceError.requestFailed(statusCode: 400)

        await sut.loadAnimes()

        XCTAssertTrue(sut.isShowingError)
    }
    
    func testLoadAnimes_WhenLoadAnimesSucceeds_ShouldNotShowError() async {
        await sut.loadAnimes()

        XCTAssertFalse(sut.isShowingError)
    }
    
    func testLoadAnimes_WhenLoadAnimesCompletes_ShouldHideLoading() async {
        await sut.loadAnimes()

        XCTAssertFalse(sut.isLoading)
    }
}
