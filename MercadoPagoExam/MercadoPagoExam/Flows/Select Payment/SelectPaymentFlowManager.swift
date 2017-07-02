//
//  SelectPaymentFlowManager.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 2/7/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//


import UIKit


class SelectPaymentFlowManager: StepDelegate {
    
    private struct Constants {
        static let amountViewControllerId = "amountViewController"
    }
    
    weak var navigationController: UINavigationController?
    
    var selectedPaymentInfo = SelectedPaymentInfo()
    
    private var stepsManager = PaymentStepOrderManager()
    
    private var loadingScreenIsActive = false
    
    private let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
    
    init(navigationController: UINavigationController, stepsManager: PaymentStepOrderManager){
        self.navigationController = navigationController
        self.stepsManager = stepsManager
    }
    
    func start() {
        var step = stepsManager.first()
        step.delegate = self
        
        if step.needExternalData {
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
            let step = stepsManager.nextStep(after: currentStep, withCurrentPaymentInfo: selectedPaymentInfo)
            step.execute(withCurrentPaymentInfo: selectedPaymentInfo)
        } else {
            DispatchQueue.main.async {
                self.present(step: currentStep, withModels: models)
            }
        }
    }
    
    private func present(step: PaymentStep, withModels models: [Any]?=nil){
        
        if loadingScreenIsActive {
            dismissLoadingScreen()
        }
        
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
    
    func userDidCompleteInfo(forStep step: PaymentStep, withPaymentInfo updatedPaymentInfo: SelectedPaymentInfo) {
//        selectedPaymentInfo = updatedPaymentInfo
        let step = stepsManager.nextStep(after: step, withCurrentPaymentInfo: selectedPaymentInfo)
        step.execute(withCurrentPaymentInfo: selectedPaymentInfo)
    }
    
    private func showAmountScreen(currentStep: PaymentStep) {
        let amountViewController = storyboard.instantiateViewController(withIdentifier: Constants.amountViewControllerId)
        
        
    }
    
    private func showPaymentMethodTypeScreen(currentStep: PaymentStep, withModels models: [Any]?) {
        
    }
    
    
    private func showCardIssuerScreen(currentStep: PaymentStep, withModels models: [Any]?) {
        
    }
    
    
    private func showInstallmentsScreen(currentStep: PaymentStep, withModels models: [Any]?) {
        
    }
    
    func stepWillRetrieveData() {
        showLoadingScreen()
    }
    
    func showLoadingScreen() {
        loadingScreenIsActive = true
        
        //TODO: completar
        
    }
    
    func dismissLoadingScreen() {
        
        //TODO: completar
        loadingScreenIsActive = false
        
    }
    
    func showErrorScreen(_ error: Error?) {
        
    }
}
