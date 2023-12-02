//
//  LoginScreen.swift
//  Sample
//
//  Created by Luka Kilasonia on 11/27/23.
//

import UIKit

class LoginScreen: UIViewController {
    private let loginView: LoginViewable
    private let router: LoginRouter
    
    init(loginView: LoginViewable, router: LoginRouter) {
        self.loginView = loginView
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        handleLoginViewEvents()
    }

    private func setup() {
        view.backgroundColor = .white
        view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            loginView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func handleLoginViewEvents() {
        loginView.didTapRegister = { [weak self] in
            self?.router.showRegistrationScreen()
        }
        
        loginView.didTapLogin = { [weak self] result in
            switch result {
            case .success(_):
                self?.router.showFeed()
            case .failure(let apiError):
                self?.showAlert(text: apiError.localized)
            }
        }
    }
}
// MARK: - LoginScreen Configuration
extension LoginScreen {
    static func configured(router: LoginRouter) -> LoginScreen {
        let gateway = LoginGatewayImpl(apiClient: LoginClient())
        let usecase = LoginUseCaseImpl(gateway: gateway)
        let vm = LoginViewModel(usecase: usecase)
        let loginView = LoginView(viewModel: vm)
        let screen = LoginScreen(loginView: loginView, router: router)
        return screen
    }
}

