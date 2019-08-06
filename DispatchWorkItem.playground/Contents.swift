import UIKit

var str = "Hello, playground"
let myQueue = DispatchQueue(label: "myQueue")

let zeddItem = DispatchWorkItem(qos: .userInitiated) {
  for i in 1...5 {
    print("👻 \(i)")
  }
}
let alanItem = DispatchWorkItem(qos: .userInteractive) {
  for i in 100...105 {
    print("🌕 \(i)")
  }
}
myQueue.async(execute: zeddItem)
myQueue.async(execute: alanItem)

