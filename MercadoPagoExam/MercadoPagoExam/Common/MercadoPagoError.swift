//
//  CustomError.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 19/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

struct MercadoPagoError {
    
    enum api: Error {
        case invalidURL
        case invalidAPIConnectorURL
        case invalidDataFromServer
    }
    
    enum service: Error {
        case invalidParameters
    }
}
