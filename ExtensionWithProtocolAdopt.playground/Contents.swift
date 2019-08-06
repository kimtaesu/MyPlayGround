import UIKit

protocol TextRepresentable {
  var textualDescription: String { get }
  var abc: (() -> Void)? { get }
}

struct Hamster {
  var name: String
  var textualDescription: String {
    return "A hamster naamed \(name)"
  }
  var abc: (() -> Void)? {
     return {
      print("!!!!!!!! abc")
    }
  }
}

// 遵循了一个协议，就可以作为这个类型来用
extension Hamster: TextRepresentable {
  
}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)
