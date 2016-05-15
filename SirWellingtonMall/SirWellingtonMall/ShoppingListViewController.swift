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

    private var shoppingList: [GroceryItem] =  {
        
        let random = Int.random(from: 0, to: 10)
        
        if random.isEven() {
            return Products.BASIC_INVENTORY.map() {
                return GroceryItem(product: $0, note: "", amount: 1)
            }
        }
        else {
            return []
        }
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if shoppingList.count > 4 {
            self.navigationController?.hidesBarsOnSwipe = true
        }
    }

    override func viewDidDisappear(animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        self.navigationController?.hidesBarsOnSwipe = false
    }
    
}


//MARK: Segues
extension ShoppingListViewController {
    
    private func segueToGroceryItem(item: GroceryItem) {
        
        self.performSegueWithIdentifier("ToProduct", sender: item.product)
    }
    
    @IBAction func unwindFromProductList(segue: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destination = segue.destinationViewController
        
        if let groceryView = destination as? ProductViewController, product = sender as? Product {
            groceryView.product = product
        }
        
        if let navController = destination as? UINavigationController, let productList = navController.topViewController as? ProductListViewController {
        
            productList.onProductSelected = { product in
                
                let item = GroceryItem(product: product, note: "", amount: 1)
                self.onGroceryAdded(item)
            }
        }
    }
}

//MARK: Data Modifications
extension ShoppingListViewController {
    
    private func onGroceryAdded(newGroceryItem: GroceryItem) {
        self.shoppingList.append(newGroceryItem)
        self.reloadSection(0, animation: .Automatic)
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
       
        cell.pictureImageView.image = item.product.getImage()
        cell.nameLabel.text = item.product.name
        cell.descriptionLabel.text = item.product.description
        cell.amountLabel.text = "\(item.amount)"
        cell.amountStepper.value = Double(item.amount)
        
        if item.checked {
            checkCell(cell)
        }
        else {
            uncheckCell(cell)
        }
        
        cell.stepperDelegate = { [unowned cell] stepper in
            
            let newValue = stepper.value
            item.amount = Int(newValue)
            cell.amountLabel.text = "\(item.amount)"
            
            AromaClient.sendLowPriorityMessage(withTitle: "Grocery Amount Changed", withBody: "To \(newValue)")
        }
        
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
        
        self.addSwipeToToggle(toCell: cell, atIndexPath: path) { [weak self] toggledPath in
            
            guard let `self` = self else { return }
            
            let row = toggledPath.row
            
            guard row >= 0 && row < self.shoppingList.count
            else {
                AromaClient.sendHighPriorityMessage(withTitle: "Logic Error", withBody: "Unexpected Row #\(row)")
                return
            }
            
            let item = self.shoppingList[row]
            
            item.checked = !item.checked
            
            if item.checked {
                self.checkCell(cell)
            }
            else {
                self.uncheckCell(cell)
            }
            
        }
        
    }
    
    private func checkCell(cell: GroceryItemCell) {
        
        let animations = {
            cell.groceryCover.hidden = false
        }
        
        UIView.transitionWithView(cell.contentView, duration: 0.4, options: .TransitionCrossDissolve, animations: animations, completion: nil)
        
    }
    
    private func uncheckCell(cell: GroceryItemCell) {
        
        let animations = {
            cell.groceryCover.hidden = true
        }
        
        UIView.transitionWithView(cell.contentView, duration: 0.4, options: .TransitionCrossDissolve, animations: animations, completion: nil)
        
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.navigationController?.navigationBarHidden = false
        
        let row = indexPath.row
        
        guard row >= 0 && row < shoppingList.count
        else {
            AromaClient.sendMediumPriorityMessage(withTitle: "Bad Logic", withBody: "Unexpected Row#: \(row)")
            return
        }
        
        let item = shoppingList[row]
        
        self.segueToGroceryItem(item)
    }
    
}

class GroceryItemCell : MCSwipeTableViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountStepper: UIStepper!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var groceryCover: UIView!
    
    
    var stepperDelegate: ((UIStepper) -> Void)?
    
    
    @IBAction func onStepperChanged(sender: AnyObject) {
        stepperDelegate?(amountStepper)
    }
    
}