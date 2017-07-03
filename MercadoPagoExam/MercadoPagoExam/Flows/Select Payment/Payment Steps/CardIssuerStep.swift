//
//  PaymentMethodStep.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 2/7/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

class CardIssuerStep: PaymentStep {
    
    let type = PaymentStepType.cardIssuer
    let needExternalData: Bool = true
    var models: [Any]?
    var delegate: StepDelegate?
    let service = CardIssuersService()
    var shouldBeOmitted: Bool = false
    var isFinal = false
    
    func execute(withCurrentPaymentInfo paymentInfo: SelectedPaymentInfo?) {
        
        shouldBeOmitted = false
        
        guard let paymentMethodId = paymentInfo?.method?.id else{
            delegate?.stepDidFinishLoading(self, nil, MercadoPagoError.service.invalidParameters)
            return
        }
        
        delegate?.stepWillRetrieveData()
        
        service.retriveCardIssuers(paymentMethodId: paymentMethodId) { (models: [CardIssuer]?, error: Error?) in
            
            if let models = models, models.isEmpty, error == nil {
                self.shouldBeOmitted = true
            }
            
            self.delegate?.stepDidFinishLoading(self, models, error)
        }
    }
    
}
