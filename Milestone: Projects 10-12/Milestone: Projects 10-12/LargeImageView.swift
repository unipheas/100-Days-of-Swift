//
//  LargeImageView.swift
//  Milestone: Projects 10-12
//
//  Created by Brian Phillips on 3/24/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit

class LargeImageView: UIViewController {

	@IBOutlet var pictureView: UIImageView!
	
	var selectedImage: String?
	var imageName: String?
	
	override func viewDidLoad() {
        super.viewDidLoad()

		title = imageName
		navigationItem.largeTitleDisplayMode = .never
		
		let path = getDocumentsDirectory().appendingPathComponent(selectedImage!)
		pictureView.image = UIImage(contentsOfFile: path.path)
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.hidesBarsOnTap = true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.hidesBarsOnTap = false
	}
	
	func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
}
