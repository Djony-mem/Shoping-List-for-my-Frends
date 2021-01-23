//
//  Item.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 1/21/21.
//

import Foundation
import Firebase

struct Item {
    let itemID: String
    let nameItem: String
    let uid: String
    var status: Bool = false
    
    
    init(itemID: String, nameItem: String, uid: String) {
        self.itemID = itemID
        self.nameItem = nameItem
        self.uid = uid
    }
    
    init(productDict: [String: Any]) {
        itemID = productDict["itemID"] as! String
        nameItem = productDict["nameItem"] as! String
        uid = productDict["uid"] as! String
        status = productDict["status"] as! Bool
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
        return ["itemID": itemID,
                "nameItem": nameItem,
                "uid": uid,
                "status": status]
    }
    
    mutating func checkItem(shopList: List) {
            status.toggle()
        if status {
            DatabaseService.shared.getItemRef(uid: uid).child(nameItem.lowercased()).updateChildValues(["status": true])
            DatabaseService.shared.getItemRef(uid: uid).child(nameItem.lowercased()).setValue(convertedDictionary())
        } else {
            DatabaseService.shared.getItemRef(uid: uid).child(nameItem.lowercased()).updateChildValues(["status": false])
        }
    }
}
