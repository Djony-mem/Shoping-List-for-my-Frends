//
//  SearchItemTableViewCell.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 1/20/21.
//

import UIKit
protocol SearchItemCellDelegate {
    func buttonTapped(sender: SearchItemTableViewCell, check: Bool, itemId: String)
}

class SearchItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkButtonItem: UIButton!
    @IBOutlet weak var nameItem: UILabel!
    @IBOutlet weak var quantityTextField: UITextField!
    
    var itemUid: String?
    var delegate: SearchItemCellDelegate?
    
    func configure(for item: Item,with editStatus: Bool, delegate: SearchItemCellDelegate) {
        self.checkButtonItem.layer.cornerRadius = 12
        self.checkButtonItem.tintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        self.checkButtonItem.setBackgroundImage(UIImage(named: "check"), for: .selected)
        self.checkButtonItem.setBackgroundImage(UIImage(systemName: "plus.circle"), for: .normal)
        self.nameItem.text = item.nameItem
        self.itemUid = item.uid
        
        if editStatus {
            if item.status{
                self.checkButtonItem.tintColor = .green
            }
        }
        
        self.delegate = delegate
    }

}
