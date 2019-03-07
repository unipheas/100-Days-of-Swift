//
//  AppDelegate.swift
//  Project7
//
//  Created by Brian Phillips on 3/6/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		if let tabBarController = window?.rootViewController as? UITabBarController {
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let viewController = storyboard.instantiateViewController(withIdentifier: "NavController")
			viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
			tabBarController.viewControllers?.append(viewController)
		}
		
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
	}

	func applicationWillTerminate(_ application: UIApplication) {
	}

}
