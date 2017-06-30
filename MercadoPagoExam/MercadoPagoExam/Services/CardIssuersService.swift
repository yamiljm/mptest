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
    
    //TODO: hacerlo weak
    var delegate: (_: [CardIssuer]?, _: Error?) -> Void
    
    init(delegate: @escaping (_: [CardIssuer]?, _: Error?) -> Void) {
        self.delegate = delegate
    }
    
    func retriveCardIssuers(paymentMethodId: String) {
        
        let onError = { (error: Error) -> Void in
            self.delegate(nil, error)
        }
        
        let onSucces = { (models: [CardIssuer]?) -> Void in
            //Acá se podría realizar validaciones sobre los modelos antes de pasarlos al delegate
            self.delegate(models, nil)
        }
        
        let cardIssuerModelCreator = ModelCreator<CardIssuer>(onSucces: onSucces, onError: onError)
        
        apiConnector.retriveCardIssuers(forPaymentMethodId: paymentMethodId, withModelCreator: cardIssuerModelCreator)
    }
    
}
