//
//  ViewController.swift
//  Project28
//
//  Created by Brian Phillips on 5/4/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

	@IBOutlet var secret: UITextView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Nothing to see here"
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
		
		let notificationCenter = NotificationCenter.default
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
		notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
		
	}
	
	@objc func done() {
		saveSecretMessage()
	}

	@IBAction func authenicateTapped(_ sender: Any) {
		let context = LAContext()
		var error: NSError?
		
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			let reason = "Identify yourself!"
			
			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
				[weak self] success, authenticationError in
				
				DispatchQueue.main.async {
					if success {
						self?.unlockSecretMessage()
					} else {
						let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
						ac.addAction(UIAlertAction(title: "OK", style: .default))
						self?.present(ac, animated: true)
					}
				}
			}
		} else {
			let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "OK", style: .default))
			self.present(ac, animated: true)
		}
	}
	
	@objc func adjustForKeyboard(notification: Notification) {
		guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
		
		let keyboardScreenEndFrame = keyboardValue.cgRectValue
		let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
		
		if notification.name == UIResponder.keyboardWillHideNotification {
			secret.contentInset = .zero
		} else {
			secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
		}
		
		secret.scrollIndicatorInsets = secret.contentInset
		
		let selectedRange = secret.selectedRange
		secret.scrollRangeToVisible(selectedRange)
	}
	
	func unlockSecretMessage() {
		secret.isHidden = false
		title = "Secret stuff!"
		
		if let text = KeychainWrapper.standard.string(forKey: "SecretMessage") {
			secret.text = text
		}
		
		promptForPassword()
	}
	
	@objc func saveSecretMessage() {
		guard secret.isHidden == false else { return }
		
		KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
		secret.resignFirstResponder()
		secret.isHidden = true
		title = "Nothing to see here"
	}
	
	func promptForPassword() {
		let alertController = UIAlertController(title: "Enter Password", message: nil, preferredStyle: .alert)
		alertController.addTextField(configurationHandler: nil)
		
		let submitAction = UIAlertAction(title: "Sumbit", style: .default) { [weak self, weak alertController] _ in
			guard let answer = alertController?.textFields?[0].text else { return }
		}
		
		alertController.addAction(submitAction)
		present(alertController, animated: true)
	}
	
}

