//
//  Inventory.swift
//  SirWellingtonMall
//
//  Created by Juan Wellington Moreno on 5/14/16.
//  Copyright © 2016 Sir Wellington. All rights reserved.
//

import Foundation
import UIKit


class Product {
    
    var name: String
    var description: String? = nil
    var imageName: String? = nil
    private var image: UIImage? = nil
    
    init(name: String, description: String?, imageName: String?) {
        self.name = name
        self.description = description
        self.imageName = imageName
        
        self.image = getImage()
    }
    
    func setImage(image: UIImage) {
        self.image = image
    }
    
    func clearImage() {
        self.image = nil
    }
    
    func getImage() -> UIImage? {
        
        if let image = self.image {
            return image
        }
        
        guard let imageName = self.imageName where !imageName.isEmpty
        else {
            return nil
        }
        
        return UIImage(named: imageName)
    }
}

//This class contains the Product Inventory used in the App
class Products {
    
    
    // MARK: Dairy
    private static let eggs = Product(name: "Eggs", description: "They are good, in moderation.", imageName: "Eggs")
    private static let soyMilk = Product(name: "Soy Milk", description: "Soy milk is much better than regular milk. Tastes better too.", imageName: "Soy-Milk")
    private static let milk = Product(name: "Milk", description: "Milk is honestly overrated", imageName: "Cow-Milk")
    
    //MARK: Vegetables
    private static let asparagus = Product(name: "Asparagus", description: "Asparagus is filled with anti-oxidants.", imageName: "Asparagus")
    
    //MARK: Meats
    private static let chickenBreast = Product(name: "Chicken Breast", description: "One of the absolute best sources of Protein.", imageName: "Chicken-Breast")
    
    //MARK: Beverages
    private static let coffee = Product(name: "Coffee", description: "What can you do without it?", imageName: "Coffee")
    
    //MARK: Sweets
    private static let nutella = Product(name: "Nutella", description: "I've heard great things about it", imageName: "Nutella")
    private static let peanutButter = Product(name: "Peanut Butter", description: "The World in your Mouth.", imageName: "Peanut-Butter")
    
    
    static var BASIC_INVENTORY: [Product] = [
        Products.asparagus,
        Products.coffee,
        Products.chickenBreast,
        Products.eggs,
        Products.soyMilk,
        Products.milk,
        Products.peanutButter,
        Products.nutella
    ]
    
}