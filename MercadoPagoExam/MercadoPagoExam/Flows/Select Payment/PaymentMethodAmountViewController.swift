//
//  PaymentMethodAmountViewController.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 23/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import UIKit

class PaymentMethodAmountViewController: UIViewController, PaymentScreen {
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!

    @IBOutlet weak var amountContainer: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    var selectedPaymentInfo: SelectedPaymentInfo?
    var currentStep: PaymentStep?
    var dataSource: PaymentMethodComponentDataSource?
    weak var flowManager: SelectPaymentFlowManager?
    private var amountInput: NumericInputFieldViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            _ = amountInput?.resignFirstResponder()
        } else {
            amountInput?.value = 0
            _ = amountInput?.becomeFirstResponder()
        }
        
        if selectedPayment.isComplete {
            amountInput?.value = 0
            flowManager?.presentPaymentInfoMessage(selectedPayment)
        }
    }
    
    
    // MARK: - Navigation
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        
        guard let amountField = amountInput, amountField.isValid() else {
            return
        }

        selectedPaymentInfo?.amount = amountField.value
        
        flowManager?.userDidCompleteInfo(forStep: currentStep, withPaymentInfo: selectedPaymentInfo)
    }
    
    //MARK: - UITextFieldDelegate
    
    @IBAction func resignFirstResponder(_ sender: UITapGestureRecognizer) {
        _ = amountInput?.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "amountIdentifier" {
            if let destination = segue.destination as? NumericInputFieldViewController {
                amountInput = destination
            }
        }
    }
    
    
    func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurve: UIViewAnimationOptions = UIViewAnimationOptions.curveLinear
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

