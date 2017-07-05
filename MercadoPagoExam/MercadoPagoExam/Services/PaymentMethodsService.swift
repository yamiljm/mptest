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
    
    func retrivePaymentMethods(ofType type: PaymentType?=nil, completion: @escaping (_ models: [PaymentMethod]?, _ error: Error?) -> Void) {
        
        let onError = { (error: Error) -> Void in
            completion(nil, error)
        }
        
        let onSucces = { (models: [PaymentMethod]?) -> Void in
            //Acá se podría realizar validaciones sobre los modelos antes de pasarlos al completion
            if let type = type {
                let filteredPaymentMethods = models?.filter {$0.paymentTypeId == type}
                completion(filteredPaymentMethods, nil)
            } else {
                completion(models, nil)
            }
        }
        
        let paymentMethodModelCreator = ModelCreator<PaymentMethod>(onSucces: onSucces, onError: onError)
        
        apiConnector.retrievePaymentMethods(withModelCreator: paymentMethodModelCreator)
    }
}
