//
//  GetUserIPInfoRepositoryImpl.swift
//  DigitalBank
//
//  Created by Muhammad on 12/08/25.
//

import Foundation

class GetUserIPInfoRepositoryImpl: GetUserIPInfoRepository {
    let client: GetUserIPInfoClient
    init(client: GetUserIPInfoClientImpl) {
        self.client = client
    }
    func getUserIPInfo() async throws -> UserIPInfo {
        // LoD: UseCase clientni bilmaydi; Repository biladi.
        // CQS: faqat o‘qish (query) — holatni o‘zgartirmaymiz.
        let dto = try await client.fetchUserIPInfo()
        // SRP/DRY: mapping markazlashgan (extension UserIPInfoDTO.toDomain()).
        return dto.toDomain()
    }
}
