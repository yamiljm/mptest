//
//  URLSessionNetworkExecutor.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 19/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

struct URLSessionNetworkExecutor: NetworkExecutor {
    
 
    func execute(request: URLRequest, completionHandler: @escaping ([String : Any]?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            if error != nil {
                completionHandler(nil, error)
                return
            }
            
            //TODO chequear errores de http en response
            
            guard let data = data else {
                completionHandler(nil, nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                completionHandler(json, nil)
                return
            }
            catch {
                completionHandler(nil, MercadoPagoError.api.invalidDataFromServer)
                return
            }
            
        })
        
        task.resume()
        
    }
    
    func execute(request: URLRequest, completionHandler: @escaping ([[String : Any]]?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            if error != nil {
                completionHandler(nil, error)
                return
            }
            
            //TODO chequear errores de http en response
            
            guard let data = data else {
                completionHandler(nil, nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]]
                completionHandler(json, nil)
                return
            }
            catch {
                completionHandler(nil, MercadoPagoError.api.invalidDataFromServer)
                return
            }
            
        })
        
        task.resume()
        
    }
    
}
