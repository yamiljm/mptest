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
    
    var viewInformation: ViewInformation?
    
    var cardIssuers: [CardIssuer]?
    
    var service: CardIssuersService?
    
    var dataLoaded: ((Error?) -> Void)?
    
    override init() {
        super.init()
        self.service = CardIssuersService(delegate: updateModels)
    }
    
    //MARK: PaymentMethodComponentDataSource
    
    func updateModels(_ cardIssuers: [CardIssuer]?, error: Error?) {
        if error != nil {
            //TODO: manejar error
            return
        }
        //TODO: revisar si poner waek a self
        self.cardIssuers = cardIssuers
        self.dataLoaded?(error)
    }
    
    func completePaymentInfo(intoPayment payment: SelectedPayment?, withIndexPath index: IndexPath) {
        guard let cardIssuers = cardIssuers, index.row < cardIssuers.count else {
            return
        }
        payment?.cardIssuer = cardIssuers[index.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellIdentifier = viewInformation?.cellIdentifier, let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PaymentComponentWithImageCell else {
            return UITableViewCell()
        }
        let cardIssuer = cardIssuers?[indexPath.row]
        cell.title.text = cardIssuer?.name
        cell.setSelected(false, animated: false)
        
        if let urlText = cardIssuer?.secureThumbnail, let url = URL(string: urlText) {
            Nuke.loadImage(with: url, into: cell.cardImage)
        }
        return cell
    }
    
    
    func startLoadingData(withInfoFrom payment: SelectedPayment?) {
        
        guard let id = payment?.method?.id else {
            return
        }
        
        service?.retriveCardIssuers(paymentMethodId: id)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardIssuers?.count ?? 0
    }
    
}

