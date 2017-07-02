//
//  StepDelegate.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 2/7/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

protocol StepDelegate {
    
    func stepWillRetrieveData()
    
    func stepDidFinishLoading(_ currentStep: PaymentStep, _ models: [Any]?, _ error: Error?)
}
