//
//  MyListViewModelTests.swift
//  KleverChallengeTests
//
//  Created by Bruno Rocha on 09/12/23.
//

import XCTest
@testable import KleverChallenge

final class SpyMyListRepository: MyListRepository {
    private(set) var myListCallCount = 0
    private(set) var addCallCount = 0
    private(set) var removeCallCount = 0
    private(set) var isInMyListCallCount = 0
    
    private(set) var receivedAnime: Anime?
    
    var myListReturn = [Anime]()
    var isInMyListReturn = false
    
    func myList() -> [Anime] {
        myListCallCount += 1
        return myListReturn
    }
    
    func add(anime: Anime) {
        addCallCount += 1
        receivedAnime = anime
    }
    
    func remove(anime: Anime) {
        removeCallCount += 1
        receivedAnime = anime
    }
    
    func isInMyList(anime: Anime) -> Bool {
        isInMyListCallCount += 1
        receivedAnime = anime
        return isInMyListReturn
    }
}

final class MyListViewModelTests: XCTestCase {
    var sut: MyListViewModel!
    var spyRepository: SpyMyListRepository!
    
    override func setUpWithError() throws {
        spyRepository = SpyMyListRepository()
        sut = MyListViewModel(myListRepository: spyRepository)
    }
    
    func testInit_WhenInitViewModel_ShouldLoadAnimesFromMyList() {
        sut.loadMyList()
        
        XCTAssertEqual(spyRepository.myListCallCount, 1)
    }
    
    func testLoadMyList_WhenItHasAnimesInMyList_ShouldMapToViewModelCorrectly() {
        spyRepository.myListReturn = [.mock, .mock, .mock]
        sut.loadMyList()
        
        XCTAssertEqual(sut.animes.count, spyRepository.myListReturn.count)
        sut.animes.enumerated().forEach {
            XCTAssertEqual(sut.animes[$0.offset].model, spyRepository.myListReturn[$0.offset])
        }
    }
}
