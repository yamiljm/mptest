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
    
    
    //Se pasa SelectedPaymentInfo para que en base al contexto se puedan definir otras reglas
    //para saber cuál será el próximo paso.
    func nextStep(afterStep step: PaymentStep?, withCurrentPaymentInfo paymentInfo: SelectedPaymentInfo?=nil) -> PaymentStep {
        
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
            var step =  PaymentStepFactory.create(.amount)
            step.isFinal = true
            return step
        }
    }
    
    func first() -> PaymentStep {
        return PaymentStepFactory.create(.amount)
    }
    
}
