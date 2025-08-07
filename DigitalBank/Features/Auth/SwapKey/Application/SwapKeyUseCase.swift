//
//  SwapKeyUseCase.swift
//  DigitalBank
//
//  Created by Muhammad on 06/08/25.
//

import Foundation

final class SwapKeyUseCase {
    private let repository: SwapKeyRepository
    
    enum Error: Swift.Error, Equatable {
        case connectivity
        case invalidData
        case unauthorized
        case server(String)
    }
    
    init(repository: SwapKeyRepository) {
        self.repository = repository
    }
    
    func execute(request: SwapKeyModels.Request) async throws -> Result<String, Error> {
        do {
            let response = try await repository.swapKey(request: request)
            if response.code == 0, let keyB = response.encryptData {
                return .success(keyB)
            } else if response.code == 401 {
                return .failure(.unauthorized)
            } else {
                return .failure(.server(response.msg ?? "Unknown error"))
            }
        } catch {
            return .failure(.connectivity)
        }
    }
}
