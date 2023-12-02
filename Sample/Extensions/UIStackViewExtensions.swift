//
//  UIStackViewExtensions.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/2/23.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach { view in
            addArrangedSubview(view)
        }
    }
}
