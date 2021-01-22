//
//  Product.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 1/20/21.
//

import Foundation
import Firebase

struct Product {
    let title: String
    var note: String?
    let uid: String
    var completed: Bool = false
    
    init(title: String, uid: String, note: String) {
        self.title = title
        self.uid = uid
        self.note = note
    }
    
    init(productDict: [String: Any]) {
        title = productDict["title"] as! String
        uid = productDict["uid"] as! String
        completed = productDict["completed"] as! Bool
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
        return ["title" : title, "uid": uid, "completed": completed, "note": note ?? ""]
    }
}
