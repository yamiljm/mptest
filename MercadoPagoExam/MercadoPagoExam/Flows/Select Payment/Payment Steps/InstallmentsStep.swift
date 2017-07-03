//
//  InstallmentsStep.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 2/7/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

class InstallmentsStep: PaymentStep {
    
    let type = PaymentStepType.installments
    let needExternalData: Bool = true
    var models: [Any]?
    var delegate: StepDelegate?
    let service = InstallmentsService()
    var shouldBeOmitted: Bool = false
    var isFinal = false
    
    func execute(withCurrentPaymentInfo paymentInfo: SelectedPaymentInfo?) {
        
        guard let paymentMethodId = paymentInfo?.method?.id, let amount = paymentInfo?.amount else{
            delegate?.stepDidFinishLoading(self, nil, MercadoPagoError.service.invalidParameters)
            return
        }
        
        delegate?.stepWillRetrieveData()
        
        service.retriveInstallments(paymentMethodId: paymentMethodId, issuerId: paymentInfo?.cardIssuer?.id, amount: amount) { (models:[Installment]?, error: Error?) in
            self.delegate?.stepDidFinishLoading(self, models, error)
        }
        
    }
    
}
