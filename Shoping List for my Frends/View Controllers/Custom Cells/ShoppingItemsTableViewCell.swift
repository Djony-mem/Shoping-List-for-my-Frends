//
//  ShoppingItemsTableViewCell.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 1/20/21.
//

import UIKit

class ShoppingItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var chekButton: UIButton!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    func configure(product: Product) {
        self.itemName.text = product.title
        self.quantity.text = product.note
        self.chekButton.layer.cornerRadius = 12
        self.chekButton.layer.borderWidth = 3
        self.chekButton.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    }
}
