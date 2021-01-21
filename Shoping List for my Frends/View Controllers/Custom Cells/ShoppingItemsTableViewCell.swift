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
        if product.completed {
            self.chekButton.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            self.chekButton.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            self.itemName.alpha = 0.3
        } else {
            self.chekButton.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }
    }
}
