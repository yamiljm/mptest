//
//  PaymentScreen.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 2/7/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

protocol PaymentScreen {
    
    var flowManager: SelectPaymentFlowManager? {get set}
    var dataSource: PaymentMethodComponentDataSource? {get set}
    var selectedPaymentInfo: SelectedPaymentInfo? {get set}
    var currentStep: PaymentStep? {get set}
    
}
