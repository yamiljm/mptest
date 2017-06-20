//
//  Logger.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 19/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation


enum LogLevel: String {
    case info
    case debug
    case warning
    case error
}

protocol LoggerType {
    
    static func log(level: LogLevel, description: String)
    
}
