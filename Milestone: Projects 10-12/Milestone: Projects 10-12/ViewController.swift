//
//  ViewController.swift
//  Milestone: Projects 10-12
//
//  Created by Brian Phillips on 3/23/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	var images = [Image]()
	let defaults = UserDefaults.standard
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addImage))
		
		if let savedImages = defaults.object(forKey: "images") as? Data {
			let jsonDecoder = JSONDecoder()
			
			do {
				images = try jsonDecoder.decode([Image].self, from: savedImages)
			} catch {
				print("Failed to load images")
			}
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return images.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "Image", for: indexPath) as? ImageCellTableViewCell else {
			fatalError("Unable to dequeue a ImageCell.")
		}
		
		let picture = images[indexPath.item]
		
		cell.name.text = picture.name
		
		let path = getDocumentsDirectory().appendingPathComponent(picture.image)
		cell.imageView?.image = UIImage(contentsOfFile: path.path)
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let viewController = storyboard?.instantiateViewController(withIdentifier: "LargeImage") as? LargeImageView {
			viewController.selectedImage = images[indexPath.row].image
			viewController.imageName = images[indexPath.row].name
			
			navigationController?.pushViewController(viewController, animated: true)
		}
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		images.remove(at: indexPath.row)
		tableView.reloadData()
		save()
	}
	
	@objc func addImage() {
		let picker = UIImagePickerController()
		picker.sourceType = .camera
		picker.allowsEditing = true
		picker.delegate = self
		present(picker, animated: true)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let image = info[.editedImage] as? UIImage else {
			return
		}
		
		let imageName = UUID().uuidString
		let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
		
		if let jpegData = image.jpegData(compressionQuality: 0.8) {
			try? jpegData.write(to: imagePath)
		}
		
		dismiss(animated: true)
		
		let alertController = UIAlertController(title: "Pick a name", message: "What would you like to name this image?", preferredStyle: .alert)
		alertController.addTextField()

		alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

		alertController.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak alertController] _ in
			guard let newName = alertController?.textFields?[0].text else { return }
			let pic = Image(name: newName, image: imageName)
			self?.images.append(pic)

			self?.tableView.reloadData()
			self?.save()
		})

		present(alertController, animated: true)
	}
	
	func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
	
	func save() {
		let jsonEncoder = JSONEncoder()
		if let savedData = try? jsonEncoder.encode(images) {
			defaults.set(savedData, forKey: "images")
		} else {
			print("Failed to save images.")
		}
	}
}

