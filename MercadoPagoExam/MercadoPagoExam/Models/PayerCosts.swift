//
//  payerCosts.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 22/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation
import Gloss

struct PayerCosts: Decodable {
    
    private struct Keys {
        
        static let installments = "installments"
        static let installmentRate = "installment_rate"
        static let discountRate = "discount_rate"
        static let labels = "labels"
        static let installmentRateCollector = "installment_rate_collector"
        static let minAllowedAmount = "min_allowed_amount"
        static let maxAllowedAmount = "max_allowed_amount"
        static let recommendedMessage = "recommended_message"
        static let installmentAmount = "installment_amount"
        static let totalAmount = "total_amount"
    }
    
    let installments: Int
    let recommendedMessage: String
    let installmentAmount: Double
    let totalAmount: Double
    let installmentRate: Double?
    let discountRate: Double?
    let labels: [String]?
    let installmentRateCollector: [String]?
    let minAllowedAmount: Int?
    let maxAllowedAmount: Int?
    
    
    init?(json: JSON) {
        
        //A efectos de este trabajo práctico asumo estos campos como obligatorios
        
        guard let installments = Keys.installments <~~ json as Int?, let recommendedMessage = Keys.recommendedMessage <~~ json as String?, let installmentAmount = Keys.installmentAmount <~~ json as Double?, let totalAmount = Keys.totalAmount <~~ json as Double?  else {
            //TODO: log error
            return nil
        }
        
        self.installments = installments
        self.recommendedMessage = recommendedMessage
        self.installmentAmount = installmentAmount
        self.totalAmount = totalAmount
        
        self.installmentRate = Keys.installmentRate <~~ json
        self.discountRate = Keys.discountRate <~~ json
        self.labels = Keys.labels <~~ json
        self.installmentRateCollector = Keys.installmentRateCollector <~~ json
        self.minAllowedAmount = Keys.minAllowedAmount <~~ json
        self.maxAllowedAmount = Keys.maxAllowedAmount <~~ json
    }
    
}
