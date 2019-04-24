import UIKit

extension UIView {
	func bounceOut(duration: TimeInterval) {
		UIView.animate(withDuration: duration) {
			self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
		}
	}
}

extension Int {
	func times(_ closure: () -> Void) {
		guard self > 0 else { return }
		for _ in 0 ..< self { closure() }
	}
}

extension Array where Element: Comparable {
	mutating func remove(item: Element) {
		if let position = self.firstIndex(of: item) {
			self.remove(at: position)
		}
	}
}
