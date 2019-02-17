//: [Previous](@previous)

import Foundation

//: Using closures as parameters when they accept parameters

func travel(action: (String) -> Void) {
	print("I'm getting ready to go.")
	action("London")
	print("I arrived!")
}

travel { (place: String) in
	print("I'm going to \(place) in my car")
}

//: Using closures as parameters when they return values

func travel1(action: (String) -> String) {
	print("I'm getting ready to go.")
	let description = action("London")
	print(description)
	print("I arrived!")
}

travel1 { (place: String) -> String in
	return "I'm going to \(place) in my car"
}

//: Shorthand parameter names

travel1 { place -> String in
	return "I'm going to \(place) in my car"
}

travel1 { place in
	return "I'm going to \(place) in my car"
}

travel1 { place in
	"I'm going to \(place) in my car"
}

travel1 {
	"I'm going to \($0) in my car"
}

//: Closures with multiple parameters

func travel2(action: (String, Int) -> String) {
	print("I'm getting ready to go.")
	let description = action("London", 60)
	print(description)
	print("I arrived!")
}

travel2 {
	"I'm going to \($0) at \($1) miles per hour"
}

//: Returning closures from functions

func travel3() -> (String) -> Void {
	return {
		print("I'm going to \($0)")
	}
}

let result = travel3()
result("London")

let result2 = travel3()("London")

//: Capturing values

func travel4() -> (String) -> Void {
	var counter = 1
	
	return {
		print("\(counter). I'm going to \($0)")
		counter += 1
	}
}

let result3 = travel4()
result3("London")
result3("London")
result3("London")
result3("London")

/*:
1. You can assign closures to variables, then call them later on.
2. Closures can accept parameters and return values, like regular functions.
3. You can pass closures into functions as parameters, and those closures can have parameters of their own and a return value.
4. If the last parameter to your function is a closure, you can use trailing closure syntax.
5. Swift automatically provides shorthand parameter names like $0 and $1, but not everyone uses them.
6. If you use external values inside your closures, they will be captured so the closure can refer to them later.
*/

//: [Next](@next)
