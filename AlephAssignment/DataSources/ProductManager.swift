//
//  ProductManager.swift
//  AlephAssignment
//
//  Created by DuyN on 7/18/18.
//  Copyright © 2018 DuyN. All rights reserved.
//

import Foundation

class ProductManager {
    var products : [Product] = []
    
    init() {
        
    }
    
    func item(at index: Int) -> Product? {
        if products.count > index {
            return products[index]
        }
        return nil
    }
    
    func addItem(deal: Product) {
        products.append(deal)
    }
    
    func addItems(products: [Product]) {
        self.products.append(contentsOf: products)
    }
    
    func removeItem(at index: Int) {
        if products.count > index {
            products.remove(at: index)
        }
    }
    
    func clearItems() {
        products = []
    }
    
    func count() -> Int {
        return products.count
    }
}
