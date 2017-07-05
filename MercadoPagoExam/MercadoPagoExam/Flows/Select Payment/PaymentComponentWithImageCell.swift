//
//  PaymentComponentWithImageCell.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 28/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import UIKit

class PaymentComponentWithImageCell: UITableViewCell {
    
    @IBOutlet weak var cardViewContainer: UIView!
    @IBOutlet weak var cardImage: UIImageView!

    @IBOutlet weak var title: UILabel!
    
    let cornerRadius = CGFloat(floatLiteral: 10.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()

        cardImage.layer.cornerRadius = cornerRadius
        cardViewContainer.layer.cornerRadius = CGFloat(5)
        cardViewContainer.layer.borderColor = UIColor.lightGray.cgColor
        cardViewContainer.layer.borderWidth = 0.5

    }

}
