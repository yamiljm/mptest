//
//  PaymentMethod.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 20/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation
import Gloss

enum PaymentType: String {
    case creditCard = "credit_card"
    case debitCard = "debit_card"
    case ticket = "ticket"
    case other = "other"
    
    init(rawValue: String) {
        switch rawValue {
        case "credit_card": self = .creditCard
        case "debit_card": self = .debitCard
        case "ticket": self = .ticket
        default: self = .other
        }
    }
}

struct PaymentMethod: Decodable {
    
    let id: String
    let name: String
    let paymentTypeId: PaymentType
    let status: String?
    let secureThumbnail: String?
    let thumbnail: String?
    let deferredCapture: String?
    let settings: PaymentMethodSettings?
    let additionalInfoNeeded: [String]?
    let minAllowedAmount: Int?
    let maxAllowedAmount: Int?
    let accreditationTime: Double?
    
    init?(json: JSON) {
        
        //Con fines de este ejercicio solo hago requeridos los siguientes campos
        
        guard let id = PaymentMethodKeys.id <~~ json as String?, let name = PaymentMethodKeys.name <~~ json as String?, let rawPaymentTypeId = PaymentMethodKeys.paymentTypeId <~~ json as String? else {
            //TODO: Loguear que no se cargó un payment method
            return nil
        }
        
        self.id = id
        self.name = name
        self.paymentTypeId = PaymentType(rawValue: rawPaymentTypeId)
        
        self.status = PaymentMethodKeys.status <~~ json
        self.thumbnail = PaymentMethodKeys.thumbnail <~~ json
        self.secureThumbnail = PaymentMethodKeys.secureThumbnail <~~ json
        self.deferredCapture = PaymentMethodKeys.deferredCapture <~~ json
        self.settings = PaymentMethodKeys.settings <~~ json
        self.additionalInfoNeeded = PaymentMethodKeys.additionalInfoNeeded <~~ json
        self.minAllowedAmount = PaymentMethodKeys.minAllowedAmount <~~ json
        self.maxAllowedAmount = PaymentMethodKeys.maxAllowedAmount <~~ json
        self.accreditationTime = PaymentMethodKeys.accreditationTime <~~ json
    }
}
