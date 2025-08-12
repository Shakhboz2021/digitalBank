//
//  GetUserIPInfoClient.swift
//  DigitalBank
//
//  Created by Muhammad on 12/08/25.
//

import Foundation

protocol GetUserIPInfoClient {
    /// Tarmoqdan foydalanuvchi IP ma'lumotlarini oladi (transport/DTO darajasi)
    func fetchUserIPInfo() async throws -> UserIPInfo
}
