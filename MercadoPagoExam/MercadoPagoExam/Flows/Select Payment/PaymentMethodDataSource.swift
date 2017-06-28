//
//  PaymentMethodDataSource.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 27/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation
import UIKit

class PaymentMethodDataSource: NSObject, UITableViewDelegate, PaymentMethodComponentDataSource {

    
    let cellIdentifier = "paymentComponentWithImageCell"
    
    var paymentMethods: [PaymentMethod]?

    var service: PaymentMethodsService?
    
//    weak var tableView: UITableView?
    
    var dataLoaded: ((Error?) -> Void)?
    
    override init() {
        super.init()
        self.service = PaymentMethodsService(delegate: updateModels)
    }
    
    func updateModels(_ paymentMethods: [PaymentMethod]?, error: Error?) {
        if error != nil {
            //TODO: manejar error
            return
        }
        //TODO: revisar si poner waek a self
        self.paymentMethods = paymentMethods
        self.dataLoaded?(error)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PaymentComponentWithImageCell else {
            return UITableViewCell()
        }
        cell.title.text = paymentMethods?[indexPath.row].name
        
        return cell
    }

    func startLoadingData(withInfoFrom: SelectedPayment?) {
        service?.retrivePaymentMethods(ofType: .creditCard)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //TODO: internacionalizar
        return "Seleccione un medio de pago"
    }
    
    
    
}
