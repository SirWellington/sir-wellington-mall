//
//  Extensions.swift
//  SirWellingtonMall
//
//  Created by Juan Wellington Moreno on 5/14/16.
//  Copyright © 2016 Sir Wellington. All rights reserved.
//

import Foundation
import MCSwipeTableViewCell
import MobileCoreServices
import UIKit

extension Int {

    func isEven() -> Bool {
        return self % 2 == 0
    }

    func isOdd() -> Bool {
        return !self.isEven()
    }

    static func random(from begin: Int, to end: Int) -> Int {

        guard begin != end else { return begin }
        guard begin < end else { return 0 }

        let difference = end - begin
        let random = arc4random_uniform(UInt32(difference))

        let result = begin + Int(random)

        if result >= end {
            return end - 1
        }
        else {
            return result
        }
    }
}

//MARK: UIViewController

//Hides the Navigation Bar Lip
extension UIViewController {

    func hideNavigationBarShadow() {
        let emptyImage = UIImage()
        self.navigationController?.navigationBar.shadowImage = emptyImage
        self.navigationController?.navigationBar.setBackgroundImage(emptyImage, forBarMetrics: UIBarMetrics.Default)
    }

    var isiPhone: Bool {
        return UI_USER_INTERFACE_IDIOM() == .Phone
    }

    var isiPad: Bool {
        return UI_USER_INTERFACE_IDIOM() == .Pad
    }
}

//MARK: String Operations
public extension String {
    public var length: Int { return self.characters.count }

    public func toURL() -> NSURL? {
        return NSURL(string: self)
    }
}


//MARK: Arrays
extension Array {

    func selectOne() -> Element? {
        guard count > 0 else { return nil }

        var index = Int.random(from: 0, to: count)

        if index >= count { index -= 1 }

        return self[index]
    }
}

// MARK: UILabel
extension UILabel {

    func readjustLabelFontSize() {
        let rect = self.frame
        self.adjustFontSizeToFitRect(rect, minFontSize: 5, maxFontSize: 100)
    }

    func adjustFontSizeToFitRect(rect: CGRect, minFontSize: Int = 5, maxFontSize: Int = 200) {

        guard let text = self.text else { return }

        frame = rect

        var right = maxFontSize
        var left = minFontSize

        let constraintSize = CGSize(width: rect.width, height: CGFloat.max)

        while (left <= right) {

            let currentSize = (left + right) / 2
            font = font.fontWithSize(CGFloat(currentSize))
            let text = NSAttributedString(string: text, attributes: [NSFontAttributeName: font])
            let textRect = text.boundingRectWithSize(constraintSize, options: .UsesLineFragmentOrigin, context: nil)

            let labelSize = textRect.size

            if labelSize.height < frame.height && labelSize.height >= frame.height - 10 && labelSize.width < frame.width && labelSize.width >= frame.width - 10 {
                break
            }
            else if labelSize.height > frame.height || labelSize.width > frame.width {
                right = currentSize - 1
            }
            else
            {
                left = currentSize + 1
            }
        }
    }
}


//MARK: Add Image Picker Capability
extension UIViewController {
    
    func prepareImagePicker() -> UIImagePickerController? {
        
        guard UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) else {
            return nil
        }
        
        let picker = UIImagePickerController()
        picker.sourceType = .PhotoLibrary
        picker.mediaTypes = [kUTTypeImage as String]
        picker.allowsEditing = true
        
        return picker
    }
    
}


//MARK: UITableView Controllers
extension UITableViewController {
    func reloadSection(section: Int, animation: UITableViewRowAnimation = .Automatic) {

        let section = NSIndexSet(index: section)
        self.tableView?.reloadSections(section, withRowAnimation: animation)
    }
}

extension UITableViewController {
    
    var emptyCell: UITableViewCell {
        return UITableViewCell()
    }
    
    private var trashIcon: UIImage? { return UIImage(named: "Trash") }

    typealias OnSwipe = (NSIndexPath) -> Void

    func addSwipeToDelete(toCell cell: MCSwipeTableViewCell, atIndexPath path: NSIndexPath, onSwipe: OnSwipe) {
       
        cell.defaultColor = UIColor.yellowColor()

        let view = UIImageView()
        
        if let icon = trashIcon {
            view.image = icon
        }
        
        view.contentMode = .Center

        cell.setSwipeGestureWithView(view, color: Colors.PRIMARY, mode: .Exit, state: .State1) { [weak self] cell, state, mode in

            guard let path = self?.tableView?.indexPathForCell(cell) else { return }
            onSwipe(path)
        }

        cell.setSwipeGestureWithView(view, color: Colors.PRIMARY, mode: .Exit, state: .State3) { [weak self] cell, state, mode in

            guard let path = self?.tableView?.indexPathForCell(cell) else { return }
            onSwipe(path)
        }

        cell.firstTrigger = 0.35
    }
}
