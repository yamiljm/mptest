//
//  InstallmentsViewController.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 29/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import UIKit

class InstallmentsViewController: UIViewController, PaymentScreen {

    @IBOutlet weak var finishButton: UIButton!
    
    @IBOutlet weak var tableViewContainer: UIView!
    
    weak var selectedPaymentInfo: SelectedPaymentInfo?
    var currentStep: PaymentStep?
    var dataSource: PaymentMethodComponentDataSource?
    weak var flowManager: SelectPaymentFlowManager?
    private weak var tableView: UITableView?
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "installmentsTable" {
            guard let tableViewController = segue.destination as? PaymentComponentTableViewController else {
                return
            }
            tableViewController.currentStep = currentStep
            tableViewController.selectedPaymentInfo = selectedPaymentInfo
            tableViewController.dataSource = dataSource
            self.tableView = tableViewController.tableView
        }
    }
    
    @IBAction func finishButtonPressed(_ sender: UIButton) {
        
        if selectedPaymentInfo?.installmentsPayerCost != nil {
            selectedPaymentInfo?.isComplete = true
            flowManager?.userDidCompleteInfo(forStep: currentStep, withPaymentInfo: selectedPaymentInfo)
        }
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        if let selectedPayment = selectedPaymentInfo, parent == self.navigationController?.parent {
            dataSource?.removePaymentInfo(from: selectedPayment)
        }
    }

}

