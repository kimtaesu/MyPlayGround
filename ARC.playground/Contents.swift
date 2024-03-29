import UIKit

func example1() {
    class Person {
        let name: String
        init(name: String) {
            self.name = name
            print("\(name) is being initialized")
        }
        deinit {
            print("\(name) is being deinitialized")
        }
    }
    var reference1: Person?
    var reference2: Person?
    var reference3: Person?

    reference1 = Person(name: "John Appleseed")
    reference2 = reference1
    reference3 = reference1

    reference1 = nil
    reference2 = nil

    reference3 = nil
    // Prints "John Appleseed is being deinitialized"
}

func example2() {
    class Person {
        let name: String
        init(name: String) { self.name = name }
        var apartment: Apartment?
        deinit { print("\(name) is being deinitialized") }
    }

    class Apartment {
        let unit: String
        init(unit: String) { self.unit = unit }
//        var tenant: Person?
        weak var tenant: Person?
        deinit { print("Apartment \(unit) is being deinitialized") }
    }
    var john: Person?
    var unit4A: Apartment?

    john = Person(name: "John Appleseed")
    unit4A = Apartment(unit: "4A")

    john!.apartment = unit4A
    unit4A!.tenant = john

}


func unowned() {
    class Customer {
        let name: String
        var card: CreditCard?
        init(name: String) {
            self.name = name
        }
        deinit { print("\(name) is being deinitialized") }
    }

    class CreditCard {
        let number: UInt64
        unowned let customer: Customer
        init(number: UInt64, customer: Customer) {
            self.number = number
            self.customer = customer
        }
        deinit { print("Card #\(number) is being deinitialized") }
    }
    var john: Customer?
    john = Customer(name: "John Appleseed")
    john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)
}

func Unowned_References_and_Implicitly_Unwrapped_Optional_Properties() {
    class Country {
        let name: String
        var capitalCity: City!
        init(name: String, capitalName: String) {
            self.name = name
            self.capitalCity = City(name: capitalName, country: self)
        }
        deinit {
            print("deinit Country")
        }
    }
    
    class City {
        let name: String
        unowned let country: Country
        init(name: String, country: Country) {
            self.name = name
            self.country = country
        }
        deinit {
            print("deinit City")
        }
    }
    var country = Country(name: "Canada", capitalName: "Ottawa")
    print("\(country.name)'s capital city is called \(country.capitalCity.name)")
    // Prints "Canada's capital city is called Ottawa"
}

//Unowned_References_and_Implicitly_Unwrapped_Optional_Properties()

func Strong_Reference_Cycles_for_Closures() {
    class HTMLElement {
        
        let name: String
        let text: String?
        
        lazy var asHTML: () -> String = {
            
            if let text = self.text {
                return "<\(self.name)>\(text)</\(self.name)>"
            } else {
                return "<\(self.name) />"
            }
        }
        init(name: String, text: String? = nil) {
            self.name = name
            self.text = text
        }
        deinit {
            print("\(name) is being deinitialized")
        }
    }
    let heading = HTMLElement(name: "h1")
    let defaultText = "some default text"
    heading.asHTML = {
        return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
    }
    print(heading.asHTML())
    // Prints "<h1>some default text</h1>"
    var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
    print(paragraph!.asHTML())
    // Prints "<p>hello, world</p>"
    paragraph = nil
}

//Strong_Reference_Cycles_for_Closures()

func strongRefObjectByUnowned() {
    class Customer {
        let name: String
        var card: CreditCard?
        init(name: String) {
            self.name = name
        }
        deinit { print("\(name) is being deinitialized") }
    }
    
    class CreditCard {
        let number: UInt64
        let customer: Customer
        
        init(number: UInt64, customer: Customer) {
            self.number = number
            self.customer = customer
        }
        deinit { print("Card #\(number) is being deinitialized") }
    }
    var john: Customer?
    john = Customer(name: "John Appleseed")
    john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)
    john = nil
}

strongRefObjectByUnowned()
