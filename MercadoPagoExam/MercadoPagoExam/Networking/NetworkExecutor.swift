//
//  NetworkManager.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 19/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation


protocol NetworkExecutor {
    
    func execute(request: URLRequest, completionHandler: @escaping ([String : Any]?, Error?) -> Void)
    
    func execute(request: URLRequest, completionHandler: @escaping ([[String : Any]]?, Error?) -> Void)
    
}
