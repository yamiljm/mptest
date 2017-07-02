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
    
    //TODO: hacerlo weak
//    var delegate: (_: [PaymentMethod]?, _: Error?) -> Void
    
//    init(completion: @escaping (_: [PaymentMethod]?, _: Error?) -> Void) {
//        self.delegate = delegate
//    }

//    func retrivePaymentMethods(ofType type: PaymentType?=nil) {
//        
//        let onError = { (error: Error) -> Void in
//            self.delegate(nil, error)
//        }
//
//        let onSucces = { (models: [PaymentMethod]?) -> Void in
//            //Acá se podría realizar validaciones sobre los modelos antes de pasarlos al delegate
//            if let type = type {
//                let filteredPaymentMethods = models?.filter {$0.paymentTypeId == type}
//                self.delegate(filteredPaymentMethods, nil)
//            } else {
//                self.delegate(models, nil)
//            }
//        }
//
//        let paymentMethodModelCreator = ModelCreator<PaymentMethod>(onSucces: onSucces, onError: onError)
//        
//        apiConnector.retrievePaymentMethods(withModelCreator: paymentMethodModelCreator)
//    }
    
    func retrivePaymentMethods(ofType type: PaymentType?=nil, completion: @escaping (_ models: [PaymentMethod]?, _ error: Error?) -> Void) {
        
        let onError = { (error: Error) -> Void in
            completion(nil, error)
        }
        
        let onSucces = { (models: [PaymentMethod]?) -> Void in
            //Acá se podría realizar validaciones sobre los modelos antes de pasarlos al delegate
            if let type = type {
                let filteredPaymentMethods = models?.filter {$0.paymentTypeId == type}
                completion(filteredPaymentMethods, nil)
//                self.delegate(filteredPaymentMethods, nil)
            } else {
                completion(models, nil)
//                self.delegate(models, nil)
            }
        }
        
        let paymentMethodModelCreator = ModelCreator<PaymentMethod>(onSucces: onSucces, onError: onError)
        
        apiConnector.retrievePaymentMethods(withModelCreator: paymentMethodModelCreator)
    }
}
