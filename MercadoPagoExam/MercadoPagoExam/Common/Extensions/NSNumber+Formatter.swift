4//
//  Double+Formatter.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 22/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

//protocol DecimalDescriptable {
//    func fractionDigits(min: Int, max: Int, roundingMode: NumberFormatter.RoundingMode) -> String
//}

extension Formatter {
    static let number = NumberFormatter()
}

//extension DecimalDescriptable {
//    func fractionDigits(min: Int = 2, max: Int = 2, roundingMode: NumberFormatter.RoundingMode = .up) -> String {
//        Formatter.number.minimumFractionDigits = min
//        Formatter.number.maximumFractionDigits = max
//        Formatter.number.roundingMode = roundingMode
//        return Formatter.number.string(for: self) ?? ""
//    }
//}


//TODO: revisar2
extension NSNumber {//: DecimalDescriptable {

    func fractionDigits(min: Int = 2, max: Int = 2, roundingMode: NumberFormatter.RoundingMode = .up) -> String {
        Formatter.number.minimumFractionDigits = min
        Formatter.number.maximumFractionDigits = max
        Formatter.number.roundingMode = roundingMode
        return Formatter.number.string(for: self) ?? ""
    }
}

extension Double { //: DecimalDescriptable {
    func fractionDigits(min: Int = 2, max: Int = 2, roundingMode: NumberFormatter.RoundingMode = .up) -> String {
        Formatter.number.minimumFractionDigits = min
        Formatter.number.maximumFractionDigits = max
        Formatter.number.roundingMode = roundingMode
        return Formatter.number.string(for: self) ?? ""
    }
}
