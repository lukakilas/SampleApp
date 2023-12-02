//
//  FeedScreen.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/2/23.
//

import UIKit

class FeedScreen: UIViewController {
    
    private var viewModel: FeedViewModel
    private let router: FeedRouter
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.reuseId)
        return collection
    }()
    
    init(viewModel: FeedViewModel, router: FeedRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("no coder available")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.didLoadData = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView.collectionViewLayout = flowLayout
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension FeedScreen: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.reuseId, for: indexPath) as? FeedCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = viewModel.item(at: indexPath)
        cell.update(with: item!.toCollectionCellModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FeedScreen: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = viewModel.item(at: indexPath) {
            router.showDetails(model: item)
        }
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension FeedScreen: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.bounds.width/3, height: 300)
    }
}

// MARK: - FeedScreen Configuration
extension FeedScreen {
    static func configured(router: FeedRouter) -> FeedScreen {
        let gateway = ApiFetchItemsGatewayImpl(client: FeedItemsNetworkClient())
        let usecase = FetchItemsUsecaseImpl(gateway: gateway)
        let vm = FeedViewModelImpl(fetchItemsUsecase: usecase)
        return FeedScreen(viewModel: vm, router: router)
    }
}
