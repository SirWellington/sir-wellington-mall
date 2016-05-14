//
//  GroceryItem.swift
//  SirWellingtonMall
//
//  Created by Juan Wellington Moreno on 5/14/16.
//  Copyright © 2016 Sir Wellington. All rights reserved.
//

import Foundation
import UIKit

class GroceryItem {
    
    var product: Product
    var note: String
    var amount: Int = 1

    
    init(product: Product, note: String, amount: Int) {
        self.product = product
        self.note = note
        self.amount = amount
    }
}