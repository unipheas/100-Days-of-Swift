//
//  Image.swift
//  Milestone: Projects 10-12
//
//  Created by Brian Phillips on 3/23/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit

class Image: NSObject, Codable {
	var name: String
	var image: String
	
	init(name: String, image: String) {
		self.name = name
		self.image = image
	}
}
