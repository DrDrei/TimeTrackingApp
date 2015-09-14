//
//  LoginVC.swift
//  testing_app
//
//  Created by Drei on 2015-07-05.
//  Copyright (c) 2015 Drei. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
		var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
		view.addGestureRecognizer(tap)
	}
	
	@IBOutlet var userInvalid: UILabel!
	@IBOutlet weak var userTextField: UITextField!
	
	@IBAction func userTextClear(sender: UITextField) {
		userTextField.text = ""
		userInvalid.text = ""
	}
	
	@IBOutlet weak var passTextField: UITextField!
	@IBAction func passTextClear(sender: UITextField) {
		passTextField.text = ""
		userInvalid.text = ""
	}
	
	@IBAction func resetFields(sender: UIButton) {
		userTextField.text = "User"
		passTextField.text = "Password"
		userInvalid.text = ""
	}
	
	func verifyLogin() -> Bool{
		let user = userTextField.text
		let pass = passTextField.text
		
		let prefs = NSUserDefaults.standardUserDefaults()
		let json = convertJson()
		
		var loginSuccessful = false
		
		for var i = 0; i < json.count; i++  {
			if let userName = json[i]["user"].string {
				if userName == user {
					if json[i]["pass"].string == pass {
						print("login was successful")
						loginSuccessful = true
						prefs.setValue(i, forKey: "userindex")
						break
					} else {
						print("Login Failed.")
						userInvalid.text = "Incorrect Username/Password"
						break
					}
				}
			}
		}
		if !loginSuccessful {
			userInvalid.text = "Incorrect Username/Password"
			print("invalid user")
		}
		return loginSuccessful
	}
	
	@IBAction func loginButtonPressed(sender: UIButton) {
		self.performSegueWithIdentifier("loggedin", sender: nil)
		//shouldPerformSegueWithIdentifier("loggedin", sender: nil)
		//navigationItem.title = "Logged in as " + userTextField.text
	}
	
	override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
		return verifyLogin()
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {}
	
	func dataOfJson(url: String) -> NSArray{
		var data = NSData(contentsOfURL: NSURL(string: url)!)
		return (NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSArray)
	}
	
	
	//Calls this function when the tap is recognized.
	func DismissKeyboard(){
		view.endEditing(true)
	}
}
