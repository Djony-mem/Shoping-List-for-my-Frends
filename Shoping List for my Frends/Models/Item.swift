//
//  Item.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 1/21/21.
//

import Foundation
import Firebase

struct Item {
    let nameItem: String?
    let uid: String?
    var status: Bool? = false
    
    init(nameItem: String, uid: String) {
        self.nameItem = nameItem
        self.uid = uid
    }
    
    init(productDict: [String: Any]) {
        nameItem = productDict["nameItem"] as? String
        uid = productDict["uid"] as? String
        status = productDict["status"] as? Bool
    }
    
    static func getItems(snapshot: DataSnapshot) -> [Item] {
        var items = [Item]()
        guard let snapDictionary = snapshot.value as? [String: [String: Any]]
        else { return [] }
        
        for snap in snapDictionary {
            let item = Item(productDict: snap.value)
            items.append(item)
        }
        return items
    }
    func convertedDictionary() -> Any {
        return ["nameItem": nameItem ?? "",
                "uid": uid ?? "",
                "status": status ?? false]
    }
}
