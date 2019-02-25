//
//  ViewController.swift
//  Project4
//
//  Created by Brian Phillips on 2/24/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	var flags = [String]()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let fileManager = FileManager.default
		let path = Bundle.main.resourcePath!
		let items = try? fileManager.contentsOfDirectory(atPath: path)
		
		for item in items! {
			if item.hasSuffix("png") {
				flags.append(item)
			}
		}
		
		flags.sort()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return flags.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
		let cellName = flags[indexPath.row]
		var components = cellName.components(separatedBy: ".")
		cell.textLabel?.text = components[0]
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let viewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
			viewController.selectedImage = flags[indexPath.row]
			navigationController?.pushViewController(viewController, animated: true)
		}
	}
}

