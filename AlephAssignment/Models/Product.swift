//
//  Product.swift
//  AlephAssignment
//
//  Created by DuyN on 7/18/18.
//  Copyright © 2018 DuyN. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductResponse : Mappable {
    var items : [Product]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        items <- map["products.items"]
    }
}

class Product : Mappable {
    var title: String?
    var price: String?
    var imageUrl: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        price <- map["price"]
        imageUrl <- map["image"]
    }
    
}
