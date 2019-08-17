import UIKit


let downsampledImageQueue = DispatchQueue(label: "downsampledImage", qos: .unspecified, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)

let one = DispatchWorkItem {
    Thread.sleep(forTimeInterval: 1)
    print("done one")
}
let two = DispatchWorkItem {
    Thread.sleep(forTimeInterval: 0.3)
    print("done two")
}
let three = DispatchWorkItem {
    Thread.sleep(forTimeInterval: 0.1)
    print("done three")
}
downsampledImageQueue.sync(execute: one)
downsampledImageQueue.sync(execute: two)
downsampledImageQueue.sync(execute: three)

// done one
// done two
// done three

