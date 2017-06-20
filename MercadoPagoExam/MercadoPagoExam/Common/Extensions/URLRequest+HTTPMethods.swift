//
//  URLRequest+HTTPMethods.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 20/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

extension URLRequest {
    
    public enum httpMethods: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    public mutating func updateHeaders(withHeaders headers: [String : String]?){
        
        guard let headers = headers else {
            return
        }
        
        for (key,value) in headers {
            self.allHTTPHeaderFields?.updateValue(value, forKey: key)
        }
    }
    
}
