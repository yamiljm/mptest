//
//  PaymentMethodSettings.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 21/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation
import Gloss

struct PaymentMethodSettings: Decodable {
    
    struct Bin: Decodable {
        
        let pattern: String?
        let exclusionPattern: String?
        let installmentsPattern: String?
        
        init?(json: JSON) {
            self.pattern = PaymentMethodKeys.Settings.Bin.pattern <~~ json
            self.exclusionPattern = PaymentMethodKeys.Settings.Bin.exclusionPattern <~~ json
            self.installmentsPattern = PaymentMethodKeys.Settings.Bin.installmentsPattern <~~ json
        }
    }
    
    struct CardNumber: Decodable {
        
        let lenght: Int?
        let validation: String?
        
        init?(json: JSON) {
            self.lenght = PaymentMethodKeys.Settings.CardNumber.length <~~ json
            self.validation = PaymentMethodKeys.Settings.CardNumber.validation <~~ json
        }
    }
    
    struct SecurityCode: Decodable {
        
        let mode: String?
        let lenght: Int?
        let cardLocation: String?
        
        init?(json: JSON) {
            self.mode = PaymentMethodKeys.Settings.SecurityCode.mode <~~ json
            self.lenght = PaymentMethodKeys.Settings.SecurityCode.lenght <~~ json
            self.cardLocation = PaymentMethodKeys.Settings.SecurityCode.cardLocation <~~ json
        }
    }
    
    let bin: Bin?
    let cardNumber: CardNumber?
    let securityCode: SecurityCode?
    
    init?(json: JSON) {
        self.bin = PaymentMethodKeys.Settings.bin <~~ json
        self.cardNumber = PaymentMethodKeys.Settings.cardNumber <~~ json
        self.securityCode = PaymentMethodKeys.Settings.securityCode <~~ json
    }
}
