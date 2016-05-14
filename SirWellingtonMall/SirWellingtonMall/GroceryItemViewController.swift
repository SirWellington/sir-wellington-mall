//
//  GroceryItemViewController.swift
//  SirWellingtonMall
//
//  Created by Juan Wellington Moreno on 5/14/16.
//  Copyright © 2016 Sir Wellington. All rights reserved.
//

import AromaSwiftClient
import Foundation
import UIKit

class GroceryItemViewController : UIViewController {
    
    var item: GroceryItem!
    
    override func viewDidLoad() {
        
        guard item != nil else {
            AromaClient.sendHighPriorityMessage(withTitle: "Bad Logic", withBody: "GroceryItemViewController started without item")
            
            self.dismiss()
            return
        }
        
    }
    
    private func dismiss() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}