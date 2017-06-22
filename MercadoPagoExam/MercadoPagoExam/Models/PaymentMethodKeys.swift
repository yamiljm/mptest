//
//  PaymentMethodKeys.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 22/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation


struct PaymentMethodKeys {
    
    static let id = "id"
    static let name = "name"
    static let paymentTypeId = "payment_type_id"
    static let status = "status"
    static let secureThumbnail = "secure_thumbnail"
    static let thumbnail = "thumbail"
    static let deferredCapture = "deferred_capture"
    static let settings = "settings"
    static let additionalInfoNeeded = "additional_info_needed"
    static let minAllowedAmount = "min_allowed_amount"
    static let maxAllowedAmount = "max_allowed_amount"
    static let accreditationTime = "accreditation_time"

    struct Settings {
        struct Bin {
            static let pattern = "pattern"
            static let exclusionPattern = "exclusion_pattern"
            static let installmentsPattern = "installments_pattern"
        }
        
        struct CardNumber {
            static let length = "length"
            static let validation = "validation"
        }
        
        struct SecurityCode {
            static let mode = "mode"
            static let lenght = "lenght"
            static let cardLocation = "card_location"
        }
        
        static let bin = "bin"
        static let cardNumber = "card_number"
        static let securityCode = "security_code"
    }

}
    
