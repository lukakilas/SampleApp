//
//  DetailsImageTableViewCell.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/2/23.
//

import UIKit

class DetailsImageTableViewCell: UITableViewCell, TableViewCell {
    
    typealias Model = UIModel
    private let largeImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        largeImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(largeImageView)
        NSLayoutConstraint.activate([
            largeImageView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 24),
            largeImageView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 24),
            largeImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            largeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            largeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
    
    func update(with model: DetailsTableViewCellModel) {
        guard let model = model as? UIModel else { return }
        largeImageView.sd_setImage(with: URL(string: model.urlString))
    }
}

// MARK: - Cell UI Model
extension DetailsImageTableViewCell {
    struct UIModel: DetailsTableViewCellModel {
        var reuseId: String = "DetailsImageTableViewCell"
        let urlString: String
    }
}
