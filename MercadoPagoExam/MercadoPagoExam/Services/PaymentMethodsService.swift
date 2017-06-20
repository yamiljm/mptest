//
//  PaymentMethodsService.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 18/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

final class PaymentMethodsService {
    
    let apiConnector = PaymentMethodsAPIConnector()
    
    var delegate: PaymentMethodsServiceDelegate
    
    init(delegate: PaymentMethodsServiceDelegate) {
        self.delegate = delegate
    }
    
    func retrivePaymentMethods() {
        
        apiConnector.retrievePaymentMethods { (json: [[String : Any]]?, error: Error?) in
            
            if let error = error {
                self.delegate.informError(error)
                return
            }
            
            guard let json = json else {
                self.delegate.updatePaymentMethods(nil)
                return
            }
            
            var paymentMethods = [PaymentMethod]()
            for paymentMethodJson in json {
                if let onePaymentMethod = PaymentMethod(json: paymentMethodJson) {
                    paymentMethods.append(onePaymentMethod)
                }
            }
            
            self.delegate.updatePaymentMethods(paymentMethods)
        }
    }
    
    
}
