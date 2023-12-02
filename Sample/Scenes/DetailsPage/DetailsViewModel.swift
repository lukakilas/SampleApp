//
//  DetailsViewModel.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/2/23.
//

import UIKit

protocol DetailsViewModel {
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func reuseId(for indexPath: IndexPath) -> String
    func item(at indexPath: IndexPath) -> DetailsTableViewCellModel
    func titleForHeader(in secton: Int) -> String
}

class DetailsViewModelImpl: DetailsViewModel {
    private var model: HitsItem
    
    var dataSource: [[any DetailsTableViewCellModel]] = []
    
    init(model: HitsItem) {
        self.model = model
        setupDataSource()
    }
    
    private func setupDataSource() {
        dataSource = [createFirstSection(), createSecondSection()]
    }
    
    private func createFirstSection() -> [DetailsTableViewCellModel] {
        return [
            DetailsImageTableViewCell.UIModel(urlString: model.userImageURL),
            DetailsTableCellWithLabel.UIModel(title: "Image Size - \(String(model.imageSize))"),
            DetailsTableCellWithLabel.UIModel(title: "Image Type - \(model.type)"),
            DetailsTableCellWithLabel.UIModel(title: "Image Tags - \(model.tags)")
        ]
    }
    
    private func createSecondSection() -> [DetailsTableViewCellModel] {
        return [
            DetailsTableCellWithLabel.UIModel(title: "UserId - \(String(model.user))"),
            DetailsTableCellWithLabel.UIModel(title: "Views - \(String(model.views))"),
            DetailsTableCellWithLabel.UIModel(title: "Likes - \(String(model.likes))"),
            DetailsTableCellWithLabel.UIModel(title: "Comments - \(String(model.comments))"),
            DetailsTableCellWithLabel.UIModel(title: "Collections - \(String(model.collections))"),
            DetailsTableCellWithLabel.UIModel(title: "Downloads - \(String(model.downloads))")
        ]
    }
    // MARK: - Protocol Stubs
    func numberOfSections() -> Int {
        dataSource.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        dataSource[section].count
    }
    
    func reuseId(for indexPath: IndexPath) -> String {
        dataSource[indexPath.section][indexPath.row].reuseId
    }
    
    func item(at indexPath: IndexPath) -> DetailsTableViewCellModel {
        dataSource[indexPath.section][indexPath.row]
    }
    
    func titleForHeader(in secton: Int) -> String {
        secton == .zero ? "First Section" : "Second Section"
    }
}

