//
//  SearchItemTableViewCell.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 1/20/21.
//

import UIKit

class SearchItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkButtonItem: UIButton!
    @IBOutlet weak var nameItem: UILabel!
    @IBOutlet weak var quantityTextField: UITextField!
    
    
    func configure(item: Item) {
        self.checkButtonItem.layer.cornerRadius = 12
//        self.checkButtonItem.layer.borderWidth = 2
//        self.checkButtonItem.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        self.checkButtonItem.tintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        self.nameItem.text = item.nameItem
        
        if let quantity = quantityTextField.text, quantity != "" {
           
        }
    }

}
