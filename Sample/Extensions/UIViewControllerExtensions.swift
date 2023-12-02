//
//  UIViewControllerExtensions.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/2/23.
//

import UIKit

extension UIViewController {
    func showAlert(text: String) {
        let alert = UIAlertController(title: "Oops!", message: text, preferredStyle: .alert)
        alert.addAction(.init(title: "ok", style: .default))
        self.present(alert, animated: true)
    }
}
