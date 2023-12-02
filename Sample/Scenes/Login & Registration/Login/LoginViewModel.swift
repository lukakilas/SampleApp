//
//  LoginViewModel.swift
//  Sample
//
//  Created by Luka Kilasonia on 11/27/23.
//

import Foundation

class LoginViewModel {
    
    var email: String = ""
    var password: String = ""
    
    var loginButtonEnabled: Bool {
        return email.isValidEmail() && 6...12 ~= password.count
    }
    var didUpdateState: ((FieldValidationState, LoginView.LoginField) -> Void)?
    
    private let usecase: LoginUseCase
    
    init(usecase: LoginUseCase) {
        self.usecase = usecase
    }
    
    func validateField(field: LoginView.LoginField) {
        switch field {
        case .email:
            let state: FieldValidationState = email.isValidEmail() ? .valid : .error(.invalidEmail)
            didUpdateState?(state, field)
        case .password:
            let passwordIsValid = 6...12 ~= password.count
            let state: FieldValidationState = passwordIsValid ? .valid : .error(.invalidPassword)
            didUpdateState?(state, field)
        }
    }
    
    @MainActor
    func authenticateUser(completed: @escaping (Result<Void, ApiError>) -> Void) {
        Task.init {
            do {
                try await usecase.authenticate(username: email, password: password)
                completed(.success(()))
            }
            catch let error as ApiError {
                completed(.failure(error))
            }
        }
    }
    
}
