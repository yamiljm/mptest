//
//  StepTyep.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 2/7/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

protocol StepType {
    
    var isOptional: Bool {get set}
    
    var delegate: StepDelegate? {get set}
    
    func execute(withCurrentPaymentInfo: SelectedPaymentInfo?)
    
    func shouldBeOmitted() -> Bool
    
}
