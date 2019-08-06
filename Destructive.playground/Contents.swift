import UIKit

public protocol Resource {

  var age: Int { get }

  var name: String { get }
}

public struct Person: Resource {

  public init(name: String, age: Int? = nil) {
    self.name = name
    self.age = age ?? 0
  }

  public let age: Int

  public let name: String
}

public func destructive(with resource: Resource?) {
  print("destructive: \(resource)")
}

extension String: Resource {
  public var age: Int { return 0 }
  public var name: String { return self }
}

destructive(with: "tyler")
