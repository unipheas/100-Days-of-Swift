//
//  ViewController.swift
//  Project21
//
//  Created by Brian Phillips on 4/14/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
	}

	@objc func registerLocal() {
		let center = UNUserNotificationCenter.current()
		
		center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
			if granted {
				print("Yay!")
			} else {
				print("D'oh")
			}
		}
	}
	
	@objc func scheduleLocal(_ time: TimeInterval = 5) {
		registerCategories()
		
		let center = UNUserNotificationCenter.current()
		center.removeAllPendingNotificationRequests()
		
		let content = UNMutableNotificationContent()
		content.title = "Late wake up call"
		content.body = "The early bird catches the worm, but the second mouse gets the cheese."
		content.categoryIdentifier = "alarm"
		content.userInfo = ["customData": "fizzbuzz"]
		content.sound = UNNotificationSound.default
		
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
		
		let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
		center.add(request)
	}
	
	func registerCategories() {
		let center = UNUserNotificationCenter.current()
		center.delegate = self
		
		let show = UNNotificationAction(identifier: "show", title: "Tell me more…", options: .foreground)
		let remind = UNNotificationAction(identifier: "remind", title: "Remind me later", options: .foreground)
		let category = UNNotificationCategory(identifier: "alarm", actions: [show, remind], intentIdentifiers: [])
		
		center.setNotificationCategories([category])
	}
	
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
		// pull out the buried userInfo dictionary
		let userInfo = response.notification.request.content.userInfo
		
		if let customData = userInfo["customData"] as? String {
			print("Custom data received: \(customData)")
			
			switch response.actionIdentifier {
			case UNNotificationDefaultActionIdentifier:
				alertController("Default identifier")
			case "show":
				alertController("Show more information...")
			case "remind":
				alertController("Reminder set")
				scheduleLocal(86400)
			default:
				break
			}
		}
		
		// you must call the completion handler when you're done
		completionHandler()
	}
	
	func alertController(_ message: String) {
		let ac = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Okay", style: .default))
		
		present(ac, animated: true)
	}
	
}

