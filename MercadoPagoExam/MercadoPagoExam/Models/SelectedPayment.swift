//
//  SelectedPayment.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 26/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

final class SelectedPayment {
    
    var amount: NSNumber?
    var method: PaymentMethod?
    var cardIssuer: CardIssuer?
    var installmentsPayerCost: PayerCosts?
    
    func isComplete() -> Bool {
        //Asumo esto como una posible regla de negocio para este ejercicio
        return amount != nil && method != nil  && installmentsPayerCost != nil
    }
    
    func hasAnAmount() -> Bool {
        return amount != nil 
    }
}
