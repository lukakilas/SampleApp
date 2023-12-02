//
//  FeedRouter.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/2/23.
//

import UIKit

protocol FeedRouter: BaseRouter {
    func showDetails(model: HitsItem)
}

class FeedRouterImpl: FeedRouter {
    var navController: UINavigationController?
    
    init(navController: UINavigationController? = nil) {
        self.navController = navController
    }
    
    func showDetails(model: HitsItem) {
        let vm = DetailsViewModelImpl(model: model)
        let vc = DetailsScreen(viewModel: vm)
        navController?.pushViewController(vc, animated: true)
    }
}
