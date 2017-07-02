//
//  PaymentStepsOrderManager.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 2/7/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

struct PaymentStepOrderManager {
    
    let defaultStep = PaymentStepFactory.create(.amount)
    
    //TODO: borrar
    static func stepAfter(step: PaymentStep?) -> PaymentStep? {
        
        guard let step = step else {
            return nil
        }
        
        switch step.type {
        case .amount:
            return PaymentStepFactory.create(.method)
        case .method:
            return PaymentStepFactory.create(.cardIssuer)
        case .cardIssuer:
            return PaymentStepFactory.create(.installments)
        case .installments:
            return PaymentStepFactory.create(.amount)
        }
    }
    
    func stepAfter(step: PaymentStep?) -> PaymentStep {
        
        guard let step = step else {
            return defaultStep
        }
        
        switch step.type {
        case .amount:
            return PaymentStepFactory.create(.method)
        case .method:
            return PaymentStepFactory.create(.cardIssuer)
        case .cardIssuer:
            return PaymentStepFactory.create(.installments)
        case .installments:
            return PaymentStepFactory.create(.amount)
        }
    }
    
    
    func first() -> PaymentStep {
        return PaymentStepFactory.create(.amount)
    }
    
    func nextStep(after originalStep: PaymentStep, withCurrentPaymentInfo paymentInfo: SelectedPaymentInfo?) -> PaymentStep {
        
        return PaymentStepFactory.create(.amount)//   stepAfter(step: originalStep)
    }
}
