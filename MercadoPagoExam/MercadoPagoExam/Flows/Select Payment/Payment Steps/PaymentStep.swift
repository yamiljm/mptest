//
//  StepTyep.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 2/7/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

enum PaymentStepType {
    case amount, method, cardIssuer, installments
}


protocol PaymentStep {
    
    var type: PaymentStepType {get}
    
    var delegate: StepDelegate? {get set}
    
    var shouldBeOmitted: Bool {get set}
    
    var needExternalData: Bool {get}
    
    func execute(withCurrentPaymentInfo: SelectedPaymentInfo?)
    
}
