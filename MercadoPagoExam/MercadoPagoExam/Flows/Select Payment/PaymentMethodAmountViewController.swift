//
//  PaymentMethodAmountViewController.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 23/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import UIKit

class PaymentMethodAmountViewController: UIViewController, UITextFieldDelegate, PaymentScreen {

    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var continueButton: UIButton!
    private var formatter: NumberFormatter?
    private let minimumAmount = NSNumber(value: 0)
    
    var selectedPaymentInfo: SelectedPaymentInfo? = SelectedPaymentInfo()
    var currentStep: PaymentStep?// = PaymentStepFactory.create(.amount)
    var dataSource: PaymentMethodComponentDataSource?
    weak var flowManager: SelectPaymentFlowManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountField.delegate = self
        amountField.inputAccessoryView = continueButton.inputView
        
        formatter = createFormatter()
        
        errorLabel.isHidden = true
        errorLabel.text = "El monto debe ser mayo a cero" //TODO: Internacionalizar
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let selectedPayment = selectedPaymentInfo else {
            return
        }
        
        if selectedPayment.hasAnAmount() {
            //TODO: revisar
            amountField.resignFirstResponder()
        } else {
            amountField.text = formatter?.string(from: 0)
            amountField.becomeFirstResponder()
        }
        
        if selectedPayment.isComplete() {
            showPaymentInfoMessage(selectedPayment)
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let amount = amountField.text {
            selectedPaymentInfo?.amount = formatter?.number(from: amount)
        }
        
        if segue.destination.isKind(of: PaymentComponentTableViewController.self) {
            let destination = segue.destination as? PaymentComponentTableViewController
            if let nextStep = PaymentStepOrderManager.stepAfter(step: currentStep) {
                destination?.currentStep = nextStep
                destination?.selectedPayment = selectedPaymentInfo
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        let validAmount = isValidAmount()
        
        if !validAmount {
            errorLabel.isHidden = false
        }
        
        return validAmount
    }
    
    @IBAction func unwindToAmountScreen(segue: UIStoryboardSegue) { }
    
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
    
    func showPaymentInfoMessage(_ selectedPayment: SelectedPaymentInfo) {
        
        //TODO: internacionalizar title
        
        let alertController = UIAlertController(title: "Pago seleccionado", message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(okAction)
        
        alertController.setValue(selectedPayment.attributedDescription(), forKey: "attributedMessage")
        
        self.present(alertController, animated: true, completion: nil)
        
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


fileprivate extension SelectedPaymentInfo {
    
    var fontSize: CGFloat {
        get {
            return UIFont.systemFontSize
        }
    }
    
    var bold: [String : Any] {
        get {
            return [NSFontAttributeName: UIFont.boldSystemFont(ofSize: fontSize),
                    NSParagraphStyleAttributeName: paragraphStyle
            ]
        }
    }
    
    var noBold: [String : Any] {
        get {
            return [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize),
                    NSParagraphStyleAttributeName: paragraphStyle
            ]
        }
    }
    
    var separator: String {
        get {
            return ": "
        }
    }
    
    var paragraphStyle: NSParagraphStyle {
        get {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            return paragraphStyle
        }
    }
    
    
    var newLine: NSAttributedString {
        get {
            return NSAttributedString(string: "\n", attributes: nil)
        }
    }
    
    func attributedDescription() -> NSAttributedString {
        
        guard let amount = self.amount, let methodName = self.method?.name, let payerCost = self.installmentsPayerCost else {
            //TODO: handle this error
            return NSAttributedString(string: "UPSS")
        }
        
        let newMessage = NSMutableAttributedString()
        
        newMessage.append(newLine)
        
        newMessage.append(createMessagePart(title: "Importe", text: amount.fractionDigits()))
        
        newMessage.append(newLine)
        
        newMessage.append(createMessagePart(title: "Medio de pago", text: methodName))
        
        newMessage.append(newLine)
        
        if let issuerName = self.cardIssuer?.name {
            newMessage.append(createMessagePart(title: "Emisor", text: issuerName))
            newMessage.append(newLine)
        }
        
        newMessage.append(createMessagePart(title: "Cuotas", text: payerCost.recommendedMessage))

        return newMessage
        
    }
    
    private func createMessagePart(title: String, text: String) -> NSMutableAttributedString {
        
        let messagePart = NSMutableAttributedString(string: title, attributes: bold)
        
        messagePart.append(NSAttributedString(string: separator, attributes: bold))
        
        let textPart = NSAttributedString(string: text, attributes: noBold)
        
        messagePart.append(textPart)
        
        return messagePart
    }
}
