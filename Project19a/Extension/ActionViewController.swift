//
//  ActionViewController.swift
//  Extension
//
//  Created by Brian Phillips on 4/9/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {
	@IBOutlet var script: UITextView!
	
	var pageTitle = ""
	var pageURL = ""
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(scripts))
		
		let notificationCenter = NotificationCenter.default
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    
		if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
			if let itemProvider = inputItem.attachments?.first {
				itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
					guard let itemDictionary = dict as? NSDictionary else { return }
					guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
					
					self?.pageTitle = javaScriptValues["title"] as? String ?? ""
					self?.pageURL = javaScriptValues["URL"] as? String ?? ""
					
					DispatchQueue.main.async {
						self?.title = self?.pageTitle
					}
				}
			}
		}
    }

	@IBAction func done(script withScript: NSDictionary?) {
		
		let item = NSExtensionItem()
		let argument: NSDictionary
		
		if withScript == nil {
			argument = ["customJavaScript": script.text]
		} else {
			argument = withScript!
		}
		
		let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
		let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
		item.attachments = [customJavaScript]
		
		extensionContext?.completeRequest(returningItems: [item])
    }
	
	@IBAction func scripts() {
		let ac = UIAlertController(title: "Scripts", message: "Please choose a script.", preferredStyle: .actionSheet)
		ac.addAction(UIAlertAction(title: "Show Address", style: .default, handler: setScript))
		ac.addAction(UIAlertAction(title: "Canel", style: .cancel))
		
		present(ac, animated: true)
	}
	
	func setScript(action: UIAlertAction) {
		guard let actionTitle = action.title else { return }
		
		var argument: NSDictionary
		
		switch actionTitle {
		case "Show Address":
			argument = ["customerJavaScript": "window.alert('Showing');"]
		default:
			argument = ["customerJavaScript": "window.alert('Not Showing!');"]
		}
		
		done(script: argument)
	}

	@objc func adjustForKeyboard(notification: Notification) {
		guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
		
		let keyboardScreenEndFrame = keyboardValue.cgRectValue
		let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
		
		if notification.name == UIResponder.keyboardWillHideNotification {
			script.contentInset = .zero
		} else {
			script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
		}
		
		script.scrollIndicatorInsets = script.contentInset
		
		let selectedRange = script.selectedRange
		script.scrollRangeToVisible(selectedRange)
	}
}
