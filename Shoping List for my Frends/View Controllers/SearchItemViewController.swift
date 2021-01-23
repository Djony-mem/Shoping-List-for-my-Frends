//
//  ListViewController.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 12/5/20.
//

import UIKit
import Firebase

class SearchItemViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField?
    @IBOutlet weak var quantityTextField: UITextField?
    @IBOutlet weak var filterSegntedControl: UISegmentedControl!
    @IBOutlet weak var tableViewItems: UITableView!
    
    var user: AppUser?
    var shopList: List!
    var items: [Product] = []
    var itemsRef: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let userApp = user else { return }
        itemsRef = DatabaseService.shared.getItemRef(uid: userApp.uid)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemsRef?.observe(.value) {[weak self] snapshot in
            self?.items = Product.getShopingItem(snapshot: snapshot) ?? []
            self?.tableViewItems.reloadData()
        }
    }
    
    @IBAction func addResultTappedButton(_ sender: UIButton) {
//        
//        guard let searchTF = searchTextField?.text, searchTF != "" else { return dismiss(animated: true) }
//        guard let userApp = user else { return }
//        let note = quantityTextField?.text
//        let product = Product(title: searchTF,
//                              uid: userApp.uid,
//                              note: note ?? "")
//        guard let shopList = shopList else { return }
//        
//        DatabaseService.shared.getListRef(uid: userApp.uid, list: shopList).child(product.title.lowercased()).setValue(product.convertedDictionary())
//        DatabaseService.shared.getItemRef(uid: userApp.uid).child(product.title.lowercased()).setValue(product.convertedDictionary())
        dismiss(animated: true)
    }
    
}

extension SearchItemViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchProductCell", for: indexPath) as! SearchItemTableViewCell
        let item = items[indexPath.row]
        cell.configure(for: item, with: true, delegate: self)
        cell.backgroundColor = .clear
        return cell
    }
    
    
}

extension SearchItemViewController: SearchItemCellDelegate {
    func buttonTapped(sender: SearchItemTableViewCell) {
        if var item = sender.item {
            item.checkItem(shopList: shopList)
        }
        
    }
    

}
