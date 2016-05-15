//
//  InventoryViewController.swift
//  SirWellingtonMall
//
//  Created by Juan Wellington Moreno on 5/14/16.
//  Copyright © 2016 Sir Wellington. All rights reserved.
//

import AromaSwiftClient
import Foundation
import UIKit


class ProductListViewController : UICollectionViewController {
    
    private var products: [Product] = Products.BASIC_INVENTORY
    
    var onProductSelected: ((Product) -> Void)? = nil
    
    private var emptyCell: UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        
    }

    
    
}

//MARK: Segues & Unwinds
extension ProductListViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    private func unwind() {
        self.performSegueWithIdentifier("unwind", sender: self)
    }
    
    @IBAction func unwindFromAddProduct(segue: UIStoryboardSegue) {
        
        let source = segue.sourceViewController
        
        if let lastStep = source as? AddProduct3ViewController, product = lastStep.product {
            self.onProductAdded(product)
        }
    }
}

//MARK: Product List Modifications
extension ProductListViewController {
    
    private func onProductAdded(newProduct: Product) {
        self.products.append(newProduct)
        self.collectionView?.reloadData()
        
        AromaClient.sendMediumPriorityMessage(withTitle: "Product Added", withBody: "\(newProduct)")
    }
}


//MARK: Collection View Data Source Methods
extension ProductListViewController {
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        
        guard row >= 0 && row < products.count
        else {
            AromaClient.beginWithTitle("Bad Logic")
                .withPriority(.MEDIUM)
                .addBody("InventoryViewController").addLine()
                .addBody("Unexpected Row#: \(row)")
                .send()
            
            return emptyCell
        }
        
        let product = products[row]
        
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProductCell", forIndexPath: indexPath) as? ProductCell
        else {
            AromaClient.beginWithTitle("Collection View Error")
                .addBody("Failed to deque InventoryCell. Returning Empty cell.")
                .withPriority(.MEDIUM)
                .send()
            
            return emptyCell
        }
        
        populateCell(cell, withProduct: product, atIndexPath: indexPath)
        
        return cell
    }
    
    private func populateCell(cell: ProductCell, withProduct product: Product, atIndexPath path: NSIndexPath) {
        cell.productName.text = product.name
        cell.productImage.image = product.getImage()
    }

    
}

//MARK: Collection View Delegate Methods
extension ProductListViewController : UICollectionViewDelegateFlowLayout {
 
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let row = indexPath.row
        
        guard row >= 0 && row < products.count
        else {
            AromaClient.sendHighPriorityMessage(withTitle: "Bad Logic", withBody: "Unexpected Row #\(row)")
            return
        }
        
        let product = self.products[row]
        
        onProductSelected?(product)
        
        self.unwind()
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = self.view.frame.width * 0.45
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
}


class ProductCell: UICollectionViewCell {
    
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productName: UILabel!
    
}