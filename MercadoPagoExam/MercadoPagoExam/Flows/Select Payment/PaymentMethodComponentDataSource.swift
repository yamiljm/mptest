//
//  PaymentMethodDataSource.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 27/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation
import UIKit

protocol PaymentMethodComponentDataSource: UITableViewDataSource, UITableViewDelegate {

    var viewInformation: TableViewInformation {get}
    
//    var hasNoData: Bool {get}
    
    //TODO: revisar
    var useButton: Bool {get}
    
    init(withModels models: [Any]?)
    
    func completePaymentInfo(intoPayment payment: SelectedPaymentInfo?, withIndexPath index: IndexPath)
    
    func removePaymentInfo(from paymentInfo: SelectedPaymentInfo)
}


