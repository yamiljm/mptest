//
//  Stepable.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 26/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

protocol PaymentStepable {
    
    var currentStep: PaymentStep? {get set}
    var selectedPayment: SelectedPaymentInfo? {get set}

}
