//
//  Installments.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 22/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation
import Gloss

struct Installments: Decodable {
    
    private struct Keys {
        static let paymentMethodId = "payment_method_id"
        static let paymentTypeId = "payment_type_id"
        static let issuer = "issuer"
        static let processingMode = "processing_mode"
        static let merchantAccountId = "merchant_account_id"
        static let payerCosts = "payer_costs"
    }
    
    let paymentMethodId: String
    let paymentTypeId: String
    let issuer: CardIssuer?
    let processingMode: String?
    let merchantAccountId: String?
    let payerCosts: [PayerCosts]?
    
    init?(json: JSON) {
    
        guard let paymentMethodId = Keys.paymentTypeId <~~ json as String?, let paymentTypeId = Keys.paymentTypeId <~~ json as String? else {
            //TODO: log error
            return nil
        }
        
        self.paymentMethodId = paymentMethodId
        self.paymentTypeId = paymentTypeId
        
        self.issuer = Keys.issuer <~~ json
        self.processingMode = Keys.processingMode <~~ json
        self.merchantAccountId = Keys.merchantAccountId <~~ json
        self.payerCosts = Keys.payerCosts <~~ json
    }
}
