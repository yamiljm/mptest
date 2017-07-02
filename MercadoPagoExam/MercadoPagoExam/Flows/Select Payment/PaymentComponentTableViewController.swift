//
//  PaymentComponentTableViewController.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 26/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import UIKit

class PaymentComponentTableViewController: UITableViewController, PaymentStepable {

    var currentStep: PaymentStep?
    var selectedPayment: SelectedPaymentInfo?
    var dataSource: PaymentMethodComponentDataSource?
//    var viewInformation: ViewInformation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        dataSource = currentStep?.dataSource
//        dataSource?.dataLoaded = dataLoaded
//        dataSource?.viewInformation = viewInformation
        
//        dataSource?.startLoadingData(withInfoFrom: selectedPayment)
        
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
        return CGFloat(48.0)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dataSource?.completePaymentInfo(intoPayment: selectedPayment, withIndexPath: indexPath)
        
        if let cell = tableView.cellForRow(at: indexPath) as? PaymentComponentCellWithoutImage {
            cell.accessoryType = .checkmark
        }
        
        guard let segueIdentifier = dataSource?.viewInformation.segueIdentifier else {
            return
        }
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? PaymentComponentCellWithoutImage {
            cell.accessoryType = .none
        }
    }
    
    
//    func dataLoaded(_ error: Error?) {
//        if error != nil {
//            //TODO: Mostrar error
//            return
//        }
//        
//        if let dataSource = dataSource, dataSource.hasNoData, let identifier = viewInformation?.segueIdentifier {
//                performSegue(withIdentifier: identifier, sender: self)
//        }
//        
//        self.tableView.reloadData()
//    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if var destination = segue.destination as? PaymentStepable {
            if let nextStep = PaymentStepOrderManager.stepAfter(step: currentStep) {
                destination.currentStep = nextStep
                destination.selectedPayment = selectedPayment
            }
        }
    }
    

}
