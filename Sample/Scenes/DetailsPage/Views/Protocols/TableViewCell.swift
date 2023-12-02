//
//  TableViewCell.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/2/23.
//

import UIKit

protocol TableViewCell: UITableViewCell {
    func update(with model: DetailsTableViewCellModel)
}
