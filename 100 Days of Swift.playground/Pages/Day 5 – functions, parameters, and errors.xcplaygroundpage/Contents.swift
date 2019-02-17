//: [Previous](@previous)

import Foundation

//: Writing functions

func printHelp() {
	let message = """
Welcome to MyApp!

Run this app inside a directory of images and
MyApp will resize them all into thumbnails
"""
	
	print(message)
}

printHelp()

//: Accepting parameters

print("Hello, world!")

func square(number: Int) {
	print(number * number)
}

square(number: 8)

//: Returning values

func square1(number: Int) -> Int {
	return number * number
}

let result = square1(number: 8)

print(result)

//: Parameter labels

func square2(number: Int) -> Int {
	return number * number
}

let result1 = square2(number: 8)

func sayHello(to name: String) {
	print("Hello, \(name)!")
}

sayHello(to: "Taylor")

//: Omitting parameter labels

func greet(_ person: String) {
	print("Hello, \(person)!")
}

greet("Taylor")

//: Default parameters

func greet1(_ person: String, nicely: Bool = true) {
	if nicely == true {
		print("Hello, \(person)!")
	} else {
		print("Oh no, it's \(person) again...")
	}
}

greet1("Taylor")
greet1("Taylor", nicely: false)

//: Variadic functions

print("Haters", "gonna", "hate")

func square3(numbers: Int...) {
	for number in numbers {
		print("\(number) squared is \(number * number)")
	}
}

square3(numbers: 1, 2, 3, 4, 5)

//: Writing throwing functions

enum PasswordError: Error {
	case obvious
}

func checkPassword(_ password: String) throws -> Bool {
	if password == "password" {
		throw PasswordError.obvious
	}
	
	return true
}

//: Running throwing functions

do {
	try checkPassword("password")
	print("That password is good!")
} catch {
	print("You can't use that password")
}

//: inout parameters

func doubleInPlace(number: inout Int) {
	number *= 2
}

var myNum = 10
doubleInPlace(number: &myNum)

/*:
1. Functions let us re-use code without repeating ourselves.
2. Functions can accept parameters – just tell Swift the type of each parameter.
3. Functions can return values, and again you just specify what type will be sent back. Use tuples if you want to return several things.
4. You can use different names for parameters externally and internally, or omit the external name entirely.
5. Parameters can have default values, which helps you write less code when specific values are common.
6. Variadic functions accept zero or more of a specific parameter, and Swift converts the input to an array.
7. Functions can throw errors, but you must call them using try and handle errors using catch.
8. You can use inout to change variables inside a function, but it’s usually better to return a new value.
*/

//: [Next](@next)
