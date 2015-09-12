//
//  tableViewCell.swift
//  testing_app
//
//  Created by Drei on 2015-07-20.
//  Copyright (c) 2015 Drei. All rights reserved.
//

import UIKit
import QuartzCore

// A protocol that the TableViewCell uses to inform its delegate of state change
protocol TableViewCellDelegate {
	// indicates that the given item has been deleted
	func toDoItemDeleted(todoItem: taskObject)
}

class TableViewCell: UITableViewCell {
 
	let gradientLayer = CAGradientLayer()
	var originalCenter = CGPoint()
	var deleteOnDragRelease = false
	// The object that acts as delegate for this cell.
	var delegate: TableViewCellDelegate?
	// The item that this cell renders.
	var toDoItem: taskObject?
	
	required init(coder aDecoder: NSCoder) {
		fatalError("NSCoding not supported")
	}
 
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		// gradient layer for cell
		gradientLayer.frame = bounds
		let color1 = UIColor(white: 1.0, alpha: 0.2).CGColor as CGColorRef
		let color2 = UIColor(white: 1.0, alpha: 0.1).CGColor as CGColorRef
		let color3 = UIColor.clearColor().CGColor as CGColorRef
		let color4 = UIColor(white: 0.0, alpha: 0.1).CGColor as CGColorRef
		gradientLayer.colors = [color1, color2, color3, color4]
		gradientLayer.locations = [0.0, 0.01, 0.95, 1.0]
		layer.insertSublayer(gradientLayer, atIndex: 0)

		// add a pan recognizer
		var recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
		recognizer.delegate = self
		addGestureRecognizer(recognizer)
	}
 
	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = bounds
	}
	
	//MARK: - horizontal pan gesture methods
	func handlePan(recognizer: UIPanGestureRecognizer) {
		// 1
		if recognizer.state == .Began {
			// when the gesture begins, record the current center location
			originalCenter = center
		}
		// 2
		if recognizer.state == .Changed {
			let translation = recognizer.translationInView(self)
			center = CGPointMake(originalCenter.x + translation.x, originalCenter.y)
			// has the user dragged the item far enough to initiate a delete/complete?
			deleteOnDragRelease = frame.origin.x < -frame.size.width / 3.0
		}
		// 3
		if recognizer.state == .Ended {
			if deleteOnDragRelease {
				if delegate != nil && toDoItem != nil {
					// notify the delegate that this item should be deleted
					delegate!.toDoItemDeleted(toDoItem!)
				}
			} else {
				center = CGPointMake(originalCenter.x, originalCenter.y)
			}
		}
		
		
	}
	
	override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
		if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
			let translation = panGestureRecognizer.translationInView(superview!)
			if fabs(translation.x) > fabs(translation.y) {
				return true
			}
			return false
		}
		return false
	}
	
	
	
}
