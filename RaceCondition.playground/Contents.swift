import Foundation
import PlaygroundSupport
import UIKit

//var balance = 1200
//
//struct ATM {
//  let tag: String
//  func withdraw(value: Int) {
//    print("\(self.tag): checking if balance containing sufficent money")
//    if balance > value {
//      print("\(self.tag): Balance is sufficent, please wait while processing withdrawal")
//      // sleeping for some random time, simulating a long process
//      Thread.sleep(forTimeInterval: Double.random(in: 0...2))
//      balance -= value
//      print("\(self.tag): Done: \(value) has been withdrawed")
//      print("\(self.tag): current balance is \(balance)")
//    } else {
//      print("\(self.tag): Can't withdraw: insufficent balance")
//    }
//  }
//}
//

// TimeLine
UIImage(named: "thread_timeline.png")

/*
 # RaceCondition
 두 개 이상의 스레드가 공유 데이터에 액세스하여 동시에 값을 변경하는 경우 발생합니다.
 
 # Priority inversion
 우선 순위가 낮은 작업이 우선 순위가 높은 작업에 필요한 리소스를 잠그면 발생합니다. 이 문제는 확률 적이기 때문에 식별하기가 어렵다.
 
 # Deadlocks
 교착 상태는 두 스레드가 공유 자원을 해제하기 위해 서로 기다리는 동안 발생하며 무한대로 차단됩니다.
*/

// # Attempt 1: A good design is your best shot
//var balance = 1200
//
//struct ATM {
//  let tag: String
//  func withdraw(value: Int) {
//    func isBalanceSufficent() -> Bool {
//      if balance > value {
//        return true
//      } else {
//        print("\(self.tag): Can't withdraw: insufficent balance")
//        return false
//      }
//    }
//
//    print("\(self.tag): checking if balance containing sufficent money")
//    if isBalanceSufficent() {
//      print("\(self.tag): Balance is sufficent, please wait while processing withdrawal")
//      // sleeping for some random time, simulating a long process
//      Thread.sleep(forTimeInterval: Double.random(in: 0...2))
//      if isBalanceSufficent() {
//        balance -= value
//        print("\(self.tag): Done: \(value) has been withdrawed")
//        print("\(self.tag): current balance is \(balance)")
//      }
//    }
//  }
//}
//


//Attempt 2: Using Locks
var balance = 1200

let lock = NSLock()
struct ATM {
  let tag: String
  func withdraw(value: Int) {
    // start of the critical section - acquire the lock
    lock.lock()
    print("\(self.tag): checking if balance containing sufficent money")
    if balance > value {
      print("\(self.tag): Balance is sufficent, please wait while processing withdrawal")
      // sleeping for some random time, simulating a long process
      Thread.sleep(forTimeInterval: Double.random(in: 0...2))
      balance -= value
      print("\(self.tag): Done: \(value) has been withdrawed")
      print("\(self.tag): current balance is \(balance)")
    } else {
      print("\(self.tag): Can't withdraw: insufficent balance")
    }
    // end of the critical section - release the lock
    lock.unlock()
  }
}

let queue = DispatchQueue(label: "WithdrawalQueue", attributes: .concurrent)

queue.async {
  let firstATM = ATM(tag: "firstATM")
  firstATM.withdraw(value: 1000)
}

queue.async {
  let secondATM = ATM(tag: "secondATM")
  secondATM.withdraw(value: 800)
}

//     잠금 장치는 신중해야합니다. 조심하지 않으면 교착 상태가 발생할 수 있습니다. 두 개의 동시 스레드가 실행 중이라고 가정하고 다음 시나리오를 고려하십시오.

//Attempt 3: Using Serial Queues
