//
//  PaymentStepFactory.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 2/7/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

struct PaymentStepFactory {
    
    static func create(_ type: PaymentStepType) -> PaymentStep {
        
        switch type {
        case .amount:
            return AmountPaymentStep()
        case .method:
            return PaymentMethodStep()
        case .cardIssuer:
            return CardIssuerStep()
        case .installments:
            return InstallmentsStep()
        }
    }
}
