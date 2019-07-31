import UIKit

struct IntStack {
  var items = [Int]()
//  func add(x: Int) {
//    items.append(x) // Compile time error here.
//  }
  mutating func add(x: Int) {
    items.append(x) // Compile time error here.
  }
}

