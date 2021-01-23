//
//  SearchItemTableViewCell.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 1/20/21.
//

import UIKit
protocol SearchItemCellDelegate {
    func buttonTapped(sender: SearchItemTableViewCell, check: Bool, item: Item)
}

class SearchItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkButtonItem: UIButton!
    @IBOutlet weak var nameItem: UILabel!
    @IBOutlet weak var quantityTextField: UITextField!
    
    var item: Item!
    var delegate: SearchItemCellDelegate?
    
    func configure(for item: Item,with editStatus: Bool, delegate: SearchItemCellDelegate) {
        self.checkButtonItem.layer.cornerRadius = 14
        self.checkButtonItem.tintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        self.checkButtonItem.setBackgroundImage(UIImage(systemName: "plus.circle"), for: .normal)
        self.nameItem.text = item.nameItem
        self.item = item

            if item.status{
                self.checkButtonItem.tintColor = .green
                self.checkButtonItem.setBackgroundImage(UIImage(named: "check"), for: .selected)
            }
        
        self.delegate = delegate
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(sender: self, check: true, item: item)
        item.status = true
        self.checkButtonItem.tintColor = .white
        self.checkButtonItem.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        self.checkButtonItem.setBackgroundImage(UIImage(named: "hand.thumbsup"), for: .normal
        )
        print("button tapped")
    }

}
