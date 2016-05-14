//
//  AddProduct2ViewController.swift
//  SirWellingtonMall
//
//  Created by Juan Wellington Moreno on 5/14/16.
//  Copyright © 2016 Sir Wellington. All rights reserved.
//

import AromaSwiftClient
import Foundation
import UIKit

//ENTER A DESCRIPTION
class AddProduct2ViewController : UIViewController {
    
    @IBOutlet weak var productDescriptionField: UITextField!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productDescriptionField.becomeFirstResponder()
    }
    
    
    @IBAction func onEnterPressed(sender: AnyObject) {
        product?.description = productDescriptionField.text ?? ""
        goToNext()
    }
    
}

//MARK: Segues
extension AddProduct2ViewController {
    
    private func goToNext() {
        self.performSegueWithIdentifier("ToNext", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destination = segue.destinationViewController
        
        if let next = destination as? AddProduct3ViewController {
            next.product = self.product
        }
        
    }
}