//
//  InstallmentsService.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 29/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

final class InstallmentsService {
    
    let apiConnector = PaymentMethodsAPIConnector()
    
    func retriveInstallments(paymentMethodId: String, issuerId: String?, amount: Double, completion: @escaping (_ models: [Installment]?, _ error: Error?) -> Void) {
        
        let onError = { (error: Error) -> Void in
            completion(nil, error)
        }
        
        let onSucces = { (models: [Installment]?) -> Void in
            //Acá se podría realizar validaciones sobre los modelos antes de pasarlos al delegate
            completion(models, nil)
        }
        
        let installmentsModelCreator = ModelCreator<Installment>(onSucces: onSucces, onError: onError)
        
        apiConnector.retriveInstallments(forPaymentMethodId: paymentMethodId, andIssuerId: issuerId, andAmount: amount, withModelCreator: installmentsModelCreator)
        
    }
    
}
