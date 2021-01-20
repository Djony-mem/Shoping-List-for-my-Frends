//
//  Product.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 1/20/21.
//

import Foundation
import Firebase

struct Item {
    let nameItem: String?
    let uid: String?
    
    init(nameItem: String, uid: String) {
        self.nameItem = nameItem
        self.uid = uid
    }
    
    init(productDict: [String: Any]) {
        nameItem = productDict["nameItem"] as? String
        uid = productDict["uid"] as? String
    }
    
    static func getItems(snapshot: DataSnapshot) -> [Item] {
        var items = [Item]()
        guard let snapDictionary = snapshot.value as? [String: [String: String]]
        else { return [] }
        
        for snap in snapDictionary {
            let item = Item(productDict: snap.value)
            items.append(item)
        }
        return items
    }
}

struct Product {
    let title: String?
    let note: String?
    let uid: String?
    var completed: Bool? = false
    
    init(title: String, uid: String, note: String) {
        self.title = title
        self.uid = uid
        self.note = note
    }
    
    init(productDict: [String: Any]) {
        title = productDict["title"] as? String
        uid = productDict["uid"] as? String
        completed = productDict["uid"] as? Bool
        note = productDict["note"] as? String
    }
    
    static func getShopingItem(snapshot: DataSnapshot) -> [Product]? {
        var products = [Product]()
        guard let snapDictionary = snapshot.value as? [String: [String: Any]]
        else { return nil }
        
        for snap in snapDictionary {
            let product = Product(productDict: snap.value)
            products.append(product)
        }
       return products
    }
    
    func convertedDictionary() -> Any {
        return ["title" : title ?? "", "uid": uid ?? "", "completed": completed ?? false, "note": note ?? ""]
    }
}
