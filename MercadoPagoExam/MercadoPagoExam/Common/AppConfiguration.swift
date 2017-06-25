//
//  AppConfiguration.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 24/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

//Un simple configurador a fines de este ejercicio

class AppConfiguration {
    
    private struct Defaults {
        static let region = "AR"
        static let language = "es"
    }
    
    static let shared = AppConfiguration()
    
    var region: String
    var language: String
    
    private init() {
        //Para este ejercicio dejo estos valores constantes. 
        //Deberían ser seteado desde la app por el usuario o ser tomados del SO
        self.region = Defaults.region
        self.language = Defaults.language
    }
    
    func locale() -> Locale {
        return Locale(identifier: "\(language)-\(region)")
    }
    
    
}
