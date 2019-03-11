//
//  ViewController.swift
//  Project2
//
//  Created by Brian Phillips on 2/20/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var button1: UIButton!
	@IBOutlet var button2: UIButton!
	@IBOutlet var button3: UIButton!
	
	var countries = [String]()
	var score = 0
	var correctAnswer = 0
	var totalQuestions = 0
	var sharedEnabled = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		countries += [
			"estonia",
			"france",
			"germany",
			"ireland",
			"italy",
			"monaco",
			"nigeria",
			"poland",
			"russia",
			"spain",
			"uk",
			"us"
		]
		
		button1.layer.borderWidth = 1
		button2.layer.borderWidth = 1
		button3.layer.borderWidth = 1
		
		button1.layer.borderColor = UIColor.lightGray.cgColor
		button2.layer.borderColor = UIColor.lightGray.cgColor
		button3.layer.borderColor = UIColor.lightGray.cgColor
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .pause,
			target: self,
			action: #selector(whatIsMyScore)
		)
		
		askQuestion()
		
	}
	
	func askQuestion(action: UIAlertAction! = nil) {
		print(totalQuestions)
		
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
		l
		button1.setImage(UIImage(named: countries[0]), for: .normal)
		button2.setImage(UIImage(named: countries[1]), for: .normal)
		button3.setImage(UIImage(named: countries[2]), for: .normal)
		
		title = countries[correctAnswer].uppercased()
		
		totalQuestions += 1
		
	}

	@IBAction func buttonTapped(_ sender: UIButton) {
		var title: String
		
		if sender.tag == correctAnswer {
			title = "Correct"
			score += 1
		} else {
			title = "Wrong! That’s the flag of \(countries[sender.tag].uppercased()),"
			score -= 1
		}
		
		if totalQuestions == 10 {
			sharedEnabled = true
			showAlert(title: "Finished!", message: "Your final score is \(score)")
			score = 0
			totalQuestions = 0
		} else {
			showAlert(title: title, message: "Your score is \(score)")
		}
	}
	
	func showAlert(title: String, message: String) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		
		if sharedEnabled {
			alertController.addAction(UIAlertAction(title: "Share", style: .default, handler: shareTapped))
		}
		
		alertController.addAction(UIAlertAction(title: "Continute", style: .default, handler: askQuestion))
		
		present(alertController, animated: true)
	}
	
	@objc func shareTapped(action: UIAlertAction! = nil) {
		
		let viewController = UIActivityViewController(
			activityItems: ["I scored \(score) points"],
			applicationActivities: []
		)
		viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		present(viewController, animated: true)
	}
	
	@objc func whatIsMyScore() {
		let alertController = UIAlertController(title: "My Score is", message: String(score), preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
		present(alertController, animated: true)
	}
	
}
