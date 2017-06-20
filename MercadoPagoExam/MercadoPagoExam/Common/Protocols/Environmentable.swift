//
//  Enviromentable.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 19/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

//import Foundation

protocol Environmentable {
    
    static func currentAPIEnvironment() -> Environment
    
}

extension Environmentable {
    
    static func currentAPIEnvironment() -> Environment {
        //TODO: Acá se puede poner alguna lógica para detectar el ambiente a utilizar.
        //Ya sea si la app está en modo debug o algún debug panel
        return .production
    }
}
