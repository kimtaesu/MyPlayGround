import RxSwift

// Refer: http://minsone.github.io/programming/reactive-swift-flatmap-flatmapfirst-flatmaplatest

example("flatMap") {
  let t = Observable<Int>
    .interval(0.5, scheduler: MainScheduler.instance)  // 0.5초마다 발행
    .take(4)    // 4번 발행
  
  t.flatMap { (x: Int) -> Observable<Int> in
    let newTimer = Observable<Int>
      .interval(0.2, scheduler: MainScheduler.instance)  // 0.2초마다 발행
      .take(4)    // 4번 발행
      .map { _ in x }    // 전달받은 아이템을 그대로 전달
    return newTimer
    }
    .subscribe {
      print("Result : \($0)")
  }
  /*
   --- flatMap and flatMapLatest example ---
   t    : ----------0---------1----------2----------3X
   new0 :           ---0---0---0---0x
   new1 :                     ---1---1---1---1x
   new2 :                                ---2---2---2---2x
   new3 :                                           ---3---3---3---3X
   subs : -------------0---0---0-1-0-1---1--21--2---2--32--3---3---3x
 */
}


example("flatMapFirst") {
  let t = Observable<Int>
    .interval(0.5, scheduler: MainScheduler.instance)  // 0.5초마다 발행
    .take(4)    // 4번 발행
  
  t.flatMapFirst { (x: Int) -> Observable<Int> in
    let newTimer = Observable<Int>
      .interval(0.2, scheduler: MainScheduler.instance)  // 0.2초마다 발행
      .take(4)    // 4번 발행
      .map { _ in x }    // 전달받은 아이템을 그대로 전달
    return newTimer
    }
    .subscribe {
      print("Result : \($0)")
  }

  
  /*
   t    : ----------0----------1----------2----------3X
   new0 :           ---0---0---0---0x
   new2 :                                 ---2---2---2---2X
   subs : -------------0---0---0---0---------2---2---2---2x
   */
}


example("flatMapLatest") {
  let t = Observable<Int>
    .interval(0.5, scheduler: MainScheduler.instance)  // 0.5초마다 발행
    .take(4)    // 4번 발행
  
  t.flatMapLatest { (x: Int) -> Observable<Int> in
    let newTimer = Observable<Int>
      .interval(0.2, scheduler: MainScheduler.instance)  // 0.2초마다 발행
      .take(4)    // 4번 발행
      .map { _ in x }    // 전달받은 아이템을 그대로 전달
    return newTimer
    }
    .subscribe {
      print("Result : \($0)")
  }

  /*
   --- flatMap and flatMapLatest example ---
   t    : ----------0---------1----------2----------3X
   new0 :           ---0---0--x
   new1 :                     ---1---1---x
   new2 :                                ---2---2---x
   new3 :                                           ---3---3---3---3X
   subs : -------------0---0-----1---1------2---2------3---3---3---3x
   */
}
