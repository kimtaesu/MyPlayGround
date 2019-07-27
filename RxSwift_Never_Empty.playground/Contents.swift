//: A UIKit based Playground for presenting user interface
  
import RxSwift

example("never") {
  let disposeBag = DisposeBag()
  let neverSequence = Observable<String>.never()
  
  let neverSequenceSubscription = neverSequence
    .subscribe { _ in
      print("This will never be printed")
  }
  
  neverSequenceSubscription.disposed(by: disposeBag)
}
/*:
 ----
 ## empty
 Creates an empty `Observable` sequence that only emits a Completed event. [More info](http://reactivex.io/documentation/operators/empty-never-throw.html)
 */
example("empty") {
  let disposeBag = DisposeBag()
  
  Observable<Int>.empty()
    .subscribe { event in
      print(event)
    }
    .disposed(by: disposeBag)
}

