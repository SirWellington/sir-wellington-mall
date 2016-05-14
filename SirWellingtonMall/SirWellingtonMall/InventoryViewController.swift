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


class InventoryViewController : UICollectionViewController {
    
    private var items: [GroceryItem] = []
    
    private var emptyCell: UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    override func viewDidLoad() {
        
    }
    
    
    
}

//MARK: Collection View Data Source Methods
extension InventoryViewController {
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        
        guard row > 0 && row < items.count
        else {
            AromaClient.beginWithTitle("Bad Logic")
                .withPriority(.MEDIUM)
                .addBody("InventoryViewController").addLine()
                .addBody("Incorrect Row: \(row)")
                .send()
            
            return emptyCell
        }
        
        let item = items[row]
        
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("InventoryCell", forIndexPath: indexPath) as? InventoryCell
        else {
            AromaClient.beginWithTitle("Collection View Error")
                .addBody("Failed to deque InventoryCell. Returning Empty cell.")
                .withPriority(.MEDIUM)
                .send()
            
            return emptyCell
        }
        
        populateCell(cell, withItem: item)
        
        return cell
    }
    
    private func populateCell(cell: InventoryCell, withItem item: GroceryItem) {
        
    }

    
}

//MARK: Collection View Delegate Methods
extension InventoryViewController {
    
}


class InventoryCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var name: UILabel!
    
}