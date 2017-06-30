//
//  File.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 30/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation


struct ViewInformation {
    
    var cellNibName: String
    var cellIdentifier: String
    var segueIdentifier: String?
    var tableTitle: String?
    
    static func create(forStepType type: PaymentStepType?) -> ViewInformation?  {
        
        guard let type = type else {
            return nil
        }
        
        switch type {
            
        case .method:
            return ViewInformation(cellNibName: "PaymentComponentCellWithImage", cellIdentifier: "PaymentComponentWithImageCell", segueIdentifier: "cardIssuer", tableTitle: "Seleccione un medio de pago")
        case .cardIssuer:
            return ViewInformation(cellNibName: "PaymentComponentCellWithImage", cellIdentifier: "PaymentComponentWithImageCell", segueIdentifier: "installments", tableTitle: "Seleccione un emisor")
        case .installments:
            return ViewInformation(cellNibName: "PaymentComponentCellWithoutImage", cellIdentifier: "PaymentComponentCellWithoutImage", segueIdentifier: nil, tableTitle: "Seleccione cantidad de cuotas")
        default:
            return nil
            
        }
    }
}
