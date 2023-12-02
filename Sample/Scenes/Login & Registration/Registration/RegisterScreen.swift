//
//  RegisterScreen.swift
//  Sample
//
//  Created by Luka Kilasonia on 11/28/23.
//

import UIKit

class RegisterScreen: UIViewController {

    private let registerView: RegisterViewable
    private let router: FeedNavigatable
    
    init(router: FeedNavigatable, registerView: RegisterViewable) {
        self.router = router
        self.registerView = registerView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(registerView)
        registerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            registerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            registerView.topAnchor.constraint(equalTo: view.topAnchor),
            registerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        registerView.registrationFinished = { [weak self] result in
            switch result {
            case .success(_):
                self?.router.showFeed()
            case .failure(let error):
                self?.showAlert(text: error.localized)
            }
        }
    }

}

// MARK: - Configuring dependencies
extension RegisterScreen {
    static func configured(with router: RegisterScreenRouter) -> RegisterScreen {
        let gateway = RegisterUserGatewayImpl(client: LoginClient())
        let registerUsecase: RegisterUserUsecase = RegisterUserUsecaseImpl(registerUserGateway: gateway)
        let vm = RegisterViewModel(usecase: registerUsecase)
        let registerView = RegisterView(viewModel: vm)
        let vc = RegisterScreen(router: router, registerView: registerView)
        return vc
    }
}
