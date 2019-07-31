import UIKit

func swapTwoInts(a: inout Int, b: inout Int) {
  let temporaryA = a
  a = b
  b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(a: &someInt, b: &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// someInt is now 107, and anotherInt is now 3
