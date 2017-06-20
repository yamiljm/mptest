//
//  ConsoleLogger.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 19/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation


struct ConsoleLogger: LoggerType {
    
    static func log(level: LogLevel, description: String) {
        print("\(level.rawValue.uppercased()) - \(description)")
    }
}
