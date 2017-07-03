//
//  CardIssuersDataSource.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 29/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class CardIssuersDataSource: NSObject, PaymentMethodComponentDataSource {
    
    let viewInformation = TableViewInformation(cellNibName: "PaymentComponentCellWithImage", cellIdentifier: "PaymentComponentWithImageCell", segueIdentifier: "installments", tableTitle: "Seleccione un emisor")
    
    var models: [CardIssuer]?
    
    let useButton = false
    
    required init(withModels models: [Any]?) {
        self.models = models as? [CardIssuer]
    }
    
    //MARK: PaymentMethodComponentDataSource
    
    func completePaymentInfo(intoPayment payment: SelectedPaymentInfo?, withIndexPath index: IndexPath) {
        guard let cardIssuers = models, index.row < cardIssuers.count else {
            return
        }
        payment?.cardIssuer = cardIssuers[index.row]
    }
    
    func removePaymentInfo(from paymentInfo: SelectedPaymentInfo) {
        if !paymentInfo.isComplete {
            paymentInfo.cardIssuer = nil
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: viewInformation.cellIdentifier, for: indexPath) as? PaymentComponentWithImageCell else {
            return UITableViewCell()
        }
        let cardIssuer = models?[indexPath.row]
        cell.title.text = cardIssuer?.name
        cell.setSelected(false, animated: false)
        
        if let urlText = cardIssuer?.secureThumbnail, let url = URL(string: urlText) {
            Nuke.loadImage(with: url, into: cell.cardImage)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
}


