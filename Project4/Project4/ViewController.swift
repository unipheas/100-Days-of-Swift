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
	var progressView: UIProgressView!
	var websites = ["apple.com", "hackingwithswift.com"]
	
	override func loadView() {
		webView = WKWebView()
		webView.navigationDelegate = self
		view = webView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			title: "Open",
			style: .plain,
			target: self,
			action: #selector(openTapped)
		)
		
		let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
		let back = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(webView.goBack))
		let forward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(webView.goForward))
		
		progressView = UIProgressView(progressViewStyle: .default)
		progressView.sizeToFit()
		let progressButton = UIBarButtonItem(customView: progressView)
		
		toolbarItems = [progressButton, spacer, back, forward, refresh]
		navigationController?.isToolbarHidden = false
		
		webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
		
		let url = URL(string: "https://" + websites[0])!
		webView.load(URLRequest(url: url))
		webView.allowsBackForwardNavigationGestures = true
	}

	@objc func openTapped() {
		let alertController = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
		
		for website in websites {
			alertController.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
		}
		
		alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		alertController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		present(alertController, animated: true)
	}
	
	func openPage(action: UIAlertAction) {
		guard let actionTitle = action.title else { return }
		guard let url = URL(string: "https://" + actionTitle) else { return }
		webView.load(URLRequest(url: url))
	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		title = webView.title
	}
	
	override func observeValue(
		forKeyPath keyPath: String?,
		of object: Any?,
		change: [NSKeyValueChangeKey : Any]?,
		context: UnsafeMutableRawPointer?) {
			if keyPath == "estimatedProgress" {
				progressView.progress = Float(webView.estimatedProgress)
			}
	}
	
	func webView(
		_ webView: WKWebView,
		decidePolicyFor navigationAction: WKNavigationAction,
		decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
			let url = navigationAction.request.url
		
			if let host = url?.host {
				for website in websites {
					if host.contains(website) {
						decisionHandler(.allow)
						return
					}
				}
			}
		
			let alertController = UIAlertController(
				title: "Warning",
				message: "You're not allowed to view this website.",
				preferredStyle: .alert)
			alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
			present(alertController, animated: true)
		
			decisionHandler(.cancel)
	}
}
