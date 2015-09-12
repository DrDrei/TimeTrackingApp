/*

Function taskObject initializes as an NSObject
with two parameters, text and completed status

use: taskObject(text: "string") to create this type of object

*/

import UIKit

class taskObject: NSObject {
	// A text description of this item.
	var text: String
 
	// A Boolean value that determines the completed state of this item.
	var completed: Bool
 
	// Returns a ToDoItem initialized with the given text and default completed value.
	init(text: String) {
		self.text = text
		self.completed = false
	}
}
