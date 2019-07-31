import UIKit

public struct Thermometer {
  public var temperature: Double
  public init(temperature: Double) {
    self.temperature = temperature
  }
}

extension Thermometer: ExpressibleByFloatLiteral {
  public init(floatLiteral value: FloatLiteralType) {
    self.init(temperature: value)
  }
}
var thermometer: Thermometer = 56.8

/*
 Pizza
 */
struct Pizza {
  let ingredients: [String]
}

protocol Pizzeria {
  func makePizza(_ ingredients: [String]) -> Pizza
  func makeMargherita() -> Pizza
}

extension Pizzeria {
  func makeMargherita() -> Pizza {
    return makePizza(["tomato", "mozzarella"])
  }
}

struct Lombardis: Pizzeria {
  func makePizza(_ ingredients: [String]) -> Pizza {
    return Pizza(ingredients: ingredients)
  }
  
  func makeMargherita() -> Pizza {
    return makePizza(["tomato", "basil", "mozzarella"])
  }
}

let lombardis1: Pizzeria = Lombardis()
let lombardis2: Lombardis = Lombardis()

print(" lombardis1 : \(lombardis1.makeMargherita())")
print(" lombardis2 : \(lombardis2.makeMargherita())")


