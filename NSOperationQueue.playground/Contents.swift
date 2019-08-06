import Foundation
var str = "Hello, playground"

class MyOperation: Operation {
  var index: Int?
  override func main() {
    print("From My Operation \(self.index)")
  }
  init(index: Int) {
    super.init()
    self.index = index
  }
}

class MyWork {
  let queue = OperationQueue()
  init() {
    self.queue.addOperation(MyOperation(index: 0))
    self.queue.addOperation(MyOperation(index: 1))
    self.queue.addOperation(MyOperation(index: 2))
    self.queue.addOperation(MyOperation(index: 3))
    self.queue.addOperation(MyOperation(index: 4))
  }
}

let work = MyWork()

