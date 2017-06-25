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
    private var formatter: NumberFormatter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountField.delegate = self
        amountField.becomeFirstResponder()
        formatter = createFormatter()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isDecimalSeparator() || string.isEmpty {
            return true
        }
        
        guard let currentText = textField.text, string.isNumeric() else {
            return false
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
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 9
        return formatter
    }

    
    @IBAction func resignFirstResponder(_ sender: UITapGestureRecognizer) {
        amountField.resignFirstResponder()
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
