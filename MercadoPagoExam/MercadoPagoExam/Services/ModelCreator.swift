//
//  ModelCreator.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 22/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation
import Gloss

struct ModelCreator<M: Decodable> {
    
    let onSucces: (_ models: [M]?) -> Void
    let onError: (_ error: Error) -> Void
    
    //TODO: Acá faltaría generalizar/implementar que se pueda crear a partir de un 
    //json cuyo root sea un objeto
    
    func createModels(json: [[String : Any]]?, error: Error?) {
        if let error = error {
            onError(error)
            return
        }
        
        guard let json = json else {
            onSucces(nil)
            return
        }
        
        var models = [M]()
        
        for modelJson in json {
            if let oneModel = M(json: modelJson) {
                models.append(oneModel)
            }
        }
        
        onSucces(models)
    }
    
}
