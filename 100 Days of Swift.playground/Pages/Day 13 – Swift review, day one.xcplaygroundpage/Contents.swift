//: [Previous](@previous)

import Foundation
import UIKit

//: Variables and constants

var name = "Tim McGraw"
name = "Romeo"

let name1 = "Tim McGraw"
//name1 = "Romeo"

//: Types of Data

func cannotRun() {
	var name2: String
	name2 = "Tim McGraw"

	var age: Int
	age = 25

	var latitude: Double
	latitude = 36.166667

	var longitude: Float
	longitude = -86.783333

	var longitude1: Float
	longitude1 = -86.783333
	longitude1 = -186.783333
	longitude1 = -1286.783333
	longitude1 = -12386.783333
	longitude1 = -123486.783333
	longitude1 = -1234586.783333

	var stayOutTooLate: Bool
	stayOutTooLate = true

	var nothingInBrain: Bool
	nothingInBrain = true

	var missABeat: Bool
	missABeat = false
}

cannotRun()

//: Operators

var a = 10
a = a + 1
a = a - 1
a = a * a

var b = 10
b += 10
b -= 10

var aa = 1.1
var bb = 2.2
var cc = aa + bb

var name2 = "Tim McGraw"
var name3 = "Romeo"
var both = name2 + " and " + name3

cc > 3
cc >= 3
cc > 4
cc < 4

name == "Tim McGraw"

var stayOutTooLate = true
stayOutTooLate
!stayOutTooLate

var name4 = "Tim McGraw"
name4 == "Tim McGraw"
name4 != "Tim McGraw"

//: String interpolation

"Your name is \(name)"

"Your name is " + name

"Your name is \(name), your age is \(aa), and your latitude is \(bb)"

"You are \(aa) years old. In another \(aa) years you will be \(aa * 2)."

// Arrays

var evenNumbers = [2, 4, 6, 8]
var songs = ["Shake it Off", "You Belong with Me", "Back to December"]

songs[0]
songs[1]
songs[2]

type(of: songs)

var songs1: [Any] = ["Shake it Off", "You Belong with Me", "Back to December", 3]

//var songs: [String]
//songs[0] = "Shake it Off"
//var songs = [String] = []
//var songs = [String]()

var songs2 = ["Shake it Off", "You Belong with Me", "Love Story"]
var songs3 = ["Today was a Fairytale", "Welcome to New York", "Fifteen"]
var both1 = songs + songs2

both1 += ["Everything has Changed"]

//: Dictionaries

var person = [
	"first": "Taylor",
	"middle": "Alison",
	"last": "Swift",
	"month": "December",
	"website": "taylorswift.com"
]
person["middle"]
person["month"]

//: Conditional statements

var action: String = ""
var person1 = "hater"

if person1 == "hater" {
	action = "hate"
} else if person1 == "player" {
	action = "play"
} else {
	action = "cruise"
}

var action1: String = ""
var stayOutTooLate1 = true
var nothingInBrain1 = true

if stayOutTooLate1 && nothingInBrain1 {
	action1 = "cruise"
}

if !stayOutTooLate1 && !nothingInBrain1 {
	action = "cruise"
}

//: Loops

print("1 x 10 is \(1 * 10)")
print("2 x 10 is \(2 * 10)")
print("3 x 10 is \(3 * 10)")
print("4 x 10 is \(4 * 10)")
print("5 x 10 is \(5 * 10)")
print("6 x 10 is \(6 * 10)")
print("7 x 10 is \(7 * 10)")
print("8 x 10 is \(8 * 10)")
print("9 x 10 is \(9 * 10)")
print("10 x 10 is \(10 * 10)")

for i in 1...10 {
	print("\(i) x 10 is \(i * 10)")
}

var str = "Fakers gonna"

for _ in 1 ... 5 {
	str += " fake"
}

print(str)

for song in songs {
	print("My favorite song is \(song)")
}

var people = ["players", "haters", "heart-breakers", "fakers"]
var actions = ["play", "hate", "break", "fake"]

for i in 0 ... 3 {
	print("\(people[i]) gonna \(actions[i])")
}

for i in 0 ..< people.count {
	print("\(people[i]) gonna \(actions[i])")
}

for i in 0 ..< people.count {
	var str = "\(people[i]) gonna"
	
	for _ in 1 ... 5 {
		str += " \(actions[i])"
	}
	
	print(str)
}

var counter = 0

while true {
	print("Counter is now \(counter)")
	counter += 1
	
	if counter == 10 {
		break
	}
}

for song in songs {
	if song == "You Belong with Me" {
		continue
	}
	
	print("My favorite song is \(song)")
}

//: Switch case

let liveAlbums = 2

switch liveAlbums {
case 0:
	print("You're just starting out")
	
case 1:
	print("You just released iTunes Live From SoHo")
	
case 2:
	print("You just released Speak Now World Tour")
	
default:
	print("Have you done something new?")
}

let studioAlbums = 5

switch studioAlbums {
case 0...1:
	print("You're just starting out")
	
case 2...3:
	print("You're a rising star")
	
case 4...5:
	print("You're world famous!")
	
default:
	print("Have you done something new?")
}

//: [Next](@next)
