//: [Previous](@previous)

import Foundation
import UIKit

//: Properties

struct Person {
	var clothes: String
	var shoes: String
	
	func describe() {
		print("I like wearing \(clothes) with \(shoes)")
	}
}

let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
let other = Person(clothes: "short skirts", shoes: "high heels")
taylor.describe()
other.describe()

struct Person1 {
	var clothes: String {
		willSet {
			updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
		}
		
		didSet {
			updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
		}
	}
}

func updateUI(msg: String) {
	print(msg)
}

var taylor1 = Person1(clothes: "T-shirts")
taylor1.clothes = "short skirts"

struct Person2 {
	var age: Int
	
	var ageInDogYears: Int {
		get {
			return age * 7
		}
	}
}

var fan = Person2(age: 25)
print(fan.ageInDogYears)

//: Static properties and methods

struct TaylorFan {
	static var favoriteSong = "Look What You Made Me Do"
	
	var name: String
	var age: Int
}

let fan1 = TaylorFan(name: "James", age: 25)
print(TaylorFan.favoriteSong)

//: Access control

class TaylorFan1 {
	private var name: String!
}

//: Polymorphism and typecasting

class Album {
	var name: String
	
	init(name: String) {
		self.name = name
	}
	
	func getPerformance() -> String {
		return "The album \(name) sold lots"
	}
}

class StudioAlbum: Album {
	var studio: String
	
	init(name: String, studio: String) {
		self.studio = studio
		super.init(name: name)
	}
	
	override func getPerformance() -> String {
		return "The studio album \(name) sold lots"
	}
}

class LiveAlbum: Album {
	var location: String
	
	init(name: String, location: String) {
		self.location = location
		super.init(name: name)
	}
	
	override func getPerformance() -> String {
		return "The live album \(name) sold lots"
	}
}

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]

for album in allAlbums {
	print(album.getPerformance())
}

for album in allAlbums {
	print(album.getPerformance())
}

for album in allAlbums {
	let studioAlbum = album as? StudioAlbum
}

for album in allAlbums {
	print(album.getPerformance())
	
	if let studioAlbum = album as? StudioAlbum {
		print(studioAlbum.studio)
	} else if let liveAlbum = album as? LiveAlbum {
		print(liveAlbum.location)
	}
}

var taylorSwift1 = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless1 = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")

var allAlbums1: [Album] = [taylorSwift, fearless]

for album in allAlbums1 {
	let studioAlbum = album as! StudioAlbum
	print(studioAlbum.studio)
}

for album in allAlbums1 as! [StudioAlbum] {
	print(album.studio)
}

for album in allAlbums1 as? [LiveAlbum] ?? [LiveAlbum]() {
	print(album.location)
}

let number = 5
let text1 = number as? String

//: Closures

let vw = UIView()

UIView.animate(withDuration: 0.5, animations: {
	vw.alpha = 0
})

UIView.animate(withDuration: 0.5) {
	vw.alpha = 0
}

//: [Next](@next)
