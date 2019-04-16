//
//  Notes.swift
//  Milestone_Project_19-21
//
//  Created by Brian Phillips on 4/16/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit

class Notes: NSObject, Codable {

	var name: String
	var note: String
	
	init(name: String, note: String) {
		self.name = name
		self.note = note
	}
}
