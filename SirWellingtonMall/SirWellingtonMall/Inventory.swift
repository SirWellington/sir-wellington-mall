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
    
    // MARK: Dairy
    private static let eggs = GroceryItem(name: "Eggs", description: "They are good, in moderation.", imageName: "Eggs")
    private static let soyMilk = GroceryItem(name: "Soy Milk", description: "Soy milk is much better than regular milk. Tastes better too.", imageName: "Soy-Milk")
    private static let milk = GroceryItem(name: "Milk", description: "Milk is honestly overrated", imageName: "Cow-Milk")
    
    //MARK: Vegetables
    private static let asparagues = GroceryItem(name: "Asparagus", description: "", imageName: "Asparagus")
    
    //MARK: Meats
    private static let chickenBreast = GroceryItem(name: "Chicken Breast", description: "", imageName: "Chicken-Breast")
    
    //MARK: Beverages
    private static let coffee = GroceryItem(name: "Coffee", description: "What can you do without it?", imageName: "Coffee")
    
    //MARK: Sweets
    private static let nutella = GroceryItem(name: "Nutella", description: "I've heard great things about it", imageName: "Nutella")
    private static let peanutButter = GroceryItem(name: "Peanut Butter", description: "The World in your Mouth.", imageName: "Peanut-Butter")
    
    
    static let BASIC_INVETORY: [GroceryItem] = [
        Inventory.asparagues,
        Inventory.coffee,
        Inventory.chickenBreast,
        Inventory.eggs,
        Inventory.soyMilk,
        Inventory.milk,
        Inventory.peanutButter,
        Inventory.nutella
    ]
    
}