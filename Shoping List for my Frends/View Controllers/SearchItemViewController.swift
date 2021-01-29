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
    var sortedItems: [Product] = []
    
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
        print("Yepp 3")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemsRef?.observe(.value) {[weak self] snapshot in
            self?.items = Product.getShopingItem(snapshot: snapshot) ?? []
            self?.sortedItems = (self?.items.sorted(by: { $0.title > $1.title })) ?? []
            self?.tableViewItems.reloadData()
        }
    }
}

extension SearchItemViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredItems.count
            
        }
        return sortedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchProductCell", for: indexPath) as! SearchItemTableViewCell
        var item: Product
        
        if isFiltering {
            item = filteredItems[indexPath.row]
            
        } else {
            item = sortedItems[indexPath.row]
        }
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
        
        filteredItems = sortedItems.filter({ (item: Product) -> Bool in
            return item.title.lowercased().contains(searchText.lowercased())
        })
        tableViewItems.reloadData()
    }
}
