//
//  LoginRouter.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/2/23.
//

import UIKit

protocol LoginRouter: FeedNavigatable {
    func showRegistrationScreen()
}

class LoginRouterImpl: LoginRouter {
    var navController: UINavigationController?
    
    init(navController: UINavigationController?) {
        self.navController = navController
    }
    
    @MainActor
    func showFeed() {
        let router = FeedRouterImpl(navController: navController)
        let vc = FeedScreen.configured(router: router)
        navController?.pushViewController(vc, animated: true)
    }
    
    @MainActor
    func showRegistrationScreen() {
        let vc = RegisterScreen.configured(with: .init(navController: self.navController))
        navController?.pushViewController(vc, animated: true)
    }
    
}
