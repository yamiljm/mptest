//
//  Step.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 26/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation
import  UIKit

enum PaymentStepType {
    case amount, method, cardIssuer, installments
}

struct PaymentStepFactory {
    
    static func create(_ type: PaymentStepType) -> PaymentStep {
        switch type {
        case .amount:
            return PaymentStep(ofType: .amount)
        case .method:
            return PaymentStep(ofType: .method, dataSource: PaymentMethodDataSource())
        case .cardIssuer:
            return PaymentStep(ofType: .cardIssuer, dataSource: CardIssuersDataSource())
        case .installments:
            return PaymentStep(ofType: .installments)
        }
    }
}

struct PaymentStepOrderManager {
    
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
}

struct PaymentStep {
    
    let type: PaymentStepType
    let dataSource: PaymentMethodComponentDataSource?
    let selectedPayment: SelectedPayment?
    
    init(ofType type: PaymentStepType, dataSource: PaymentMethodComponentDataSource?=nil, selectedPayment: SelectedPayment?=nil) {
        self.type = type
        self.dataSource = dataSource
        self.selectedPayment = selectedPayment
    }
}

