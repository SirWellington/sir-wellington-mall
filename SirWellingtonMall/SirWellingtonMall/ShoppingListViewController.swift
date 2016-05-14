//
//  ShoppingListViewController.swift
//  SirWellingtonMall
//
//  Created by Juan Wellington Moreno on 5/14/16.
//  Copyright © 2016 Sir Wellington. All rights reserved.
//

import AromaSwiftClient
import MCSwipeTableViewCell
import UIKit

class ShoppingListViewController: UITableViewController {

    private var shoppingList: [GroceryItem] = Inventory.BASIC_INVETORY
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//MARK: Table View Data Methods
extension ShoppingListViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shoppingList.isEmpty {
            return 1 //For EmptyCell
        }
        else {
            return shoppingList.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if shoppingList.isEmpty {
            
            return tableView.dequeueReusableCellWithIdentifier("EmptyCell", forIndexPath: indexPath)
        }
        
        let row = indexPath.row
        
        guard row >= 0 && row < shoppingList.count
        else {
            AromaClient.beginWithTitle("Bad Logic")
                .withPriority(.HIGH)
                .addBody("ShoppingListViewController").addLine()
                .addBody("Unexpected Row #\(row)")
                .send()
            
            return emptyCell
        }
        
        let item = shoppingList[row]
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier("GroceryItemCell", forIndexPath: indexPath) as? GroceryItemCell
        else {
            return emptyCell
        }
        
        populateCell(cell, withItem: item, atIndexPath: indexPath)
        
        return cell
    }
    
    private func populateCell(cell: GroceryItemCell, withItem item: GroceryItem, atIndexPath path: NSIndexPath) {
        
        if let imageName = item.imageName where !imageName.isEmpty {
            cell.pictureImageView.image = UIImage(named: imageName)
        }
        
        cell.nameLabel.text = item.name
        cell.descriptionLabel.text = item.description
        
        self.addSwipeToDelete(toCell: cell, atIndexPath: path) { [weak self] deletedPath in
            
            let row = deletedPath.row
            
            guard let `self` = self else { return }
            
            self.shoppingList.removeAtIndex(row)
            
            if !self.shoppingList.isEmpty {
                self.tableView?.deleteRowsAtIndexPaths([deletedPath], withRowAnimation: .Automatic)
            }
            else {
                self.tableView?.reloadRowsAtIndexPaths([deletedPath], withRowAnimation: .Automatic)
            }
        }
        
    }
    
}

//MARK: Table View Delegate Methods
extension ShoppingListViewController {
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return !shoppingList.isEmpty
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if shoppingList.isEmpty {
            return tableView.frame.height
        }
        else {
            return 160
        }
    }
    
}

class GroceryItemCell : MCSwipeTableViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountStepper: UIStepper!
    @IBOutlet weak var amountLabel: UILabel!
    
    
}