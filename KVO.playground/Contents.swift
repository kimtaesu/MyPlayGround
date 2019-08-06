import UIKit

class SomeClass: NSObject {
  @objc dynamic var value: String = ""
//  유일한 프로퍼티인 value 앞에는 dynamic 이라는 수식어가 붙어있는데 dynamic dispatch 를 활성화 시키는 오퍼레이터다.
//  간단(?)하게 언급하자면 키패스(KeyPath) 이름을 이용해 프로퍼티의 주소를 찾게 해 주도록 하라는 정도라고 할 수 있을 것 같다.
}

let someObject = SomeClass()

someObject.observe(\.value) { (object, change) in
  print("SomeClass object value changed to \(object.value)")
}

someObject.value = "test1"  // TEST
someObject.value = "test2"  // TEST
