//
//  PaymentMethodsServiceDelegate.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 20/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation


protocol PaymentMethodsServiceDelegate {
    
    func updatePaymentMethods(_ paymentMethods: [PaymentMethod]?)
    
    func updateCardIssuers(_ cardIssuers: [CardIssuer]?)
    
    func updateInstallments(_ installments: [Installments]?)
    
    func informError(_ error: Error)
    
}
