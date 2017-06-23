//
//  MercadoPagoNetworkConnector.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 18/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

class MercadoPagoAPIConnector : APIConnector, Environmentable {
    
    private struct Params {
        static let publicKey = "public_key"
    }
    
    private let publicKeyValue = "444a9ef5-8a6b-429f-abdf-587639155d88"
    
    var networkExecutor: NetworkExecutor

    var endpoint = PaymentMethodsAPIConnector.currentAPIEnvironment().endpoint()

    init() {
        networkExecutor = URLSessionNetworkExecutor()
    }
    
    
    func httpHeaders() -> [String : String]? {
        
        //TODO, agregar headers en común a la api de mercado pago
        
        
        return [:]
    }
    
    func commonQueryParameters() -> [URLQueryItem] {
        let publiKeyQueryItem = URLQueryItem(name: Params.publicKey, value: publicKeyValue)
        return [publiKeyQueryItem]
    }
    
    
}

