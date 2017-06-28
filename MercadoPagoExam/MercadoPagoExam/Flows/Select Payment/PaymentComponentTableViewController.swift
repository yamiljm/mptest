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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = currentStep?.dataSource
        dataSource?.dataLoaded = dataLoaded
        
        dataSource?.startLoadingData(withInfoFrom: selectedPayment)
        
        tableView.delegate = dataSource
        
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
    
    func dataLoaded(_ error: Error?) {
        if error != nil {
            //TODO: Mostrar error
            return
        }
        tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
