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
    
//    var service: InstallmentsService?
    
//    var dataLoaded: ((Error?) -> Void)?
    
    var hasNoData: Bool {
        get {
            return models?.isEmpty ?? true
        }
    }
    
    //MARK: PaymentMethodComponentDataSource
    
//    func updateModels(_ installments: [Installment]?, error: Error?) {
//        if error != nil {
//            //TODO: manejar error
//            return
//        }
//        //TODO: revisar si poner waek a self
//        
//        //Asumo que siempre viene una installment
//        self.models = installments?.first?.payerCosts
//        
//        DispatchQueue.main.async {
//            self.dataLoaded?(error)
//        }
//    }
//    
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
        
        //TODO: asumo que siempre vienen un installment
        
        let payerCost = models?[indexPath.row]
        cell.title.text = payerCost?.recommendedMessage
        cell.setSelected(false, animated: false)
        
        return cell
    }
    
    
//    func startLoadingData(withInfoFrom payment: SelectedPaymentInfo?) {
//        
//        guard let paymentId = payment?.method?.id, let amount = payment?.amount else {
//            return
//        }
//        
//        service?.retriveInstallments(paymentMethodId: paymentId, issuerId: payment?.cardIssuer?.id, amount: amount)
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
}
