//: [Previous](@previous)

import Foundation

//: Creating classes

class Dog {
	var name: String
	var breed: String
	
	init(name: String, breed: String) {
		self.name = name
		self.breed = breed
	}
}

let poppy = Dog(name: "Poppy", breed: "Poodle")

//: Class inheritance

class Poodle: Dog {
	init(name: String) {
		super.init(name: name, breed: "Poodle")
	}
}

//: Overriding methods

class Dog1 {
	func makeNoise() {
		print("Woof!")
	}
}

class Poodle1: Dog1 {
}

let poppy1 = Poodle1()
poppy1.makeNoise()

class Poodle2: Dog1 {
	override func makeNoise() {
		print("Yip!")
	}
}

let poppy2 = Poodle2()
poppy2.makeNoise()

//: Final classes

final class Dog2 {
	var name: String
	var breed: String
	
	init(name: String, breed: String) {
		self.name = name
		self.breed = breed
	}
}

//: Copying objects

class Singer {
	var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name)

var singerCopy = singer
singerCopy.name = "Justin Bieber"

print(singer.name)

struct Singers {
	var name = "Taylor Swift"
}

var singer1 = Singers()
print(singer1.name)

var singerCopy1 = singer1
singerCopy1.name = "Justin Bieber"

print(singer1.name)

//: Deinitializers

class Person {
	var name = "John Doe"
	
	init() {
		print("\(name) is alive!")
	}
	
	func printGreeting() {
		print("Hello, I'm \(name)")
	}
	
	deinit {
		print("\(name) is no more!")
	}
}

for _ in 1...3 {
	let person = Person()
	person.printGreeting()
}

//: Mutability

class Singer1 {
	var name = "Taylor Swift"
}

let taylor = Singer1()
taylor.name = "Ed Sheeran"
print(taylor.name)

class Singer2 {
	var name = "Taylor Swift"
}

/*:
1. Classes and structs are similar, in that they can both let you create your own types with properties and methods.
2. One class can inherit from another, and it gains all the properties and methods of the parent class. It’s common to talk about class hierarchies – one class based on another, which itself is based on another.
3. You can mark a class with the final keyword, which stops other classes from inheriting from it.
4. Method overriding lets a child class replace a method in its parent class with a new implementation.
5. When two variables point at the same class instance, they both point at the same piece of memory – changing one changes the other.
6. Classes can have a deinitializer, which is code that gets run when an instance of the class is destroyed.
7. Classes don’t enforce constants as strongly as structs – if a property is declared as a variable, it can be changed regardless of how the class instance was created.
*/

//: [Next](@next)
