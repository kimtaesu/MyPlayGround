import UIKit

var thing = "cars"

let closure = { [thing] in
  print("I love \(thing)")
}

thing = "airplanes"

closure()

// I love cars

var thing2 = "cars"

let closure2 = {
  print("I love \(thing2)")
}

thing2 = "airplanes"

closure2() // Prints: "I love airplanes"

// I love airplanes

