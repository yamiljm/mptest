//
//  PaymentNavigationControler.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 2/7/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import UIKit

class PaymentNavigationControler: UINavigationController {
    
    let flowManager = SelectPaymentFlowManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        flowManager.navigationController = self
        flowManager.start()

    }

}
