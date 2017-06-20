//
//  PaymentMethodsApiConnector.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 19/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

final class PaymentMethodsAPIConnector: MercadoPagoAPIConnector {
    
    private struct Paths {
        static let paymentsBasePath = "/v1/payment_methods"
        static let cardIssuers = "card_issuers"
        static let installments = "installments"
    }
    
    private struct Params {
        static let publicKey = "public_key"
        static let amount = "amount"
        static let paymentMethodId = "payment_method_id"
        static let issuerId = "issuer.id"
    }
    
    func retrievePaymentMethods(completionHandler: @escaping ([[String : Any]]?, Error?) -> Void) {
        
        guard let paymentMethodsURL = createPaymentMethodsURL() else {
            completionHandler(nil, MercadoPagoError.api.invalidURL)
            return
        }
        
        var urlRequest = URLRequest(url: paymentMethodsURL)
        urlRequest.httpMethod = URLRequest.httpMethods.get.rawValue
        urlRequest.updateHeaders(withHeaders: httpHeaders())
        
        return networkExecutor.execute(request: urlRequest, completionHandler: completionHandler)
    }
    
    
    private func createPaymentMethodsURL() -> URL? {
        
        var urlComponents: URLComponents?
        
        guard let baseURL = createBaseURL(), let paymentsMethodsURL = URL(string: Paths.paymentsBasePath, relativeTo: baseURL) else {
            return nil
        }
        
        urlComponents = URLComponents(url: paymentsMethodsURL, resolvingAgainstBaseURL: true)
        
        let queryItems = queryParameters()
        
        urlComponents?.queryItems = queryItems
        
        return urlComponents?.url
        
    }
    
    
}
