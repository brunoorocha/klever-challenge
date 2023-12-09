//
//  AnimeDetailsViewModelTests.swift
//  KleverChallengeTests
//
//  Created by Bruno Rocha on 09/12/23.
//

import XCTest
@testable import KleverChallenge

final class SpyImageRepository: ImageRepository {
    private(set) var loadImageDataCallCount = 0
    private(set) var receivedURL: URL?

    func loadImageData(fromURL url: URL) async throws -> Data {
        loadImageDataCallCount += 1
        receivedURL = url
        return UIImage(systemName: "checkmark")!.pngData()!
    }
}

final class AnimeDetailsViewModelTests: XCTestCase {
    var sut: AnimeDetailsViewModel!
    var spyMyListRepository: SpyMyListRepository!
    var spyImageRepository: SpyImageRepository!

    override func setUpWithError() throws {
        makeSut()
    }
    
    func testInit_WhenInit_ShouldVerifyIfAnimeIsOnMyListAndSetInOnMyList() {
        makeSut(isOnMyList: true)
        XCTAssertEqual(spyMyListRepository.isInMyListCallCount, 1)
        XCTAssertTrue(sut.isInMyList)
        
        makeSut(isOnMyList: false)
        XCTAssertEqual(spyMyListRepository.isInMyListCallCount, 1)
        XCTAssertFalse(sut.isInMyList)
    }
    
    func testInit_WhenInit_ShouldLoadPosterImage() {
        makeSut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.spyImageRepository.loadImageDataCallCount, 1)
            XCTAssertEqual(self.spyImageRepository.receivedURL, URL(string: self.sut.model.posterImageURL!))
        }
    }
    
    func testInit_WhenLoadCoverImage_ShouldSetPosterImage() {
        makeSut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.sut.posterImage)
        }
    }
    
    func testAddToMyList_WhenAnimeIsNotOnMyList_ShouldAddToMyList() {
        makeSut(isOnMyList: false)
        sut.didTapOnMyListButton()
        
        XCTAssertEqual(spyMyListRepository.addCallCount, 1)
        XCTAssertEqual(spyMyListRepository.receivedAnime, sut.model)
        XCTAssertTrue(sut.isInMyList)
    }
    
    func testAddToMyList_WhenAnimeIsOnMyList_ShouldRemoveToMyList() {
        makeSut(isOnMyList: true)
        sut.didTapOnMyListButton()
        
        XCTAssertEqual(spyMyListRepository.removeCallCount, 1)
        XCTAssertEqual(spyMyListRepository.receivedAnime, sut.model)
        XCTAssertFalse(sut.isInMyList)
    }
    
    private func makeSut(isOnMyList: Bool = false) {
        spyMyListRepository = SpyMyListRepository()
        spyImageRepository = SpyImageRepository()
        spyMyListRepository.isInMyListReturn = isOnMyList
        sut = AnimeDetailsViewModel(
            model: .mock,
            imageRepository: spyImageRepository,
            myListRepository: spyMyListRepository
        )
    }
}
