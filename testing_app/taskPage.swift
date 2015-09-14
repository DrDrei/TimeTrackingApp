//
//  taskPage.swift
//  testing_app
//
//  Created by Drei on 2015-07-20.
//  Copyright (c) 2015 Drei. All rights reserved.
//

import UIKit


class taskPage: UIViewController, UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate {
	
	// initializes the taskObject array
	var toDoItems = [taskObject]()
	
	@IBAction func LogoutButton(sender: UIBarButtonItem) {
		self.performSegueWithIdentifier("Logout", sender: nil)
	}
	
	@IBOutlet var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.dataSource = self
		tableView.delegate = self
		tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.separatorStyle = .None
		tableView.backgroundColor = UIColor.blackColor()
		tableView.rowHeight = 50.0
		
		if toDoItems.count > 0 {
			return
		}
		
		// personal stuff
		let data = convertJson()
		let prefs = NSUserDefaults.standardUserDefaults()
		//var userindex = prefs.integerForKey("userindex")
		//var task1 = data[userindex]["task1"].string!
		toDoItems.append(taskObject(text: "testing"))
		
	}
	
	// MARK: - Table view data source
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
 
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return toDoItems.count
	}
 
	func tableView(tableView: UITableView,
		cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
			let cell = tableView.dequeueReusableCellWithIdentifier("cell",
				forIndexPath: indexPath) as! TableViewCell
			cell.selectionStyle = .None
			let item = toDoItems[indexPath.row]
			cell.textLabel?.backgroundColor = UIColor.clearColor()
			cell.textLabel?.text = item.text
			
			cell.delegate = self
			cell.toDoItem = item
			
			return cell
	}
	
	func toDoItemDeleted(toDoItem: taskObject) {
	  let index = (toDoItems as NSArray).indexOfObject(toDoItem)
	  if index == NSNotFound { return }
			
	  // could removeAtIndex in the loop but keep it here for when indexOfObject works
	  toDoItems.removeAtIndex(index)
			
	  // use the UITableView to animate the removal of this row
	  tableView.beginUpdates()
	  let indexPathForRow = NSIndexPath(forRow: index, inSection: 0)
	  tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
	  tableView.endUpdates()
	}
	
	// MARK: - Table view delegate
	func colorForIndex(index: Int) -> UIColor {
		let itemCount = toDoItems.count - 1
		let val = (CGFloat(index) / CGFloat(itemCount)) * 0.6
		return UIColor(red: 1.0, green: val, blue: 0.0, alpha: 1.0)
	}
 
	func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
		forRowAtIndexPath indexPath: NSIndexPath) {
			cell.backgroundColor = colorForIndex(indexPath.row)
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {}
	
}
