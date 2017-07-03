//
//  PaymentMethodStep.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 2/7/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

class PaymentMethodStep: PaymentStep {
    
    let type = PaymentStepType.method
    let needExternalData: Bool = true
    var models: [Any]?
    var delegate: StepDelegate?
    let service = PaymentMethodsService()
    var shouldBeOmitted: Bool = false
    var isFinal = false
    
    func execute(withCurrentPaymentInfo paymentInfo: SelectedPaymentInfo?) {
        
        delegate?.stepWillRetrieveData()
        
        service.retrivePaymentMethods(ofType: paymentInfo?.paymentType) { (methods: [PaymentMethod]?, error: Error?) in
            self.delegate?.stepDidFinishLoading(self, methods, error)
        }
    }
    
}
