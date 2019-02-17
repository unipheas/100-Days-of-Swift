//: [Previous](@previous)

import Foundation

//: Handling missing data

var age: Int? = nil

age = 38

//: Unwrapping optionals

var name: String? = nil

if let unwrapped = name {
	print("\(unwrapped.count) letters")
} else {
	print("Missing name.")
}

//: Unwrapping with guard

func greet(_ name: String?) {
	guard let unwrapped = name else {
		print("You didn't provide a name!")
		return
	}
	
	print("Hello, \(unwrapped)!")
}

//: Force unwrapping

let str = "5"
let num = Int(str)
print(num)

let num1 = Int(str)!
print(num1)

//: Implicitly unwrapped optionals

let age1: Int! = nil

//: Nil coalescing

func username(for id: Int) -> String? {
	if id == 1 {
		return "Taylor Swift"
	} else {
		return nil
	}
}

let user = username(for: 15) ?? "Anonymous"

//: Optional chaining

let names = ["John", "Paul", "George", "Ringo"]

let beatle = names.first?.uppercased()

//: Optional try

enum PasswordError: Error {
	case obvious
}

func checkPassword(_ password: String) throws -> Bool {
	if password == "password" {
		throw PasswordError.obvious
	}
	
	return true
}

do {
	try checkPassword("password")
	print("That password is good!")
} catch {
	print("You can't use that password.")
}

if let result = try? checkPassword("password") {
	print("Result was \(result)")
} else {
	print("D'oh.")
}

try! checkPassword("sekrit")
print("OK!")

// Failable initializers

struct Person {
	var id: String
	
	init?(id: String) {
		if id.count == 9 {
			self.id = id
		} else {
			return nil
		}
	}
}

//: Typecasting

class Animal { }
class Fish: Animal { }

class Dog: Animal {
	func makeNoise() {
		print("Woof!")
	}
}

let pets = [Fish(), Dog(), Fish(), Dog()]

for pet in pets {
	if let dog = pet as? Dog {
		dog.makeNoise()
	}
}

/*:
1. Optionals let us represent the absence of a value in a clear and unambiguous way.
2. Swift won’t let us use optionals without unwrapping them, either using if let or using guard let.
3. You can force unwrap optionals with an exclamation mark, but if you try to force unwrap nil your code will crash.
4. Implicitly unwrapped optionals don’t have the safety checks of regular optionals.
5. You can use nil coalescing to unwrap an optional and provide a default value if there was nothing inside.
6. Optional chaining lets us write code to manipulate an optional, but if the optional turns out to be empty the code is ignored.
7. You can use try? to convert a throwing function into an optional return value, or try! to crash if an error is thrown.
8. If you need your initializer to fail when it’s given bad input, use init?() to make a failable initializer.
9. You can use typecasting to convert one type of object to another.
*/

//: [Next](@next)
