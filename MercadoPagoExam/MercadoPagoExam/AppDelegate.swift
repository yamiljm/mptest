//
//  AppDelegate.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 17/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PaymentMethodsServiceDelegate {
    
    var window: UIWindow?
    
    //TODO: borrar, solo para pruebas
    var paymentService: PaymentMethodsService?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //TODO: Borrar. Solo para testeo
        paymentService = PaymentMethodsService(delegate: self)
    
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
        //TODO: borrar. Solo para probar servicios.
        paymentService?.retriveInstallments(paymentMethodId: "visa", issuerId: "288", amount: 1777.243)
        //        paymentService?.retrivePaymentMethods()
        //        paymentService?.retriveCardIssuers(paymentMethodId: "visa")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

//TODO: borrar. solo para testeo
    func updatePaymentMethods(_ paymentMethods: [PaymentMethod]?){
        paymentMethods?.forEach({ (payment: PaymentMethod) in
            print("Name: \(String(describing: payment.name))\n")
        })
    }
    
    func updateInstallments(_ installments: [Installments]?) {
        
        installments?.forEach({ (installment: Installments) in
            print("Cuotas recomendadas \(String(describing: installment.payerCosts?[0].recommendedMessage))")
        })
        
        
    }
    
    func updateCardIssuers(_ cardIssuers: [CardIssuer]?) {
        cardIssuers?.forEach({ (issuer: CardIssuer) in
            
            print("Issuers: \(issuer.name)")
        })
    }
    
    func informError(_ error: Error) {
        print("ERROR \(error.localizedDescription)")
    }
    
}

