//
//  LoginView.swift
//  Sample
//
//  Created by Luka Kilasonia on 11/27/23.
//

import UIKit

protocol LoginViewable: UIView {
    var didTapRegister: (() -> Void)? { get set }
    var didTapLogin: ((Result<Void, ApiError>) -> Void)? { get set }
}

class LoginView: UIView, LoginViewable {
    // MARK: - Protocol properties
    var didTapRegister: (() -> Void)?
    var didTapLogin: ((Result<Void, ApiError>) -> Void)?
    
    // MARK: - Internal properties
    private(set) var emailField: TextInputView = {
        let field = TextInputView(model: .init(placeholder: "Email"))
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private(set) var passwordField: TextInputView = {
        let field = TextInputView(model: .init(placeholder: "Password", isSecureEntry: true))
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private var loginButton: LoginButton = {
        let btn = LoginButton(title: "Login")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private(set) var registerButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Register", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(.purple, for: .normal)
        btn.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        enableLoginButtonIfNeeded()
        bindViewModel()
        setupLayout()
        setupTextFieldActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    // MARK: - Layout & Styling
    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [emailField, passwordField, loginButton, registerButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        stack.setCustomSpacing(20, after: passwordField)
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // MARK: - Handling interaction
    private func setupTextFieldActions() {
        emailField.textField.addTarget(self, action: #selector(userNameEditingChanged), for: .editingChanged)
        passwordField.textField.addTarget(self, action: #selector(passwordEditingChanged), for: .editingChanged)
    }
    
    @objc private func userNameEditingChanged() {
        viewModel.email = emailField.textField.text ?? ""
        viewModel.validateField(field: .email)
    }
    
    @objc private func passwordEditingChanged() {
        viewModel.password = passwordField.textField.text ?? ""
        viewModel.validateField(field: .password)
    }
    
    private func bindViewModel() {
        viewModel.didUpdateState = { [weak self] state, field in
            self?.handleViewModelState(state, field: field)
            self?.enableLoginButtonIfNeeded()
        }
    }
    
    private func enableLoginButtonIfNeeded() {
        loginButton.isEnabled = viewModel.loginButtonEnabled
    }
    
    private func handleViewModelState(_ state: FieldValidationState, field: LoginField) {
        let input = field == .email ? emailField : passwordField
        switch state {
        case .valid:
            input.setState(.normal)
        case .error(let error):
            input.setState(.error(error.localized))
        }
    }

    @objc private func loginButtonTapped() {
        viewModel.authenticateUser { [weak self] result in
            self?.didTapLogin?(result)
        }
    }
    
    @objc private func registerButtonTapped() {
        didTapRegister?()
    }
    
}

extension LoginView {
    enum LoginField {
        case email
        case password
    }
}
