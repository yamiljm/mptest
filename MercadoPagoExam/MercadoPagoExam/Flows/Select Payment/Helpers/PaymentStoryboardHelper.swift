//
//  StoryboardHelper.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 2/7/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import UIKit


struct PaymentStoryboardHelper {
    
    static let mainStoryBoard = "Main"
    
    struct Identifiers {
        static let amountViewControllerId = "amountViewController"
        static let methodsViewControllerId = "paymentMethodViewController"
        static let cardIssuersControllerId = "cardIssuersViewController"
        static let installmentsControllerId = "installmentsViewController"
        static let navigationController = "paymentNavigationController"
    }
    
    static let storyboard = UIStoryboard(name: mainStoryBoard, bundle: nil)
    
    static func getViewController(identifier: String) -> UIViewController {
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }

}
