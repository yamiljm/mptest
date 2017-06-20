//
//  PaymentMethod.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 20/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation
import Gloss

struct PaymentMethod: Decodable {
    
    private struct Keys {
        static let name = "name"
    }
    
    let name: String?
    
    init?(json: JSON) {
        self.name = Keys.name <~~ json
    }
}
