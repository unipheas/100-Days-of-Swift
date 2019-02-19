//
//  DetailViewController.swift
//  Project1
//
//  Created by Brian Phillips on 2/19/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

	@IBOutlet var imageView: UIImageView!
	
	var selectedImage: String?
	var xImage: Int?
	var yImage: Int?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		title = "Picture \(xImage!) of \(yImage!)"
		navigationItem.largeTitleDisplayMode = .never

		if let imageToLoad = selectedImage {
			imageView.image = UIImage(named: imageToLoad)
		}
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.hidesBarsOnTap = true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.hidesBarsOnTap = false
	}
}
