//
//  FeedCollectionViewCell.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/2/23.
//

import UIKit
import SDWebImage

class FeedCollectionViewCell: UICollectionViewCell {
    static let reuseId = "FeedCollectionViewCell"
    
    private let thumbnailImageView = UIImageView()
    private let authorName = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        let stack = UIStackView(arrangedSubviews: [thumbnailImageView, authorName])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func update(with model: FeedCollectionViewCell.Model) {
        thumbnailImageView.sd_setImage(with: URL(string: model.icon))
        authorName.text = model.title
    }
}
//
extension FeedCollectionViewCell {
    struct Model {
        let icon: String
        let title: String
    }
}
