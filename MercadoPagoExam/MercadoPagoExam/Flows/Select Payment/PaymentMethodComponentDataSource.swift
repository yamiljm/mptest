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
    
    func startLoadingData(withInfoFrom: SelectedPayment?)
    
    var dataLoaded: ((_ : Error?) -> Void)? {get set}
}
