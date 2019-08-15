func example1() {
    class MyClass {
        
        func doSomethig() { }
        
        deinit {
            print("deinit MyClass")
        }
    }
    
    class Handler {
        var closure: (() -> Void)?
        let obj = MyClass()
        
        func setupClosure() {
            closure = {
                self.obj.doSomethig()
            }
            print("example1: Strong Reference Cycles 이 발생")
        }
        deinit {
            print("deinit Handler")
        }
    }
    
    var handler: Handler? = Handler()
    handler?.setupClosure()
    handler = nil
}
example1()
print()

func example2() {
    class MyClass {
        
        func doSomethig() { }
        
        deinit {
            print("deinit MyClass")
        }
    }
    
    class Handler {
        var closure: (() -> Void)?
        
        func setupClosure() {
            let obj = MyClass()
            
            closure = {
                obj.doSomethig()
            }
            print("example2 : Strong Reference Cycles 이 발생하지 않음")
        }
        deinit {
            print("deinit Handler")
        }
    }
    
    var handler: Handler? = Handler()
    handler?.setupClosure()
    handler = nil
}

example2()
print()
