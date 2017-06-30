//
//  InstallmentsService.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 29/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation


////
////  CardIssuersService.swift
////  MercadoPagoExam
////
////  Created by Yamil Jalil Maluf on 27/6/17.
////  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
////
//
//import Foundation
//
//final class CardIssuersService<C> {
//
//    typealias Model = C
//
//    let apiConnector = PaymentMethodsAPIConnector()
//
//    //TODO: hacerlo weak
//    var delegate: PaymentMethodsServiceDelegate
//
//    init(delegate: PaymentMethodsServiceDelegate) {
//        self.delegate = delegate
//    }
//
//    func retrivePaymentMethods(ofType type: PaymentType?=nil) {
//
//        let onError = { (error: Error) -> Void in
//            self.delegate.informError(error)
//        }
//
//        let onSucces = { (models: [PaymentMethod]?) -> Void in
//            //Acá se podría realizar validaciones sobre los modelos antes de pasarlos al delegate
//            if let type = type {
//                let filteredPaymentMethods = models?.filter {$0.paymentTypeId == type}
//                self.delegate.updatePaymentMethods(filteredPaymentMethods)
//            } else {
//                self.delegate.updatePaymentMethods(models)
//            }
//        }
//
//        let paymentMethodModelCreator = ModelCreator<PaymentMethod>(onSucces: onSucces, onError: onError)
//
//        apiConnector.retrievePaymentMethods(withModelCreator: paymentMethodModelCreator)
//    }
//
//
//    func retriveCardIssuers(paymentMethodId: String) {
//
//        let onError = { (error: Error) -> Void in
//            self.delegate.informError(error)
//        }
//
//        let onSucces = { (models: [CardIssuer]?) -> Void in
//            //Acá se podría realizar validaciones sobre los modelos antes de pasarlos al delegate
//            self.delegate.updateCardIssuers(models)
//        }
//
//        let cardIssuerModelCreator = ModelCreator<CardIssuer>(onSucces: onSucces, onError: onError)
//
//        apiConnector.retriveCardIssuers(forPaymentMethodId: paymentMethodId, withModelCreator: cardIssuerModelCreator)
//    }
//
//    func retriveInstallments(paymentMethodId: String, issuerId: String, amount: Double) {
//
//        let onError = { (error: Error) -> Void in
//            self.delegate.informError(error)
//        }
//
//        let onSucces = { (models: [Installments]?) -> Void in
//            //Acá se podría realizar validaciones sobre los modelos antes de pasarlos al delegate
//            self.delegate.updateInstallments(models)
//        }
//
//        let installmentsModelCreator = ModelCreator<Installments>(onSucces: onSucces, onError: onError)
//
//        apiConnector.retriveInstallments(forPaymentMethodId: paymentMethodId, andIssuerId: issuerId, andAmount: amount, withModelCreator: installmentsModelCreator)
//
//    }
//
//}
