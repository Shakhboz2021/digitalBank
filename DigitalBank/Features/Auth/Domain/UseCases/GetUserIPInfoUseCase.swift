//
//  GetUserIPInfoUseCase.swift
//  DigitalBank
//
//  Created by Muhammad on 12/08/25.
//

import Foundation

protocol GetUserIPInfoUseCase {
    func execute() async throws -> UserIPInfo
}

class GetUserIPInfoUseCaseImpl: GetUserIPInfoUseCase {
    let repository: GetUserIPInfoRepository

    init(repository: GetUserIPInfoRepository) {
        self.repository = repository
    }
    func execute() async throws -> UserIPInfo {
        try await repository.getUserIPInfo()
    }
}
