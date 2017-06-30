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
    var selectedPayment: SelectedPayment?
    var dataSource: PaymentMethodComponentDataSource?
    var viewInformation: ViewInformation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewInformation = ViewInformation.create(forStepType: currentStep?.type)

        dataSource = currentStep?.dataSource
        dataSource?.dataLoaded = dataLoaded
        dataSource?.viewInformation = viewInformation
        
        dataSource?.startLoadingData(withInfoFrom: selectedPayment)
        
        tableView.delegate = self
        
        
        if let nib = viewInformation?.cellNibName, let identifier = viewInformation?.cellIdentifier {
            
            let uiNib = UINib(nibName: nib, bundle: Bundle.main)
            
            self.tableView?.register(uiNib, forCellReuseIdentifier: identifier)
        }
        
        self.clearsSelectionOnViewWillAppear = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        dataSource?.completePaymentInfo(intoPayment: selectedPayment, withIndexPath: indexPath)
        
        guard let segueIdentifier = viewInformation?.segueIdentifier else {
            return
        }
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    
    func dataLoaded(_ error: Error?) {
        if error != nil {
            //TODO: Mostrar error
            return
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
//        dataSource?.completePaymentInfo(tableView,intoPayment: selectedPayment)
        
        if segue.destination.isKind(of: PaymentComponentTableViewController.self) {
            let destination = segue.destination as? PaymentComponentTableViewController
            if let nextStep = PaymentStepOrderManager.stepAfter(step: currentStep) {
                destination?.currentStep = nextStep
                destination?.selectedPayment = selectedPayment
            }
        }
    }
    

}
