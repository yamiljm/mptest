//
//  SelectedPayment.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 26/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

final class SelectedPaymentInfo {
    
    var paymentType: PaymentType = .creditCard
    var amount: Double?
    var method: PaymentMethod?
    var cardIssuer: CardIssuer?
    var installmentsPayerCost: PayerCosts?
    var isComplete: Bool = false

    func hasAnAmount() -> Bool {
        return amount != nil 
    }
    
    func clear() {
        paymentType = .creditCard
        amount = nil
        method = nil
        cardIssuer = nil
        installmentsPayerCost = nil
        isComplete = false
    }
}
