//
//  LoginUseCase.swift
//  Sample
//
//  Created by Luka Kilasonia on 11/28/23.
//

import Foundation

protocol LoginUseCase {
    func authenticate(username: String, password: String) async throws -> AuthResponse
}

class LoginUseCaseImpl: LoginUseCase {
    private let gateway: LoginGateway
    
    init(gateway: LoginGateway) {
        self.gateway = gateway
    }
    
    func authenticate(username: String, password: String) async throws -> AuthResponse {
        do {
            return try await gateway.authenticate(username: username, password: password)
            // Store token
        }
        catch {
            throw error
        }
    }
}
