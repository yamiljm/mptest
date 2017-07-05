//
//  PaymentComponentTableViewController.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 26/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import UIKit

class PaymentComponentTableViewController: UITableViewController, PaymentScreen {

    var selectedPaymentInfo: SelectedPaymentInfo?
    var currentStep: PaymentStep?
    var dataSource: PaymentMethodComponentDataSource?
    weak var flowManager: SelectPaymentFlowManager?
    private let defaultHeaderHeight = CGFloat(48)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
        if let nib = dataSource?.viewInformation.cellNibName, let identifier = dataSource?.viewInformation.cellIdentifier {
            let uiNib = UINib(nibName: nib, bundle: Bundle.main)
            self.tableView?.register(uiNib, forCellReuseIdentifier: identifier)
        }
        
        self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.numberOfSections?(in: tableView) ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: fix this
        return (dataSource?.tableView(tableView, cellForRowAt: indexPath))!
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource?.viewInformation.tableTitle
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //TODO: sacar a constantes
        return defaultHeaderHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dataSource?.completePaymentInfo(intoPayment: selectedPaymentInfo, withIndexPath: indexPath)
        
        if let cell = tableView.cellForRow(at: indexPath) as? PaymentComponentCellWithoutImage {
            cell.accessoryType = .checkmark
        }
        
        if !(dataSource?.useButton ?? false) {
            flowManager?.userDidCompleteInfo(forStep: currentStep, withPaymentInfo: selectedPaymentInfo)
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? PaymentComponentCellWithoutImage {
            cell.accessoryType = .none
        }
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
    
        super.didMove(toParentViewController: parent)
        
        if let selectedPayment = selectedPaymentInfo, parent == self.navigationController?.parent {
            dataSource?.removePaymentInfo(from: selectedPayment)
        }
    }

}
