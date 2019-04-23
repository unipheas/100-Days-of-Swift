import UIKit

let name = "Taylor"

for letter in name {
	print("Give me a \(letter)!")
}

//print(name[3])

let letter = name[name.index(name.startIndex, offsetBy: 3)]

extension String {
	subscript(i: Int) -> String {
		return String(self[index(startIndex, offsetBy: i)])
	}
}

let password = "12345"
password.hasPrefix("123")
password.hasSuffix("345")

extension String {
	// remove a prefix if it exists
	func deletingPrefix(_ prefix: String) -> String {
		guard self.hasPrefix(prefix) else { return self }
		return String(self.dropFirst(prefix.count))
	}
	
	// remove a suffix if it exists
	func deletingSuffix(_ suffix: String) -> String {
		guard self.hasSuffix(suffix) else { return self }
		return String(self.dropLast(suffix.count))
	}
}

"this is".deletingSuffix("is")

let weather = "it's going to rain"
print(weather.capitalized)

extension String {
	var capitalizedFirst: String {
		guard let firstLetter = self.first else { return "" }
		return firstLetter.uppercased() + self.dropFirst()
	}
}

let input = "Swift is like Objective-C without the C"
input.contains("Swift")

let languages = ["Python", "Ruby", "Swift"]
languages.contains("Swift")

extension String {
	func containsAny(of array: [String]) -> Bool {
		for item in array {
			if self.contains(item) {
				return true
			}
		}
		
		return false
	}
}

input.containsAny(of: languages)

languages.contains(where: input.contains)

let string = "This is a test string"
let attributes: [NSAttributedString.Key: Any] = [
	.foregroundColor: UIColor.white,
	.backgroundColor: UIColor.red,
	.font: UIFont.boldSystemFont(ofSize: 36)
]

//let attributedString = NSAttributedString(string: string, attributes: attributes)

let attributedString = NSMutableAttributedString(string: string)
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))


extension String {
	func withPrefix (_ pre: String) -> String {
		return pre + self
	}
}

"pet".withPrefix("car")

extension String {
	var isNumeric: Bool {
		let numberRegEx  = ".*[0-9]+.*"
		let testCase = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
		let containsNumber = testCase.evaluate(with: self)
		
		return containsNumber
	}
}

"123".isNumeric

extension String {
	var lines: [String.SubSequence] {

		let newArray = self.split(separator: "\n")

		return newArray
	}
}

"this\nis\na\ntest".lines


