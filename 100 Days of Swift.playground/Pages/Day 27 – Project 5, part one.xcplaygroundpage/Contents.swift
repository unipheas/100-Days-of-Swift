//: [Previous](@previous)

import Foundation

//: Strong capturing

class Singer {
	func playSong() {
		print("Shake it off!")
	}
}

func sing() -> () -> Void {
	let taylor = Singer()
	
	let singing = {
		taylor.playSong()
		return
	}
	
	return singing
}

let singFunction = sing()
singFunction()

//: Weak capturing

func sing1() -> () -> Void {
	let taylor = Singer()
	
	let singing = { [weak taylor] in
		taylor?.playSong()
		return
	}
	
	return singing
}

//: Unkown capturing

func sing2() -> () -> Void {
	let taylor = Singer()
	
	let singing = { [unowned taylor] in
		taylor.playSong()
		return
	}
	
	return singing
}

//: Capture lists alongside parameters

//writeToLog { [weak self] user, message in
//	self?.addToLog("\(user) triggered event: \(message)")
//}

//: Strong reference cycles

class House {
	var ownerDetails: (() -> Void)?
	
	func printDetails() {
		print("This is a great house.")
	}
	
	deinit {
		print("I'm being demolished!")
	}
}

class Owner {
	var houseDetails: (() -> Void)?
	
	func printDetails() {
		print("I own a house.")
	}
	
	deinit {
		print("I'm dying!")
	}
}

print("Creating a house and an owner")

do {
	let house = House()
	let owner = Owner()
	house.ownerDetails = owner.printDetails
	owner.houseDetails = house.printDetails
}

print("Done")

print("Creating a house and an owner")

do {
	let house = House()
	let owner = Owner()
	house.ownerDetails = { [weak owner] in owner?.printDetails() }
	owner.houseDetails = { [weak house] in house?.printDetails() }
}

print("Done")

/*:
1. If you know for sure your captured value will never go away while the closure has any chance of being called, you can use unowned. This is really only for the handful of times when weak would cause annoyances to use, but even when you could use guard let inside the closure with a weakly captured variable.
1. If you have a strong reference cycle situation – where thing A owns thing B and thing B owns thing A – then one of the two should use weak capturing. This should usually be whichever of the two will be destroyed first, so if view controller A presents view controller B, view controller B might hold a weak reference back to A.
1. If there’s no chance of a strong reference cycle you can use strong capturing. For example, performing animation won’t cause self to be retained inside the animation closure, so you can use strong capturing.
*/

//: [Next](@next)
