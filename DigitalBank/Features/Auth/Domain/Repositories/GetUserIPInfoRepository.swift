//
//  GetUserIPInfoRepository.swift
//  DigitalBank
//
//  Created by Muhammad on 12/08/25.
//

import Foundation

protocol GetUserIPInfoRepository {
    func getUserIPInfo() -> async throws -> UserIPInfo
}
