//
//  GetUserIPInfoTestHelpers.swift
//  DigitalBankTests
//
//  Created by Muhammad on 12/08/25.
//

import XCTest

@testable import DigitalBank

// MARK: - Test helpers
extension GetUserIPInfoUseCaseTests {
    // SUT (System Under Test) ni yaratish
    // DRY: har testda qayta yozmaymiz
    // DIP: SUT faqat protokollarga qaraydi
    func makeSUIT(
        repo: GetUserIPInfoRepositorySpy = .init(),
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (
        sut: GetUserIPInfoUseCase, repo: GetUserIPInfoRepositorySpy
    ) {
        let suit = GetUserIPInfoUseCaseImpl(repository: repo)
        trackForMemoryLeaks(suit, file: file, line: line)
        trackForMemoryLeaks(repo, file: file, line: line)
        return (suit, repo)
    }
    
    // Kutilgan natija (success/failure)ni tekshiruvchi umumiy helper
    // SRP: verifikatsiya mantiqi bitta joyda
    // Deterministik: spy orqali natijani oldindan beramiz
    func expect(
        _ suit: GetUserIPInfoUseCase,
        repo: GetUserIPInfoRepositorySpy,
        toCompleteWith expected: Result<UserIPInfo, Error>,
        file: StaticString = #filePath,
        line: UInt = #line
    ) async {
        repo.resultToReturn = expected
        switch expected {
        case .success(let expectedInfo):
            do {
                let received = try await suit.execute()
                XCTAssertEqual(
                    received,
                    expectedInfo,
                    file: file,
                    line: line
                )
                XCTAssertEqual(
                    repo.receivedRequests.count,
                    1,
                    file: file,
                    line: line
                )
            } catch {
                XCTFail(
                    "Expected success but got error: \(error)",
                    file: file,
                    line: line
                )
            }
        case .failure(let error):
            do {
                _ = try await suit.execute()
                XCTFail(
                    "Expected failure but got success \(error)",
                    file: file,
                    line: line
                )
            } catch {
                XCTAssertEqual(
                    repo.receivedRequests.count,
                    1,
                    file: file,
                    line: line
                )
            }
        }
    }

    func trackForMemoryLeaks(
        _ instance: AnyObject,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "Potential memory leak",
                file: file,
                line: line
            )
        }
    }
}
