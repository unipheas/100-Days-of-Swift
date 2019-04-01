//
//  DetailsViewController.swift
//  Milestone: Projects 13-15
//
//  Created by Brian Phillips on 4/1/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
	
	var details: Country?

	@IBOutlet var capitalLabel: UILabel!
	@IBOutlet var populationLabel: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		title = details!.name
		capitalLabel?.text = "Country Name: \(details!.name)"
		populationLabel?.text = "Country Population: \(details!.population)"
		
    }
}
