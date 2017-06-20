//
//  NetworkConnector.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 18/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

protocol APIConnector {
    
    var endpoint: Endpoint {get set}
    
    var networkExecutor: NetworkExecutor {get}
    
    func httpHeaders() -> [String : String]?
    
    func createBaseURL() -> URL?
    
    func queryParameters() -> [URLQueryItem]

}


extension APIConnector {
    
    func createBaseURL() -> URL? {
        return endpoint.url()
    }
    
}
