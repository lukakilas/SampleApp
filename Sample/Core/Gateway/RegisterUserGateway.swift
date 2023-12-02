//
//  RegisterUserGateway.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/2/23.
//

import Foundation

protocol RegisterUserGateway {
    func registerUser(email: String, password: String, age: String) async throws -> AuthResponse
}

class RegisterUserGatewayImpl: RegisterUserGateway {
    private let client: NetworkClient
    
    init(client: NetworkClient) {
        self.client = client
    }
    
    func registerUser(email: String, password: String, age: String) async throws -> AuthResponse {
        do {
            let response: AuthResponse = try await client.loadAndParse()
            return response
        } catch {
            throw error
        }  
    }
}
