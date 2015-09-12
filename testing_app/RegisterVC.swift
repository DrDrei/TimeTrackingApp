//
//  RegisterVC.swift
//  testing_app
//
//  Created by Drei on 2015-07-05.
//  Copyright (c) 2015 Drei. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON

class RegisterVC: UIViewController {
	
	@IBOutlet weak var passwordMatch: UITextField!
	@IBOutlet weak var userTextConfirm: UILabel!
	@IBOutlet weak var confirmationColor: UITextField!
	override func viewDidLoad() {
		super.viewDidLoad()
		
		var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
		view.addGestureRecognizer(tap)
		
		confirmationColor.alpha = 0.0
		passwordMatch.alpha = 0.0
		
	}
	
	
	@IBOutlet weak var username: UITextField!
	@IBAction func userTextPressed(sender: UITextField) {
		username.text = ""
		userTextConfirm.text = ""
		confirmationColor.alpha = 0.0
	}
	
	@IBAction func userVerify(sender: UITextField) {
		var userAvailable = true
		
		let url = NSURL(string: "http://lifeitup.org/serviceRequest.php")
		var request = NSURLRequest(URL: url!)
		var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
		
		let json = JSON(data: data!)
		
		var userNotFound = true
		
		for var i = 0; i < json.count; i++  {
			if let userName = json[i]["user"].string {
				if userName == username.text {
					userAvailable = false
					println("user is unavailable")
					break
					}
				}
		}
		confirmationColor.alpha = 1.0
		
		if userAvailable {
			print("user is good to go")
			confirmationColor.backgroundColor = UIColor.greenColor()
		} else {
			confirmationColor.backgroundColor = UIColor.redColor()
			userTextConfirm.text = "Username is taken"
		}
		
	}
	
	
	
	@IBOutlet weak var passwordTextMatch: UILabel!
	@IBOutlet weak var password1: UITextField!
	@IBAction func password1Entry(sender: UITextField) {
		password1.text = ""
		passwordTextMatch.text = ""
		passwordMatch.alpha = 0.0
	}
	
	
	@IBOutlet weak var password2: UITextField!
	@IBAction func password2Entry(sender: UITextField) {
		password2.text = ""
	}

	
	
	@IBAction func password2EntryFinish(sender: UITextField) {
		passwordMatch.alpha = 1.0
		if password1.text == password2.text{
			passwordMatch.backgroundColor = UIColor.greenColor()
		} else {
			passwordMatch.backgroundColor = UIColor.redColor()
			passwordTextMatch.text = "Passwords didn't match"
		}
	}
	
	@IBAction func createUser(sender: UIButton) {
		var url: NSString = "http://lifeitup.org/serviceAppend.php?user=\(username.text)&pass=\(password1.text)"
//		url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
//		url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
		var data = NSData(contentsOfURL: NSURL(string: url as String)!)
		var result = NSString(data: data!, encoding: NSUTF8StringEncoding)

	}
	
	
	
	//Calls this function when the tap is recognized.
	func DismissKeyboard(){
		view.endEditing(true)
	}
}
