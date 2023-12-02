//
//  LoginButton.swift
//  Sample
//
//  Created by Luka Kilasonia on 12/2/23.
//

import UIKit

class LoginButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setup(title: title)
        styleLoginButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    private func setup(title: String) {
        backgroundColor = .purple
        setTitleColor(.white, for: .normal)
        setTitleColor(.black, for: .highlighted)
        setTitle("Login", for: .normal)
        setBackgroundImage(.from(color: .gray), for: .disabled)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func styleLoginButton() {
        layer.cornerRadius = 12
        clipsToBounds = true
    }
    
}
