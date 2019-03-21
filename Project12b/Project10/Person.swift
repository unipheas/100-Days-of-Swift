//
//  Person.swift
//  Project10
//
//  Created by Brian Phillips on 3/19/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit

class Person: NSObject {
	var name: String
	var image: String
	
	init(name: String, image: String) {
		self.name = name
		self.image = image
	}
}
