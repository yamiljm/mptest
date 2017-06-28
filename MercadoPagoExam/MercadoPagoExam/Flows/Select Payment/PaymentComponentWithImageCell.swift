//
//  PaymentComponentWithImageCell.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 28/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import UIKit

class PaymentComponentWithImageCell: UITableViewCell {
    
    @IBOutlet weak var cardImage: UIImageView!

    @IBOutlet weak var title: UILabel!
    
    let cornerRadius = CGFloat(floatLiteral: 10.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardImage.layer.cornerRadius = cornerRadius
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
