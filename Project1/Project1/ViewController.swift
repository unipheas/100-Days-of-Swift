//
//  ViewController.swift
//  Project1
//
//  Created by Brian Phillips on 2/18/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	var pictures = [String]()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Storm Viewer"
		navigationController?.navigationBar.prefersLargeTitles = true

		let fileManager = FileManager.default
		let path = Bundle.main.resourcePath!
		let items = try? fileManager.contentsOfDirectory(atPath: path)
		for item in items! {
			if item.hasPrefix("nssl") {
				pictures.append(item)
			}
		}
		
		pictures = pictures.sorted()
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return pictures.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
		cell.textLabel?.text = pictures[indexPath.row]
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let viewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
			viewController.selectedImage = pictures[indexPath.row]
			viewController.xImage = indexPath.row + 1
			viewController.yImage = pictures.count
			
			navigationController?.pushViewController(viewController, animated: true)
		}
	}
}
