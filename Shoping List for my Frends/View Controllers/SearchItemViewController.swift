//
//  ListViewController.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 12/5/20.
//

import UIKit
import Firebase

class SearchItemViewController: UIViewController {

    @IBOutlet weak var tableViewItems: UITableView!
    
    var user: AppUser!
    var shopList: List!
    var items: [Product] = []
    var itemsRef: DatabaseReference?
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredItems = [Product]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Что купить?"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        itemsRef = DatabaseService.shared.getItemRef(uid: user.uid)
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
        if isFiltering {
            return filteredItems.count
        }
       return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchProductCell", for: indexPath) as! SearchItemTableViewCell
        var item: Product
        
        if isFiltering {
            item = filteredItems[indexPath.row]
        }
            item = items[indexPath.row]
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

extension SearchItemViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterrContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterrContentForSearchText(_ searchText: String) {
        
        filteredItems = items.filter({ (item: Product) -> Bool in
            return item.title.lowercased().contains(searchText.lowercased())
        })
        tableViewItems.reloadData()
    }
}
