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
    
    var products: [Product] = []
    var user: AppUser!
    var shopList: List!
    var items: [Item]!
    var itemsRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsRef = DatabaseService.shared.getItems(uid: user.uid)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemsRef.observe(.value) {[weak self] snapshot in
            self?.items = Item.getItems(snapshot: snapshot)
        }
    }
    
    @IBAction func addResultTappedButton(_ sender: UIButton) {
        
        guard let searchTF = searchTextField?.text, searchTF != "" else { return dismiss(animated: true) }
        let note = quantityTextField?.text
        let product = Product(title: searchTF,
                              uid: user.uid,
                              note: note ?? "")
        products.append(product)
        DatabaseService.shared.getListRef(uid: user.uid, list: shopList).child(product.title?.lowercased() ?? "").setValue(product.convertedDictionary())
        dismiss(animated: true)
    }
    
}

extension SearchItemViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchProductCell", for: indexPath)
        cell.backgroundColor = .clear
        return cell
    }
    
    
}
