//
//  Inventory.swift
//  SirWellingtonMall
//
//  Created by Juan Wellington Moreno on 5/14/16.
//  Copyright © 2016 Sir Wellington. All rights reserved.
//

import Foundation

//The Inventory contains all the Groceries used in the App
class Inventory {
    
    private static let soyMilk = GroceryItem(name: "Soy Milk",
                                             description: "Soy milk, sometimes referred to as soya milk or soy drink, is a liquid made by grinding and boiling soybeans with water. This milky beverage has a similar nutritional content to cow's milk and is staple food in many Asian countries. Its creamy texture, high nutritional value, and animal free ingredients have made soy milk popular around the world.",
                                             price: 2.99,
                                             imageName: "Soy-Milk")
    
    
    static let BASIC_INVETORY: [GroceryItem] = [
        Inventory.soyMilk
        
    ]
    
}