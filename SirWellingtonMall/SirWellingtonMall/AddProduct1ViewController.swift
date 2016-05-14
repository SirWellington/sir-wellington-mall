//
//  AddProduct1ViewController.swift
//  SirWellingtonMall
//
//  Created by Juan Wellington Moreno on 5/14/16.
//  Copyright © 2016 Sir Wellington. All rights reserved.
//

import AromaSwiftClient
import Foundation
import UIKit

//ENTER A NAME FOR THE PRODUCT
class AddProduct1ViewController : UIViewController {
    
    @IBOutlet weak var productNameField: UITextField!
    
    
    private var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productNameField.becomeFirstResponder()
    }
    
    
    @IBAction func onEnterPressed(sender: AnyObject) {
        product?.name = productNameField.text ?? ""
        goToNext()
    }
    
}

//MARK: Segues
extension AddProduct1ViewController {
    
    private func goToNext() {
        self.performSegueWithIdentifier("ToNext", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destination = segue.destinationViewController
        
        if let next = destination as? AddProduct2ViewController {
            next.product = self.product
        }
    }
}