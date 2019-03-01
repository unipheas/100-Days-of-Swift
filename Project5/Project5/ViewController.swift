//
//  ViewController.swift
//  Project5
//
//  Created by Brian Phillips on 2/28/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	var allWords = [String]()
	var usedWords = [String]()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .add,
			target: self,
			action: #selector(promptForAnswer))
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .refresh,
			target: self,
			action: #selector(startGame))
		
		if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
			if let startWords = try? String(contentsOf: startWordURL) {
				allWords = startWords.components(separatedBy: "\n")
			}
		}
		
		if allWords.isEmpty {
			allWords = ["silkworm"]
		}
		
		startGame()
	}
	
	@objc func startGame() {
		title = allWords.randomElement()
		usedWords.removeAll(keepingCapacity: true)
		tableView.reloadData()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return usedWords.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
		cell.textLabel?.text = usedWords[indexPath.row]
		return cell
	}
	
	@objc func promptForAnswer() {
		let alertController = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
		alertController.addTextField(configurationHandler: nil)
		
		let submitAction = UIAlertAction(title: "Sumbit", style: .default) { [weak self, weak alertController] _ in
			guard let answer = alertController?.textFields?[0].text else { return }
			self?.submit(answer)
		}
		
		alertController.addAction(submitAction)
		present(alertController, animated: true)
	}
	
	func submit(_ answer: String) {
		let lowerAnswer = answer.lowercased()
		
		if isPossible(word: lowerAnswer) {
			if isOriginal(word: lowerAnswer) {
				if isReal(word: lowerAnswer) {
					usedWords.insert(lowerAnswer, at: 0)
					
					let indexPath = IndexPath(row: 0, section: 0)
					tableView.insertRows(at: [indexPath], with: .automatic)
					
					return
				} else {
					error(errorTitle: "Word not recognized", errorMessage: "You can't just make them up, you know!")
				}
			} else {
				error(errorTitle: "Word already used", errorMessage: "Be more original!")
			}
		} else {
			error(errorTitle: "Word not possible", errorMessage: "You can't spell that word from \(title!.lowercased())")
		}
	}
	
	func isPossible(word: String) -> Bool {
		guard var tempWord = title?.lowercased() else { return false }
		for letter in word {
			if let position = tempWord.firstIndex(of: letter) {
				tempWord.remove(at: position)
			} else {
				return false
			}
		}
		
		return true
	}
	
	func isOriginal(word: String) -> Bool {
		if word == title?.lowercased() { return false }
		
		return !usedWords.contains(word)
	}
	
	func isReal(word: String) -> Bool {
		
		if word.count < 3 { return false }
		
		let checker = UITextChecker()
		let range = NSRange(location: 0, length: word.utf16.count)
		let misspelledRange = checker.rangeOfMisspelledWord(
			in: word, range: range, startingAt: 0, wrap: false, language: "en")
		return misspelledRange.location == NSNotFound
	}
	
	func error(errorTitle: String, errorMessage: String) {
		let alerController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
		alerController.addAction(UIAlertAction(title: "OK", style: .default))
		present(alerController, animated: true)
	}
}
