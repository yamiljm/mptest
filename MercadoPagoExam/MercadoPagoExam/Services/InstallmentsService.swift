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
    
    //TODO: hacerlo weak
    var delegate: (_: [Installment]?, _: Error?) -> Void
    
    init(delegate: @escaping (_: [Installment]?, _: Error?) -> Void) {
        self.delegate = delegate
    }
    
    
    func retriveInstallments(paymentMethodId: String, issuerId: String?, amount: NSNumber) {
        
        let onError = { (error: Error) -> Void in
            self.delegate(nil, error)
        }
        
        let onSucces = { (models: [Installment]?) -> Void in
            //Acá se podría realizar validaciones sobre los modelos antes de pasarlos al delegate
            self.delegate(models, nil)
        }
        
        let installmentsModelCreator = ModelCreator<Installment>(onSucces: onSucces, onError: onError)
        
        apiConnector.retriveInstallments(forPaymentMethodId: paymentMethodId, andIssuerId: issuerId, andAmount: amount, withModelCreator: installmentsModelCreator)
        
    }
    
}
