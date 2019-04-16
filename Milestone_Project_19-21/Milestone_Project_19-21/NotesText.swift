//
//  NotesText.swift
//  Milestone_Project_19-21
//
//  Created by Brian Phillips on 4/16/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit

class NotesText: UIViewController {
	
	var name: String?
	var note: String?

	@IBOutlet var textArea: UITextView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		textArea.text = note
		title = name
    }

}
