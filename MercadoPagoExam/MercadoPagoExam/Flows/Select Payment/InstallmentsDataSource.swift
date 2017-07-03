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
    
    let viewInformation = TableViewInformation(cellNibName: "PaymentComponentCellWithoutImage", cellIdentifier: "PaymentComponentCellWithoutImage", segueIdentifier: nil, tableTitle: "Seleccione cantidad de cuotas")

    
    var models: [PayerCosts]?
    
    let useButton = true
    
    required init(withModels models: [Any]?) {
        
        //Asumo que siempre viene un installment
        let installment = models?.first as? Installment
        self.models = installment?.payerCosts
    }
    
    //MARK: PaymentMethodComponentDataSource

    func completePaymentInfo(intoPayment payment: SelectedPaymentInfo?, withIndexPath index: IndexPath) {
        guard let payerCosts = models, index.row < payerCosts.count else {
            return
        }
        payment?.installmentsPayerCost = payerCosts[index.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: viewInformation.cellIdentifier, for: indexPath) as? PaymentComponentCellWithoutImage else {
            return UITableViewCell()
        }
        
        let payerCost = models?[indexPath.row]
        cell.title.text = payerCost?.recommendedMessage
        cell.setSelected(false, animated: false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
}
