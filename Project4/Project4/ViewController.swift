//
//  ViewController.swift
//  Project4
//
//  Created by Brian Phillips on 2/25/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
	var webView: WKWebView!
	
	override func loadView() {
		webView = WKWebView()
		webView.navigationDelegate = self
		view = webView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
		
		let url = URL(string: "https://www.hackingwithswift.com")!
		webView.load(URLRequest(url: url))
		webView.allowsBackForwardNavigationGestures = true
	}

	@objc func openTapped() {
		let alertController = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
		alertController.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
		alertController.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
		alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		alertController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		present(alertController, animated: true)
	}
	
	func openPage(action: UIAlertAction){
		guard let actionTitle = action.title else { return }
		guard let url = URL(string: "https://" + actionTitle) else { return }
		webView.load(URLRequest(url: url))
	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		title = webView.title
	}
}

