

struct Calculator {
    var a: Int
    var b: Int
    
    var sum: Int {
        return a + b
    }
}

let calculator = Calculator(a: 3, b: 5)

let closure = {
    print("The result is \(calculator.sum)")
}

closure()
print()
print("변수를 캡처하고 클로저 내에서 값을 변경하면 클로저가 호출되면 클로저 범위를 벗어난 값에도 영향을 미칩니다.")
// "The result is 8"


func capture2() {
    //변수를 캡처하고 클로저 내에서 값을 변경하면 클로저가 호출되면 클로저 범위를 벗어난 값에도 영향을 미칩니다.
    var calculator = Calculator(a: 3, b: 5) // 0x618000220400
    
    print("local: \(Unmanaged<AnyObject>.passUnretained(calculator as AnyObject).toOpaque())")
    let closure = {
        calculator = Calculator(a: 33, b: 55) // 0x610000221be0
        print("closure: \(Unmanaged<AnyObject>.passUnretained(calculator as AnyObject).toOpaque())")
    }
    closure()
    print("위의 예에서 메모리 주소가 0x618000220400 인 계산기 개체를 인스턴스화합니다.")
    print("클로저 내에서 계산기에 새 값을 할당하고 주소는 0x610000221be0이됩니다.")
    print("마지막으로 클로저를 호출 한 후 메모리 주소를 통해 알 수 있듯이 계산기는 클로저 내부에 설정된 것을 유지합니다.")
    print()

}

capture2()

func cpatureList() {
    var calculator = Calculator(a: 3, b: 5)
    
    let closure = {
        print("The result is \(calculator.sum)")
    }
    
    calculator.b = 20
    closure() // Prints "The result is 23"
    print("불행히도 '기본 변수 캡처'에 사용 된 구현에 문제가 있습니다. 클로저를 호출하기 전에 일부 계산기 속성의 값을 변경하면 클로저 내부의 합은 더 이상 8이 아니지만 새 속성 값의 합입니다.")
    
    calculator.b = 5
    let closure2 = { [calculator] in
        print("The result is \(calculator.sum)")
    }
    
    
    print("클로저 내에서 캡처 한 후에 속성이 변경 되더라도이 동작을 방지하고 8을 인쇄하려면 다음과 같이 캡처 목록으로 변수를 명시 적으로 캡처 할 수 있습니다.")
    calculator.b = 20
    closure2()
    print("이런 식으로 변하지 않는 변수 계산기 사본을 유지합니다. 이 사본 덕분에 폐쇄 외부의 계산기에 대한 추가 변경은 폐쇄에 영향을 미치지 않습니다.")
    print()
}

cpatureList()
