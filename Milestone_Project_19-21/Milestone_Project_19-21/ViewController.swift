//
//  ViewController.swift
//  Milestone_Project_19-21
//
//  Created by Brian Phillips on 4/16/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	
	var notesArray = [Notes]()

	var defaults = UserDefaults.standard
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "My Notes"

		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNote))
		
		loadUserDefaults()
	}
	
	@objc func addNewNote() {
		let ac = UIAlertController(title: "New Note", message: "Choose a new name", preferredStyle: .alert)
		ac.addTextField()
		ac.addAction(UIAlertAction(title: "Okay", style: .default) { [weak self, weak ac] _ in
			guard let newName = ac?.textFields?[0].text else { return }
			
			let newNote = Notes(name: newName, note: "")
			
			self?.notesArray.append(newNote)
			self?.tableView.reloadData()
			self?.saveUserDefaults()
		})
		present(ac, animated: true)
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return notesArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Notes", for: indexPath)
		cell.textLabel?.text = notesArray[indexPath.row].name
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let vc = storyboard?.instantiateViewController(withIdentifier: "NotesText") as? NotesText {
			let cell = notesArray[indexPath.row]
			
			vc.note = cell.note
			vc.name = cell.name
			
			navigationController?.pushViewController(vc, animated: true)
		}
	}
	
	func saveUserDefaults() {
		let jsonEncoder = JSONEncoder()
		if let savedData = try? jsonEncoder.encode(notesArray) {
			defaults.set(savedData, forKey: "NOTES")
		}
	}
	
	func loadUserDefaults() {
		if let savedData = defaults.object(forKey: "NOTES") as? Data {
			let jsonDecoder = JSONDecoder()
			
			do {
				notesArray = try jsonDecoder.decode([Notes].self, from: savedData)
			} catch {
				print("Failed to load notes")
			}
		}
	}
}

