//
//  SelectPaymentFlowManager.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 2/7/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//


import UIKit


class SelectPaymentFlowManager: StepDelegate {
    
    weak var navigationController: UINavigationController?

    var selectedPaymentInfo = SelectedPaymentInfo()
    
    private var stepsManager = PaymentStepOrderManager()
    
    func start() {
        var step = stepsManager.first()
        
        if step.needExternalData {
            step.delegate = self
            step.execute(withCurrentPaymentInfo: selectedPaymentInfo)
        } else {
            present(step: step)
        }
    }
    
    func stepDidFinishLoading(_ currentStep: PaymentStep, _ models: [Any]?, _ error: Error?){
        
        if error != nil {
            //TODO: handle error
            showErrorScreen(error)
        }
        
        if currentStep.shouldBeOmitted {
            executeNextStep(afterStep: currentStep, withCurrentPaymentInfo: selectedPaymentInfo)
        } else {
            DispatchQueue.main.async {
                self.present(step: currentStep, withModels: models)
            }
        }
    }
    
    private func present(step: PaymentStep, withModels models: [Any]?=nil){
        
        dismissLoadingScreen()
        
        switch step.type {
        case .amount:
            showAmountScreen(currentStep: step)
        case .method:
            showPaymentMethodTypeScreen(currentStep: step, withModels: models)
        case .cardIssuer:
            showCardIssuerScreen(currentStep: step, withModels: models)
        case .installments:
            showInstallmentsScreen(currentStep: step, withModels: models)
        }
    }
    
    func userDidCompleteInfo(forStep currentStep: PaymentStep?, withPaymentInfo updatedPaymentInfo: SelectedPaymentInfo?) {
        
        guard let currentStep = currentStep else {
            showErrorScreen(MercadoPagoError.app.internalError)
            return
        }
        
        executeNextStep(afterStep: currentStep, withCurrentPaymentInfo: selectedPaymentInfo)
    }
    
    private func executeNextStep(afterStep currentStep: PaymentStep?, withCurrentPaymentInfo paymentInfo: SelectedPaymentInfo?) {
        
        var step = stepsManager.nextStep(afterStep: currentStep, withCurrentPaymentInfo: selectedPaymentInfo)
        step.delegate = self
        
        if step.isFinal {
            navigationController?.viewControllers = []
        }
        
        if step.needExternalData {
            step.execute(withCurrentPaymentInfo: selectedPaymentInfo)
        } else {
            DispatchQueue.main.async {
                self.present(step: step)
            }
        }
    }
    
    private func showAmountScreen(currentStep: PaymentStep) {
        guard let amountViewController = PaymentStoryboardHelper.getViewController(identifier: PaymentStoryboardHelper.Identifiers.amountViewControllerId) as? PaymentMethodAmountViewController else {
            showErrorScreen()
            return
        }
        
        amountViewController.currentStep = currentStep
        amountViewController.selectedPaymentInfo = selectedPaymentInfo
        amountViewController.flowManager = self
        
        navigationController?.pushViewController(amountViewController, animated: true)
    }
    
    private func showPaymentMethodTypeScreen(currentStep: PaymentStep, withModels models: [Any]?) {
        guard let paymentMethodViewController = PaymentStoryboardHelper.getViewController(identifier: PaymentStoryboardHelper.Identifiers.methodsViewControllerId) as? PaymentComponentTableViewController else {
            showErrorScreen()
            return
        }
        
        paymentMethodViewController.currentStep = currentStep
        paymentMethodViewController.selectedPaymentInfo = selectedPaymentInfo
        paymentMethodViewController.flowManager = self
        paymentMethodViewController.dataSource = PaymentMethodDataSource(withModels: models)
        
        navigationController?.pushViewController(paymentMethodViewController, animated: true)
    }
    
    
    private func showCardIssuerScreen(currentStep: PaymentStep, withModels models: [Any]?) {
        guard let cardIssuersViewController = PaymentStoryboardHelper.getViewController(identifier: PaymentStoryboardHelper.Identifiers.cardIssuersControllerId) as? PaymentComponentTableViewController else {
            showErrorScreen()
            return
        }
        
        cardIssuersViewController.currentStep = currentStep
        cardIssuersViewController.selectedPaymentInfo = selectedPaymentInfo
        cardIssuersViewController.flowManager = self
        cardIssuersViewController.dataSource = CardIssuersDataSource(withModels: models)
        
        navigationController?.pushViewController(cardIssuersViewController, animated: true)
    }
    
    
    private func showInstallmentsScreen(currentStep: PaymentStep, withModels models: [Any]?) {
        guard let installmentsViewController = PaymentStoryboardHelper.getViewController(identifier: PaymentStoryboardHelper.Identifiers.installmentsControllerId) as? InstallmentsViewController else {
            showErrorScreen()
            return
        }
        
        installmentsViewController.currentStep = currentStep
        installmentsViewController.selectedPaymentInfo = selectedPaymentInfo
        installmentsViewController.flowManager = self
        installmentsViewController.dataSource = InstallmentsDataSource(withModels: models)
        
        navigationController?.pushViewController(installmentsViewController, animated: true)
    }
    
    func presentPaymentInfoMessage(_ selectedPayment: SelectedPaymentInfo) {
        //TODO: internacionalizar title
        
        guard let description = selectedPaymentInfo.attributedDescription() else {
            showErrorScreen(MercadoPagoError.app.internalError)
            return
        }
        
        presentAlertController(title: "Pago seleccionado", attributedMessage: description)
        selectedPaymentInfo.clear()
    }
    
    func showErrorScreen(_ error: Error?=nil) {
        presentAlertController(title: "Error", message: error?.localizedDescription)
    }
    
    private func presentAlertController(title: String, message: String?=nil, attributedMessage: NSAttributedString?=nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(okAction)
        
        if let attributedMessage = attributedMessage {
            alertController.setValue(attributedMessage, forKey: "attributedMessage")
        }
        
        navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    func stepWillRetrieveData() {
        showLoadingScreen()
    }
    
    func showLoadingScreen() {
        guard let view = navigationController?.topViewController?.view else {
            return
        }
        ProgressView.shared.start(intoView: view)
    }
    
    func dismissLoadingScreen() {
        ProgressView.shared.stop()
    }
    
}
