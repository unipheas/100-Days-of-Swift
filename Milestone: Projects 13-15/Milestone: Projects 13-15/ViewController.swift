//
//  ViewController.swift
//  Milestone: Projects 13-15
//
//  Created by Brian Phillips on 4/1/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	
	var countries = [Country]()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		performSelector(inBackground: #selector(loadCountries), with: nil)
	}

	@objc func loadCountries() {
		
		if let file = Bundle.main.url(forResource: "countries", withExtension: "json") {
			if let data = try? Data(contentsOf: file) {
				parse(json: data)
			}
		}
	}
	
	func parse(json: Data) {
		let decoder = JSONDecoder()
		if let jsonCountries = try? decoder.decode(Countries.self, from: json) {
			countries = jsonCountries.results
			performSelector(onMainThread: #selector(reloadTable), with: nil, waitUntilDone: false)
		}
	}
	
	@objc func reloadTable() {
		tableView.reloadData()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return countries.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
		cell.textLabel?.text = countries[indexPath.row].name
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailsViewController {
			vc.details = countries[indexPath.row]
			navigationController?.pushViewController(vc, animated: true)
		}
	}
}

