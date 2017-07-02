//
//  PaymentMethodDataSource.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 27/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class PaymentMethodDataSource: NSObject, PaymentMethodComponentDataSource {

    var viewInformation: ViewInformation?
    
    var paymentMethods: [PaymentMethod]?

    var service: PaymentMethodsService?
    
    var dataLoaded: ((Error?) -> Void)?
    
    var selectedPaymentMethod: PaymentMethod?
    
    override init() {
        super.init()
        self.service = PaymentMethodsService(delegate: updateModels)
    }
    
    //MARK: PaymentMethodComponentDataSource
    
    func updateModels(_ paymentMethods: [PaymentMethod]?, error: Error?) {
        if error != nil {
            //TODO: manejar error
            return
        }
        //TODO: revisar si poner waek a self
        self.paymentMethods = paymentMethods
        
        DispatchQueue.main.async {
            self.dataLoaded?(error)
        }
    }
    
    func completePaymentInfo(intoPayment payment: SelectedPayment?, withIndexPath index: IndexPath) {
        guard let paymentMethods = paymentMethods, index.row < paymentMethods.count else {
            return
        }
        payment?.method = paymentMethods[index.row]
    }
    
    func startLoadingData(withInfoFrom payment: SelectedPayment?) {
        service?.retrivePaymentMethods(ofType: .creditCard)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellIdentifier = viewInformation?.cellIdentifier, let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PaymentComponentWithImageCell else {
            return UITableViewCell()
        }
        let paymentMethod = paymentMethods?[indexPath.row]
        cell.title.text = paymentMethod?.name
        cell.setSelected(false, animated: false)

        if let urlText = paymentMethod?.secureThumbnail, let url = URL(string: urlText) {
            Nuke.loadImage(with: url, into: cell.cardImage)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods?.count ?? 0
    }
    
}
