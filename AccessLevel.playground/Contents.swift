import UIKit
import OpenPulbic



class SubOpenClass: OpenClass {
  override init() {
    
  }
  override func openFunc() {
    
  }
}

print("SubOpenClass: \(SubOpenClass())")

// public access level can't subclassing, just use
print("PublicClass: \(PublicClass())")

