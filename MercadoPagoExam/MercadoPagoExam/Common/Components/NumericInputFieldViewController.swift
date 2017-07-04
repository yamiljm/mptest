//
//  NumericInputFieldViewController.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 3/7/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import UIKit

class NumericInputFieldViewController: UIViewController, UITextFieldDelegate {
    
    private var formatter: NumberFormatter?
    private let minimumAmount = NSNumber(value: 0)
    
    var amountField = UITextField()
    var errorLabel = UILabel()
    
    var value: Double? {
        didSet {
            if let value = value {
                amountField.text = formatter?.string(from: value as NSNumber)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextField(amountField)
        configureErroLabel(errorLabel)
        
        amountField.delegate = self
        formatter = createFormatter()
        
        let stackView = createStackView(withView: [amountField, errorLabel])
        view.addSubview(stackView)
        
        let margins = view.layoutMarginsGuide
        stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
    }
    
    override func becomeFirstResponder() -> Bool {
        return amountField.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        return amountField.resignFirstResponder()
    }
    
    private func createStackView(withView views: [UIView]) -> UIStackView {
        
        let stackView = UIStackView(arrangedSubviews: views)
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    private func configureTextField(_ textField: UITextField) {
        textField.font = UIFont.systemFont(ofSize: 28)
        textField.textAlignment = .right
        textField.borderStyle = .line
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .decimalPad
    }
    
    private func configureErroLabel(_ errorLabel: UILabel) {
        errorLabel.font = UIFont.systemFont(ofSize: 15)
        errorLabel.textAlignment = .left
        errorLabel.textColor = UIColor.red
        errorLabel.isHidden = true
        errorLabel.text = "El monto debe ser mayo a cero" //TODO:Internacionalizar

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        errorLabel.isHidden = true
        //Evito borrar signo de la moneda
        if string.isEmpty && textField.text == formatter?.currencySymbol {
            textField.text = formatter?.currencySymbol ?? "" + " "
            return false
        }
        
        //valido entradas
        guard let currentText = textField.text, string.isNumeric() || string.isDecimalSeparator() || string.isEmpty else {
            return false
        }
        
        //Se admite solo una separador decimal y/o backspace
        if (string.isDecimalSeparator() && !currentText.containsDecimalSeparator()) || string.isEmpty {
            return true
        }
        
        let textWithoutGroupingSeparator = currentText.replacingOccurrences(of: (formatter?.groupingSeparator)!, with: "")
        
        let newNumber = textWithoutGroupingSeparator + string
        
        guard let validNumberFromCurrentText = formatter?.number(from: newNumber) else {
            return false
        }
        
        if textWithoutGroupingSeparator.containsDecimalSeparator() && string == "0" {
            textField.text = currentText + string
        } else {
            textField.text = formatter?.string(from: validNumberFromCurrentText)
        }
        
        return  false
    }
    
    func isValid() -> Bool {
        guard isValidAmount(), let _ = amountField.text else {
            errorLabel.isHidden = false
            return false
        }
        return true
    }
    
    private func isValidAmount() -> Bool {
        
        guard let amount = formatter?.number(from: amountField.text ?? "0") else {
            return false
        }
        return amount.compare(minimumAmount) == .orderedDescending
    }
    
    private func createFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = AppConfiguration.shared.locale()
        formatter.minimum = 0
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 9
        formatter.minimumFractionDigits = 0
        return formatter
    }
    
}

fileprivate extension String {
    
    func isDecimalSeparator() -> Bool {
        let decimalSeparator = AppConfiguration.shared.locale().decimalSeparator ?? "."
        return self == decimalSeparator
    }
    
    func isNumeric() -> Bool {
        return Int(self) != nil
    }
    
    func containsDecimalSeparator() -> Bool {
        let decimalSeparator = AppConfiguration.shared.locale().decimalSeparator ?? "."
        return self.contains(decimalSeparator)
    }
}



