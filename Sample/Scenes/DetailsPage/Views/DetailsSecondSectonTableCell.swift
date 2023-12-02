//
//  DetailsTableCellWithLabel.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/2/23.
//

import UIKit

class DetailsTableCellWithLabel: UITableViewCell, TableViewCell {
    
    typealias Model = UIModel

    private var label: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 12)
        lbl.textColor = .purple
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: 24),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func update(with model: DetailsTableViewCellModel) {
        guard let model = model as? UIModel else { return }
        label.text = model.title
    }
}

// MARK: - Cell UI Model
extension DetailsTableCellWithLabel {
    struct UIModel: DetailsTableViewCellModel {
        var reuseId: String = "DetailsTableCellWithLabel"
        var title: String
    }
}
