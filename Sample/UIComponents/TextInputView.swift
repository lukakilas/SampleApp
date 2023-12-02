//
//  TextInputView.swift
//  Sample
//
//  Created by Luka Kilasonia on 11/27/23.
//

import UIKit

class TextInputView: UIView {
    private(set) var textField: TextField = {
        let field = TextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private(set) var errorLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .red
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 10)
        return lbl
    }()
    
    private lazy var errorLabelHeightConstr = NSLayoutConstraint(item: errorLabel,
                                                             attribute: .height,
                                                             relatedBy: .equal,
                                                             toItem: .none,
                                                             attribute: .notAnAttribute,
                                                             multiplier: 1,
                                                             constant: 0)
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        createStyling()
    }
    
    init(model: Model) {
        super.init(frame: .zero)
        setupTextField(with: model)
        setupConstraints()
        createStyling()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField(with model: Model) {
        textField.placeholder = model.placeholder
        textField.keyboardType = model.keyboardType
        textField.isSecureTextEntry = model.isSecureEntry
        textField.delegate = self
    }
    
    private func setupConstraints() {
        addSubview(textField)
        addSubview(errorLabel)
        NSLayoutConstraint.activate([
            textField.leftAnchor.constraint(equalTo: leftAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.rightAnchor.constraint(equalTo: rightAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50),
            errorLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 8),
            errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            errorLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            errorLabelHeightConstr,
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func createStyling() {
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 12.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setState(_ state: State) {
        switch state {
        case .error(let errorText):
            errorLabel.text = errorText
            errorLabelHeightConstr.constant = 10
        case .normal:
            errorLabel.text = nil
            errorLabelHeightConstr.constant = 0
        }
    }
    
}
// MARK: - UITextFieldDelegate
extension TextInputView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            setState(.normal)
        }
    }
}
// MARK: - TextInputView Model & State
extension TextInputView {
    struct Model {
        let placeholder: String?
        var keyboardType: UIKeyboardType = .default
        var isSecureEntry: Bool = false
    }
    
    enum State {
        case error(String)
        case normal
    }
}

// MARK: - TextField with insset
class TextField: UITextField {
    let insets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: insets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: insets)
    }
}

