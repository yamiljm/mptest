//
//  Step.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 26/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation
import  UIKit


class AmountPaymentStep: PaymentStep {
    
    let type = PaymentStepType.amount
    let needExternalData: Bool = false
    var models: [Any]?
    var delegate: StepDelegate?
    var shouldBeOmitted: Bool = false
    var isFinal = false
    
    func execute(withCurrentPaymentInfo paymentInfo: SelectedPaymentInfo?) {
        return
    }
    
}

