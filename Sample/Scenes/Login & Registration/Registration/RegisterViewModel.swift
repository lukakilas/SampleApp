//
//  RegisterViewModel.swift
//  Sample
//
//  Created by Luka Kilasonia on 11/28/23.
//

import Foundation

class RegisterViewModel {
    var email: String = ""
    var password: String = ""
    var age: String = ""

    var didUpdateState: ((FieldValidationState, RegisterView.RegistrationFieldType) -> Void)?
    var registerButtonEnabled: Bool {
        return email.isValidEmail() && passwordRange ~= password.count && ageRange ~= age.intValue
    }
    
    var registrationFinished: ((Result<Void, ApiError>) -> Void)?
    
    // Private properties
    private let passwordRange = 6...12
    private let ageRange = 19...99
    private let usecase: RegisterUserUsecase
    
    init(usecase: RegisterUserUsecase) {
        self.usecase = usecase
    }
    
    func validateField(field: RegisterView.RegistrationFieldType) {
        switch field {
        case .email:
            let state: FieldValidationState = email.isValidEmail() ? .valid : .error(.invalidEmail)
            didUpdateState?(state, field)
        case .password:
            let passwordIsValid = passwordRange ~= password.count
            let state: FieldValidationState = passwordIsValid ? .valid : .error(.invalidPassword)
            didUpdateState?(state, field)
        case .age:
            let state: FieldValidationState = ageRange ~= age.intValue ? .valid : .error(.invalidAge)
            didUpdateState?(state, field)
        }
    }
    
    func registerUser() {
        Task.init {
            do {
                let _: AuthResponse = try await usecase.registerUser(email: email, password: password, age: age)
                registrationFinished?(.success(()))
            } catch let error as ApiError {
                registrationFinished?(.failure(error))
            }
        }
        
    }
}
