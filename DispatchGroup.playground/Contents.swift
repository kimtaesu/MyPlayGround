import UIKit

let group = DispatchGroup()
let queue = DispatchQueue(label: "1")
let queue1 = DispatchQueue(label: "2")
let queue2 = DispatchQueue(label: "3")

print("1 enter")
group.enter()
queue.async {
    print("1 leave")
    group.leave()
}

print("2 enter")
group.enter()
queue1.async {
    print("2 leave")
    group.leave()
}

print("3 enter")
group.enter()
queue2.async {
    print("3 leave")
    group.leave()
}

// 완료될때 까지 기다림
group.wait(timeout: .distantFuture)
print("enter leave 작업 시작")

print()
queue.async(group: group) {
    print("1 async")
}

queue1.async(group: group) {
    print("2 async")
}
queue2.async(group: group) {
    print("3 async")
}

group.notify(queue: DispatchQueue.main) {
    print("notify 작업 완료!")
}

print("notify 시작!")
