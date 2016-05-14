//
//  ProductViewController.swift
//  SirWellingtonMall
//
//  Created by Juan Wellington Moreno on 5/14/16.
//  Copyright © 2016 Sir Wellington. All rights reserved.
//

import AromaSwiftClient
import Foundation
import LTMorphingLabel
import UIKit

class ProductViewController : UIViewController {
    
    
    @IBOutlet weak var productName: LTMorphingLabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UILabel!
    
    var product: Product!
    
    override func viewDidLoad() {
        
        guard product != nil else {
            AromaClient.sendHighPriorityMessage(withTitle: "Bad Logic", withBody: "GroceryItemViewController started without item")
            
            self.dismiss()
            return
        }
        
        loadProductInfo()
        
        AromaClient.beginWithTitle("Product Viewed")
            .withPriority(.LOW)
            .addBody("\(product)")
            .send()
    }
    
    private func dismiss() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    private func loadProductInfo() {
        
        productName.text = ""
        productName.morphingEffect = .Fall
        productName.text = product.name
        
        productDescription.text = product.description
        
        productImage.image = product.getImage()
        
    }
    
}