//
//  ViewController.swift
//  Project7
//
//  Created by Brian Phillips on 3/5/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	
	var shoppingList = [String]()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Shopping List"
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshView))
		
	}
	
	@objc func addItem() {
		let alertController = UIAlertController(title: "New Item", message: nil, preferredStyle: .alert)
		alertController.addTextField(configurationHandler: nil)
		
		let submitAction = UIAlertAction(title: "Sumbit", style: .default) { [weak self, weak alertController] _ in
			guard let item = alertController?.textFields?[0].text else { return }
			self?.submit(item)
		}
		
		alertController.addAction(submitAction)
		present(alertController, animated: true)
		
	}
	
	func submit(_ item: String) {
		shoppingList.append(item)
		tableView.reloadData()
	}
	
	@objc func refreshView() {
		alertController(title: "Cleared", message: "Your list is now cleared")
		shoppingList.removeAll()
		tableView.reloadData()
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return shoppingList.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
		cell.textLabel?.text = shoppingList[indexPath.row]
		return cell
	}
	
	func alertController(title: String, message: String) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "Okay", style: .default))
		present(alertController, animated: true)
	}
}

