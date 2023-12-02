//
//  LoginGateway.swift
//  Sample
//
//  Created by Luka Kilasonia on 11/28/23.
//

import Foundation

protocol LoginGateway {
    func authenticate(username: String, password: String) async throws -> AuthResponse
}

struct LoginGatewayImpl: LoginGateway {
    private let apiClient: NetworkClient
    
    init(apiClient: NetworkClient) {
        self.apiClient = apiClient
    }
    
    func authenticate(username: String, password: String) async throws -> AuthResponse {
        do {
            let response: AuthResponse = try await apiClient.loadAndParse()
            return response
        } catch {
            throw ApiError.invalid
        }
    }
}
