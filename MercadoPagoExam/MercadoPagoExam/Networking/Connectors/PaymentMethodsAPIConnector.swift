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
        static let amount = "amount"
        static let paymentMethodId = "payment_method_id"
        static let issuerId = "issuer.id"
    }
    
    func retrievePaymentMethods(withModelCreator modelCreator: ModelCreator<PaymentMethod>) {
        
        guard let paymentMethodsURL = createPaymentMethodsBaseURL() else {
            modelCreator.createModels(json: nil, error: MercadoPagoError.api.invalidURL)
            return
        }
        
        var urlRequest = URLRequest(url: paymentMethodsURL)
        urlRequest.httpMethod = URLRequest.httpMethods.get.rawValue
        urlRequest.updateHeaders(withHeaders: httpHeaders())
        
        return networkExecutor.execute(request: urlRequest, completionHandler: modelCreator.createModels)
    }
    
    func retriveCardIssuers(forPaymentMethodId paymentMethodId: String, withModelCreator modelCreator: ModelCreator<CardIssuer>) {
        
        guard let cardIssuersURL = createCardIssuersURL(forPaymentMethodId: paymentMethodId) else {
            modelCreator.createModels(json: nil, error: MercadoPagoError.api.invalidURL)
            return
        }
        
        var urlRequest = URLRequest(url: cardIssuersURL)
        urlRequest.httpMethod = URLRequest.httpMethods.get.rawValue
        urlRequest.updateHeaders(withHeaders: httpHeaders())
        
        return networkExecutor.execute(request: urlRequest, completionHandler: modelCreator.createModels)
    }
    
    func retriveInstallments(forPaymentMethodId paymentMethodId: String, andIssuerId issuerId: String?, andAmount amount: NSNumber, withModelCreator modelCreator: ModelCreator<Installments>) {
        
        guard let installmentsURL = createInstallmentsURL(forPaymentMethodId: paymentMethodId, andIssuerId: issuerId, withAmount: amount) else {
            modelCreator.createModels(json: nil, error: MercadoPagoError.api.invalidURL)
            return
        }
        
        var urlRequest = URLRequest(url: installmentsURL)
        urlRequest.httpMethod = URLRequest.httpMethods.get.rawValue
        urlRequest.updateHeaders(withHeaders: httpHeaders())
        
        return networkExecutor.execute(request: urlRequest, completionHandler: modelCreator.createModels)
    }
    
    private func createPaymentMethodsBaseURL() -> URL? {
        
        guard let baseURL = createBaseURL() else {
            //TODO: log error
            return nil
        }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let queryItems = commonQueryParameters()
        urlComponents?.queryItems = queryItems
        return urlComponents?.url?.appendingPathComponent(Paths.paymentsBasePath)
    }
    
    
    private func createCardIssuersURL(forPaymentMethodId paymentMethodId: String) -> URL? {
        
        guard let paymentMethodBaseURL = createPaymentMethodsBaseURL() else {
            //TODO: log error
            return nil
        }
        
        var urlComponents = URLComponents(url: paymentMethodBaseURL, resolvingAgainstBaseURL: true)
        
        let paymentMethodIdItem = URLQueryItem(name: Params.paymentMethodId, value: paymentMethodId)
        urlComponents?.queryItems?.append(paymentMethodIdItem)
        
        return urlComponents?.url?.appendingPathComponent(Paths.cardIssuers)
    }
    
    
    private func createInstallmentsURL(forPaymentMethodId paymentMethodId: String, andIssuerId issuerId: String?, withAmount amount: NSNumber) -> URL? {
        
        guard let paymentMethodBaseURL = createPaymentMethodsBaseURL() else {
            //TODO: log error
            return nil
        }
        
        var urlComponents = URLComponents(url: paymentMethodBaseURL, resolvingAgainstBaseURL: true)
        
        let paymentMethodIdItem = URLQueryItem(name: Params.paymentMethodId, value: paymentMethodId)
        let amountItem = URLQueryItem(name: Params.amount, value: amount.fractionDigits())
        urlComponents?.queryItems?.append(contentsOf: [paymentMethodIdItem, amountItem])
        
        if let issuerId = issuerId {
            let issuerIdItem = URLQueryItem(name: Params.issuerId, value: issuerId)
            urlComponents?.queryItems?.append(contentsOf: [issuerIdItem])
        }
        
        return urlComponents?.url?.appendingPathComponent(Paths.installments)
    }
    
    
    
}
