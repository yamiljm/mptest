//
//  CardIssuer.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 22/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation
import Gloss

struct CardIssuer: Decodable {
    
    private struct Keys {
        static let id = "id"
        static let name = "name"
        static let secureThumbnail = "secure_thumbnail"
        static let thumbnail = "thumbnail"
        static let processingMode = "processing_mode"
        static let merchantAccountId = "merchant_account_id"
    }
    
    let id: String
    let name: String
    let secureThumbnail: String?
    let thumbnail: String?
    let proccesingMode: String?
    let merchantAccountId: String?
    
    init?(json: JSON){
        
        guard let id = Keys.id <~~ json as String?, let name = Keys.name <~~ json as String? else {
            //TODO: Loguear que no se pudo cargar un card issuer
            return nil
        }
        
        self.id = id
        self.name = name
        
        self.secureThumbnail = Keys.secureThumbnail <~~ json
        self.thumbnail = Keys.thumbnail <~~ json
        self.proccesingMode = Keys.processingMode <~~ json
        self.merchantAccountId = Keys.merchantAccountId <~~ json
    }
    
}
