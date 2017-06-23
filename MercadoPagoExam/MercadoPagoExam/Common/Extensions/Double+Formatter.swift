//
//  Double+Formatter.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 22/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation


extension Formatter {
    static let number = NumberFormatter()
}

extension Double {
    func fractionDigits(min: Int = 2, max: Int = 2, roundingMode: NumberFormatter.RoundingMode = .up) -> String {
        Formatter.number.minimumFractionDigits = min
        Formatter.number.maximumFractionDigits = max
        Formatter.number.roundingMode = roundingMode
//        Formatter.number.numberStyle = .
        return Formatter.number.string(for: self) ?? ""
    }
}
