//
//  RegisterView.swift
//  Sample
//
//  Created by Luka Kilasonia on 11/28/23.
//

import UIKit

protocol RegisterViewable: UIView {
    var registrationFinished: ((Result<Void, ApiError>) -> Void)? { get set }
}

class RegisterView: UIView, RegisterViewable {
    var registrationFinished: ((Result<Void, ApiError>) -> Void)?
    
    private var emailField: TextInputView = {
        let field = TextInputView(model: .init(placeholder: "Username"))
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private var passwordField: TextInputView = {
        let field = TextInputView(model: .init(placeholder: "Password", isSecureEntry: true))
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private var ageField: TextInputView = {
        let field = TextInputView(model: .init(placeholder: "Age", keyboardType: .numberPad))
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var registerButton: LoginButton = {
        let btn = LoginButton(title: "Register")
        btn.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    let viewModel: RegisterViewModel
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
        enableRegisterButtonIfNeeded()
        setupTextFieldActions()
        bindViewModel()   
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    private func setup() {
        let stackView = UIStackView(arrangedSubviews: [emailField, passwordField, ageField, registerButton])
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.setCustomSpacing(20, after: ageField)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            registerButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // MARK: - Handling interaction
    private func setupTextFieldActions() {
        emailField.textField.addTarget(self, action: #selector(userNameEditingChanged), for: .editingChanged)
        passwordField.textField.addTarget(self, action: #selector(passwordEditingChanged), for: .editingChanged)
        ageField.textField.addTarget(self, action: #selector(ageEditingChanged), for: .editingChanged)
    }
    
    @objc private func userNameEditingChanged() {
        viewModel.email = emailField.textField.text ?? ""
        viewModel.validateField(field: .email)
    }
    
    @objc private func passwordEditingChanged() {
        viewModel.password = passwordField.textField.text ?? ""
        viewModel.validateField(field: .password)
    }
    
    @objc private func ageEditingChanged() {
        viewModel.age = ageField.textField.text ?? ""
        viewModel.validateField(field: .age)
    }
    
    private func bindViewModel() {
        viewModel.didUpdateState = { [weak self] state, field in
            self?.handleViewModelState(state, field: field)
            self?.enableRegisterButtonIfNeeded()
        }
        
        viewModel.registrationFinished = registrationFinished
    }
    
    private func enableRegisterButtonIfNeeded() {
        registerButton.isEnabled = viewModel.registerButtonEnabled
    }
    
    private func handleViewModelState(_ state: FieldValidationState, field: RegistrationFieldType) {
        let input: TextInputView
        switch field {
        case .email:
            input = emailField
        case .password:
            input = passwordField
        case .age:
            input = ageField
        }

        switch state {
        case .valid:
            input.setState(.normal)
        case .error(let error):
            input.setState(.error(error.localized))
        }
    }
    
    @objc private func registerBtnTapped() {
        viewModel.registerUser()
        registrationFinished?(.success(()))
    }
}

extension RegisterView {
    enum RegistrationFieldType {
        case email
        case password
        case age
    }
}
