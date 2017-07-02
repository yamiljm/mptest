//
//  InstallmentsViewController.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 29/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import UIKit

class InstallmentsViewController: UIViewController, PaymentStepable {

    @IBOutlet weak var finishButton: UIButton!
    
    @IBOutlet weak var tableViewContainer: UIView!
    
    var selectedPayment: SelectedPaymentInfo?
    var currentStep: PaymentStep?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "installmentsTable" {
            guard let tableViewController = segue.destination as? PaymentComponentTableViewController else {
                return
            }
            tableViewController.currentStep = currentStep
            tableViewController.selectedPayment = selectedPayment
        }
    }
    

}
