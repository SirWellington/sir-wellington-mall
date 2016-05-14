//
//  AddProduct3ViewController.swift
//  SirWellingtonMall
//
//  Created by Juan Wellington Moreno on 5/14/16.
//  Copyright © 2016 Sir Wellington. All rights reserved.
//


import AromaSwiftClient
import Foundation
import UIKit


//UPLOAD A PICTURE
class AddProduct3ViewController : UIViewController {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    
    var product: Product!
}


//MARK: Actions
extension AddProduct3ViewController {
    
    private func unwind() {
        self.performSegueWithIdentifier("unwind", sender: self)
    }
    
    @IBAction func onSelectImage(sender: AnyObject) {
        
        guard let imagePicker = self.prepareImagePicker() else { return }
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func onDone(sender: AnyObject) {
        
        self.unwind()
    }
    
}

//MARK: UIImagePicker Methods
extension AddProduct3ViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        productImage.image = image
    }
}