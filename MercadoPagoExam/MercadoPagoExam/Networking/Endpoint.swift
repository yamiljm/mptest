//
//  Endpoint.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 19/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation


struct Endpoint {
    
    struct Scheme {
        static let http = "http"
        static let https = "https"
    }
    
    struct Defaults {
        static let timeout: TimeInterval = 60.0 //seconds
    }
    
    var host: String?
    var port: Int?
    var scheme: String?
    var headers: [String : String]?
    var timeout: TimeInterval?
    
    init(host: String, port: Int?=nil, scheme: String?=Scheme.https, headers: [String: String]?=nil, timeout: TimeInterval?=Defaults.timeout) {
        self.host = host
        self.port = port
        self.scheme = scheme
        self.headers = headers
        self.timeout = timeout
    }
    
    func url() -> URL? {
        
        var urlComponents = URLComponents()
        urlComponents.host = host
        urlComponents.scheme = scheme
        urlComponents.port = port
        
        return urlComponents.url
    }
    
    
}

extension Environment {
    
    private struct Constants {
        static let apiMercadoPagoDomain = "api.mercadopago.com"
        static let localhostIP = "127.0.0.1"
    }
    
    func endpoint() -> Endpoint {
        
        switch self {
        case .production:
            return Endpoint(host: Constants.apiMercadoPagoDomain)
        case .localhost:
            return Endpoint(host: Constants.localhostIP, port: 9090, scheme: Endpoint.Scheme.http)
        default:
            return Endpoint(host: Constants.apiMercadoPagoDomain)
        }
    }
}
