//
//  ViewController.swift
//  Project7
//
//  Created by Brian Phillips on 3/6/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	
	var petitions = [Petition]()
	var filteredPetitions = [Petition]()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			title: "Credits",
			style: .plain,
			target: self,
			action: #selector(creditAlert))
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .search,
			target: self,
			action: #selector(filterSearch))
		
		performSelector(inBackground: #selector(fetchJSON), with: nil)
	}
	
	@objc func fetchJSON() {
		let urlString: String
		
		if navigationController?.tabBarItem.tag == 0 {
			urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
		} else {
			urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
		}

		if let url = URL(string: urlString) {
			if let data = try? Data(contentsOf: url) {
				parse(json: data)
				return
			}
		}
			
		performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
	}
	
	@objc func creditAlert() {
			let alertController = UIAlertController(
				title: "Credits",
				message: "All data comes from We The People API of the Whitehouse",
				preferredStyle: .alert)
			alertController.addAction(UIAlertAction(title: "Okay", style: .default))
			present(alertController, animated: true)
	}
	
	@objc func filterSearch() {
		let alertController = UIAlertController(
			title: "Filter Search",
			message: nil,
			preferredStyle: .alert)
		alertController.addTextField(configurationHandler: nil)
		
		let submitAction = UIAlertAction(title: "Filter", style: .default) { [weak self, weak alertController] _ in
			guard let searchTerm = alertController?.textFields?[0].text else {
				return
			}
			self?.submit(searchTerm)
		}
		
		alertController.addAction(submitAction)
		present(alertController, animated: true)
	}
	
	func submit(_ searchTerm: String) {
		filteredPetitions.removeAll()
		
		for item in petitions {
			if item.title.contains(searchTerm) || item.body.contains(searchTerm) {
				filteredPetitions.append(item)
			}
		}
		
		tableView.reloadData()
	}
	
	@objc func showError() {
		let alertController = UIAlertController(
			title: "Loading error",
			message: "There was a problem loading the feed; please check your connection and try again.",
			preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "OK", style: .default))
		present(alertController, animated: true)
	}
	
	func parse(json: Data) {
		let decoder = JSONDecoder()
		
		if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
			petitions = jsonPetitions.results
			filteredPetitions = jsonPetitions.results
			tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
		} else {
			performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredPetitions.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

		let petition = filteredPetitions[indexPath.row]
		
		cell.textLabel?.text = petition.title
		cell.detailTextLabel?.text = petition.body
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let viewController = DetailViewController()
		viewController.detailItem = filteredPetitions[indexPath.row]
		navigationController?.pushViewController(viewController, animated: true)
	}
}
