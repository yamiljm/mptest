//
//  InstallmentsDataSource.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 30/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class InstallmentsDataSource: NSObject, PaymentMethodComponentDataSource {
    
    var viewInformation: ViewInformation?
    
    var installmentsPayerCosts: [PayerCosts]?
    
    var service: InstallmentsService?
    
    var dataLoaded: ((Error?) -> Void)?
    
    override init() {
        super.init()
        self.service = InstallmentsService(delegate: updateModels)
    }
    
    //MARK: PaymentMethodComponentDataSource
    
    func updateModels(_ installments: [Installments]?, error: Error?) {
        if error != nil {
            //TODO: manejar error
            return
        }
        //TODO: revisar si poner waek a self
        
        //Asumo que siempre viene una installment
        self.installmentsPayerCosts = installments?.first?.payerCosts
        
        DispatchQueue.main.async {
            self.dataLoaded?(error)
        }
    }
    
    func completePaymentInfo(intoPayment payment: SelectedPayment?, withIndexPath index: IndexPath) {
        guard let payerCosts = installmentsPayerCosts, index.row < payerCosts.count else {
            return
        }
        payment?.installmentsPayerCost = payerCosts[index.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellIdentifier = viewInformation?.cellIdentifier, let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PaymentComponentCellWithoutImage else {
            return UITableViewCell()
        }
        
        //TODO: asumo que siempre vienen un installment
        
        let payerCost = installmentsPayerCosts?[indexPath.row]
        cell.title.text = payerCost?.recommendedMessage
        cell.setSelected(false, animated: false)
        
        return cell
    }
    
    
    func startLoadingData(withInfoFrom payment: SelectedPayment?) {
        
        guard let paymentId = payment?.method?.id, let issuerId = payment?.cardIssuer?.id, let amount = payment?.amount else {
            return
        }
        
        service?.retriveInstallments(paymentMethodId: paymentId, issuerId: issuerId, amount: amount)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return installmentsPayerCosts?.count ?? 0
    }
    
}
