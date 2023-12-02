//
//  RegisterScreenRouter.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/2/23.
//

import UIKit

class RegisterScreenRouter: FeedNavigatable {
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
}
