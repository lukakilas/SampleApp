//
//  RegisterUserUsecase.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/2/23.
//

import Foundation

protocol RegisterUserUsecase {
    func registerUser(email: String, password: String, age: String) async throws -> AuthResponse
}

class RegisterUserUsecaseImpl: RegisterUserUsecase {
    private let registerUserGateway: RegisterUserGateway
    
    init(registerUserGateway: RegisterUserGateway) {
        self.registerUserGateway = registerUserGateway
    }
    
    func registerUser(email: String, password: String, age: String) async throws -> AuthResponse {
        return try await registerUserGateway.registerUser(email: email, password: password, age: age)
    }
}
