//
//  PaymentMethodAmountViewController.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 23/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import UIKit

class PaymentMethodAmountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var formatter: NumberFormatter?
    private let minimumAmount = NSNumber(value: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountField.delegate = self
        amountField.becomeFirstResponder()
        formatter = createFormatter()
        amountField.text = formatter?.string(from: 0)
        
        errorLabel.isHidden = true
        errorLabel.text = "El monto debe ser mayo a cero" //TODO: Internacionalizar
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    
    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        let validAmount = isValidAmount()
        
        if !validAmount {
            errorLabel.isHidden = false
        }
        
        return validAmount
    }
    
    private func isValidAmount() -> Bool {
        
        guard let amount = formatter?.number(from: amountField.text ?? "0") else {
            return false
        }
        return amount.compare(minimumAmount) == .orderedDescending
    }
    
    //MARK: - UITextFieldDelegate
    
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
    
    private func createFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = AppConfiguration.shared.locale()
        formatter.minimum = 0
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 9
        formatter.minimumFractionDigits = 0
        return formatter
    }

    
    @IBAction func resignFirstResponder(_ sender: UITapGestureRecognizer) {
        amountField.resignFirstResponder()
    }
    
    
    func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = 0.0
            } else {
                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
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