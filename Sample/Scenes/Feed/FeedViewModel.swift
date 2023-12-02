//
//  FeedViewModel.swift
//  Sample
//
//  Created by Luka Kilasonia on 11/29/23.
//

import Foundation

protocol ErrorListenable {
    var errorOccured: ((ApiError) -> Void)? { get set }
}

protocol FeedViewModel: ErrorListenable {
    var didLoadData: (() -> Void)? { get set }
    var data: [HitsItem] { get set }
    func numberOfRows(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> HitsItem?
}

class FeedViewModelImpl: FeedViewModel {
    
    var data: [HitsItem] = [] {
        didSet {
            didLoadData?()
        }
    }
    var errorOccured: ((ApiError) -> Void)?
    var didLoadData: (() -> Void)?
    
    init(fetchItemsUsecase: FetchItemsUsecase) {
        self.fetchItemsUsecase = fetchItemsUsecase
        Task { await loadData() }
    }
    
    private let fetchItemsUsecase: FetchItemsUsecase
    
    @MainActor
    func loadData() {
        Task.init {
            do {
                self.data = try await fetchItemsUsecase.fetchIcons().hits
            } catch let error as ApiError {
                errorOccured?(error)
            }
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        return data.count
    }
    
    func item(at indexPath: IndexPath) -> HitsItem? {
        if indexPath.row > data.count - 1 || data.isEmpty {
            return nil
        }
        return data[indexPath.row]
    }

}
