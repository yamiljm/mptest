//
//  CardIssuersService.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 27/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

final class CardIssuersService {
    
    let apiConnector = PaymentMethodsAPIConnector()
    
    func retriveCardIssuers(paymentMethodId: String, completion: @escaping (_ models: [CardIssuer]?, _ error: Error?) -> Void) {
        
        let onError = { (error: Error) -> Void in
            completion(nil, error)
        }
        
        let onSucces = { (models: [CardIssuer]?) -> Void in
            //Acá se podría realizar validaciones sobre los modelos antes de pasarlos al delegate
            completion(models, nil)
        }
        
        let cardIssuerModelCreator = ModelCreator<CardIssuer>(onSucces: onSucces, onError: onError)
        
        apiConnector.retriveCardIssuers(forPaymentMethodId: paymentMethodId, withModelCreator: cardIssuerModelCreator)
    }
    
}
