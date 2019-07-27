  import RxSwift
  
  let var1 = Variable(0)
  let var2 = Variable(200)
  let var3 = Variable(var1.asObservable())
  
  _ = var3
    .asObservable()
    .switchLatest()
    .subscribe { print($0) }
  
  var1.value = 1
  var1.value = 2
  var1.value = 3
  var3.value = var2.asObservable()
  var2.value = 201
  var1.value = 5
  var1.value = 6

  /*
   Next(0)
   Next(1)
   Next(2)
   Next(3)
   Next(200)
   Next(201)
   Completed
   
   var1 : -0---1---2---3-------5---6---
   var2 : ---------------200-201-------
   var3 : -var1----------var2----------
   subs : -0---1---2---3-200-201-------
   
   */
