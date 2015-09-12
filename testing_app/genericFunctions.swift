//
//  convertJson.swift
//  testing_app
//
//  Created by Drei on 2015-07-08.
//  Copyright (c) 2015 Drei. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import WebKit

// calls on the database and returns a full list of users and their tasks
func convertJson() -> JSON {
	let url = NSURL(string: "http://lifeitup.org/serviceRequest.php")
	var request = NSURLRequest(URL: url!)
	var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
	return JSON(data: data!)
}

struct taskList {
	var name: String
	var duration: Int
}
