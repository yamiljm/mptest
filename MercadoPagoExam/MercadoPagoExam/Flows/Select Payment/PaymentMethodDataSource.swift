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

    let viewInformation = TableViewInformation(cellNibName: "PaymentComponentCellWithImage", cellIdentifier: "PaymentComponentWithImageCell", segueIdentifier: "cardIssuer", tableTitle: "Seleccione un medio de pago")
    
    var models: [PaymentMethod]?

    var selectedPaymentMethod: PaymentMethod?
    
    let useButton = false
    
    required init(withModels models: [Any]?) {
        self.models = models as? [PaymentMethod]
    }
    
    //MARK: PaymentMethodComponentDataSource
    
    func completePaymentInfo(intoPayment payment: SelectedPaymentInfo?, withIndexPath index: IndexPath) {
        guard let paymentMethods = models, index.row < paymentMethods.count else {
            return
        }
        payment?.method = paymentMethods[index.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: viewInformation.cellIdentifier, for: indexPath) as? PaymentComponentWithImageCell else {
            return UITableViewCell()
        }
        let paymentMethod = models?[indexPath.row]
        cell.title.text = paymentMethod?.name
        cell.setSelected(false, animated: false)

        if let urlText = paymentMethod?.secureThumbnail, let url = URL(string: urlText) {
            Nuke.loadImage(with: url, into: cell.cardImage)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
}
