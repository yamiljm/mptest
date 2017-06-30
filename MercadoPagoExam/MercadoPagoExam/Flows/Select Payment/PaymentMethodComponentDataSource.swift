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
    
    var viewInformation: ViewInformation? {get set}
    
    var dataLoaded: ((_ : Error?) -> Void)? {get set}
    
    func startLoadingData(withInfoFrom: SelectedPayment?)
    
    func completePaymentInfo(intoPayment payment: SelectedPayment?, withIndexPath index: IndexPath)
    
}
