import UIKit

struct SearchOption: Codable {
  let query: String
  var page: Int
  let size: Int
  
  public init(query: String, page: Int = 1, size: Int = 10) {
    self.query = query
    self.page = page
    self.size = size
  }
}

do {
  let data = try JSONEncoder().encode(SearchOption(query: "test"))
  let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
  print(dictionary)
} catch {
  print(error)
}
