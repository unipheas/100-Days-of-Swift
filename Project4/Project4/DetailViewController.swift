//
//  DetailViewController.swift
//  Project4
//
//  Created by Brian Phillips on 2/24/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
	@IBOutlet var imageView: UIImageView!
	
	var selectedImage: String?
	var components: [String]??

    override func viewDidLoad() {
        super.viewDidLoad()
		
		components = selectedImage?.components(separatedBy: ".")
		title = components!![0]
		
		navigationItem.largeTitleDisplayMode = .never
		
		if let imageToLoad = selectedImage {
			imageView.layer.borderWidth = 1
			imageView.layer.borderColor = UIColor.lightGray.cgColor
			imageView.image = UIImage(named: imageToLoad)
		}
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .action,
			target: self,
			action: #selector(shareTapped)
		)
		
    }
	
	@objc func shareTapped(action: UIAlertAction! = nil) {
		guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
			print("No image found")
			return
		}
		
		let viewController = UIActivityViewController(
			activityItems: [image, components!![0]],
			applicationActivities: []
		)
		viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		present(viewController, animated: true)
	}

}
