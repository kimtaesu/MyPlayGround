import UIKit

var str = "Hello, 协议"

/*
 类、结构体、枚举都可以遵循协议
 协议 定义了一个蓝图，规定了用来实现某一特定任务或者功能的方法、属性，以及其他需要的东西。类、结构体或枚举都可以遵循协议，并为协议定义的这些要求提供具体实现。某个类型能够满足某个协议的要求，就可以说该类型遵循这个协议。
 除了遵循协议的类型必须实现的要求外，还可以对协议进行扩展，通过扩展来实现一部分要求或者实现一些附加功能，这样遵循协议的类型就能够使用这些功能。
 */

/*
 struct SomeStructure: FirstProtocol, AnotherProtocol {
 // 这里是结构体的定义部分
 }
 拥有父类的类在遵循协议时，应该将父类名放在协议名之前，以逗号分隔：
 class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
 // 这里是类的定义部分
 }
 */

// 属性要求✨
// 协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性。协议不指定属性是存储型属性还是计算型属性，它只指定属性的名称和类型。此外，协议还指定属性是可读的还是可读可写的。
/*
 protocol SomeProtocol {
 var mustBeSettable: Int { get set }
 var doesNotNeedToBeSettable: Int { get }
 }
 // 类属性总是使用 static 关键字作为前缀。当类类型遵循协议时，除了 static 关键字，还可以使用 class 关键字来声明类型属性
 protocol AnotherProtocol {
 static var someTypeProperty: Int { get set }
 }
 */


protocol FullyNamed {
  var fullName: String { get }
}

struct Person: FullyNamed {
  var fullName: String
}

let john = Person(fullName: "John Appleseed")

// 展示了一个计算属性
class Starship: FullyNamed {
  var prefix: String?
  var name: String
  init(name: String, prefix: String? = nil) {
    self.name = name
    self.prefix = prefix
  }
  var fullName: String {
    return (prefix != nil ? prefix! + " " : "") + name
  }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
// ncc1701.fullName 是 "USS Enterprise"
// 方法
/*
 protocol SomeProtocol {
 static func someTypeMethod()
 func random() -> Double
 }
 */
protocol RandomNumberGenerator {
  func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
  var lastRandom = 42.0
  let m = 139968.0
  let a = 3877.0
  let c = 29573.0
  func random() -> Double {
    lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
    return lastRandom / m
  }
}

let generatorttest = LinearCongruentialGenerator()
print("Here's a random number: \(generatorttest.random())")
// 打印 “Here's a random number: 0.37464991998171”
print("And another one: \(generatorttest.random())")
// 打印 “And another one: 0.729023776863283”
// Mutating
// 有时需要在方法中改变方法所属的实例。例如，在值类型（即结构体和枚举）的实例方法中，将 mutating 关键字作为方法的前缀，写在 func 关键字之前，表示可以在该方法中修改它所属的实例以及实例的任意属性的值。这一过程在在实例方法中修改值类型章节中有详细描述。
// >>>>>> 实现协议中的 mutating 方法时，若是类类型，则不用写 mutating 关键字。而对于结构体和枚举，则必须写  mutating 关键字。
protocol Togglable {
  mutating func toggle()
}

enum OnOffSwitch: Togglable {
  case off, on
  mutating func toggle() {
    switch self {
    case .off:
      self = .on
    case .on:
      self = .off
    }
  }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
// lightSwitch 现在的值为 .On
// 构造器方法
/*
 protocol SomeProtocol {
 init(someParameter: Int)
 }
 class SomeClass: SomeProtocol {
 required init(someParameter: Int) {
 // 这里是构造器的实现部分
 }
 }
 
 // 如果类已经被标记为 final，那么不需要在协议构造器的实现中使用 required 修饰符，因为 final 类不能有子类。关于 final 修饰符的更多内容，请参见防止重写。
 
 protocol SomeProtocol {
 init()
 }
 
 class SomeSuperClass {
 init() {
 // 这里是构造器的实现部分
 }
 }
 
 class SomeSubClass: SomeSuperClass, SomeProtocol {
 // 因为遵循协议，需要加上 required
 // 因为继承自父类，需要加上 override
 required override init() {
 // 这里是构造器的实现部分
 }
 }
 
 */

// 协议作为类型
// 尽管协议本身并未实现任何功能，但是协议可以被当做一个成熟的类型来使用。
//作为函数、方法或构造器中的参数类型或返回值类型
//作为常量、变量或属性的类型
//作为数组、字典或其他容器中的元素类型
class Dice {
  let sides: Int
  let generator: RandomNumberGenerator
  init(sides: Int, generator: RandomNumberGenerator) {
    self.sides = sides
    self.generator = generator
  }
  func roll() -> Int {
    return Int(generator.random() * Double(sides)) + 1
  }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
  print("Random dice roll is \(d6.roll())")
}
// Random dice roll is 3
// Random dice roll is 5
// Random dice roll is 4
// Random dice roll is 5
// Random dice roll is 4
// 委托（代理）模式
protocol DiceGame {
  var dice: Dice { get }
  func play()
}
protocol DiceGameDelegate {
  func gameDidStart(_ game: DiceGame)
  func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
  func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
  let finalSquare = 25
  let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
  var square = 0
  var board: [Int]
  init() {
    board = [Int](repeating: 0, count: finalSquare + 1)
    //        board = [Int](count: finalSquare + 1, repeatedValue: 0)
    board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
    board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
  }
  var delegate: DiceGameDelegate?
  func play() {
    square = 0
    delegate?.gameDidStart(self)
    gameLoop: while square != finalSquare {
      let diceRoll = dice.roll()
      delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
      switch square + diceRoll {
      case finalSquare:
        break gameLoop
      case let newSquare where newSquare > finalSquare:
        continue gameLoop
      default:
        square += diceRoll
        square += board[square]
      }
    }
    delegate?.gameDidEnd(self)
  }
}

class DiceGameTracker: DiceGameDelegate {
  var numberOfTurns = 0
  func gameDidStart(_ game: DiceGame) {
    numberOfTurns = 0
    if game is SnakesAndLadders {
      print("Started a new game of Snakes and Ladders")
    }
    print("The game is using a \(game.dice.sides)-sided dice")
  }
  func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
    numberOfTurns += 1
    print("Rolled a \(diceRoll)")
  }
  func gameDidEnd(_ game: DiceGame) {
    print("The game lasted for \(numberOfTurns) turns")
  }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()
// Started a n

// 通过扩展添加协议一致性
protocol TextRepresentable {
  var textualDescription: String { get }
}

struct Hamster {
  var name: String
  var textualDescription: String {
    return "A hamster named \(name)"
  }
}

// 遵循了一个协议，就可以作为这个类型来用
extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)
// 打印 “A hamster named Simon”
// 类类型专属协议类型
/*
 protocol SomeClassOnlyProtocol: class, SomeInheritedProtocol {
 // 这里是类类型专属协议的定义部分
 }
 */


// 协议合成
// 协议和协议合成、类和协议也可以合成
// 有时候需要同时遵循多个协议，你可以将多个协议采用 SomeProtocol & AnotherProtocol 这样的格式进行组合，称为 协议合成（protocol composition）。你可以罗列任意多个你想要遵循的协议，以与符号(&)分隔。
protocol Named {
  var name: String { get }
}
protocol Aged {
  var age: Int { get }
}
struct Person2: Named, Aged {
  var name: String
  var age: Int
}
func wishHappyBirthday(to celebrator: Named & Aged) {
  print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Person2(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)

// 将Location类和前面的Named协议进行组合：
class Location {
  var latitude: Double
  var longitude: Double
  init(latitude: Double, longitude: Double) {
    self.latitude = latitude
    self.longitude = longitude
  }
}
class City: Location, Named {
  var name: String
  init(name: String, latitude: Double, longitude: Double) {
    self.name = name
    super.init(latitude: latitude, longitude: longitude)
  }
}
func beginConcert(in location: Location & Named) {
  print("Hello, \(location.name)!")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)


// 检查协议一致性
/*
 is 用来检查实例是否符合某个协议，若符合则返回 true，否则返回 false。
 as? 返回一个可选值，当实例符合某个协议时，返回类型为协议类型的可选值，否则返回 nil。
 as! 将实例强制向下转换到某个协议类型，如果强转失败，会引发运行时错误。
 */
protocol HasArea {
  var area: Double { get }
}

class Country: HasArea {
  var area: Double
  init(area: Double) { self.area = area }
}

class Circle: HasArea {
  let pi = 3.1415927
  var radius: Double
  var area: Double { return pi * radius * radius }
  init(radius: Double) { self.radius = radius }
}


class Animal {
  var legs: Int
  init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
  Circle(radius: 2.0),
  Country(area: 243_610),
  Animal(legs: 4)
]

for object in objects {
  if let objectWithArea = object as? HasArea {
    print("Area is \(objectWithArea.area)")
  } else {
    print("Something that doesn't have an area")
  }
}

// 可选的协议要求
// 协议可以定义可选要求，遵循协议的类型可以选择是否实现这些要求。在协议中使用 optional 关键字作为前缀来定义可选要求。可选要求用在你需要和 Objective-C 打交道的代码中。协议和可选要求都必须带上@objc属性。标记 @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类遵循，其他类以及结构体和枚举均不能遵循这种协议。
// 使用可选要求时（例如，可选的方法或者属性），它们的类型会自动变成可选的✨
@objc protocol CounterDataSource {
  @objc optional func incrementForCount(count: Int) -> Int
  @objc optional var fixedIncrement: Int { get }
}

class ThreeSource: NSObject, CounterDataSource {
  let fixedIncrement = 3
}

//var counter = Counter()
//counter.dataSource = ThreeSource()
//for _ in 1...4 {
//    counter.increment()
//    print(counter.count)
//}
@objc class TowardsZeroSource: NSObject, CounterDataSource {
  func increment(forCount count: Int) -> Int {
    if count == 0 {
      return 0
    } else if count < 0 {
      return 1
    } else {
      return -1
    }
  }
}

// 协议扩展（牛批啊协议也可以拓展）
extension RandomNumberGenerator {
  func randomBool() -> Bool {
    return random() > 0.5
  }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// 打印 “Here's a random number: 0.37464991998171”
print("And here's a random Boolean: \(generator.randomBool())")
// 打印 “And here's a random Boolean: true”

// 协议中拓展的的默认实现，和遵循协议的类型里面实现的同样的方法，那么后者是会替代前者的实现
// 可以通过协议扩展来为协议要求的属性、方法以及下标提供默认的实现。如果遵循协议的类型为这些要求提供了自己的实现，那么这些自定义实现将会替代扩展中的默认实现被使用。
//extension PrettyTextRepresentable {
//    var prettyTextualDescription: String {
//        return textualDescription
//    }
//}
// 协议的继承
// 协议能够继承一个或多个其他协议，可以在继承的协议的基础上增加新的要求。协议的继承语法与类的继承相似，多个被继承的协议间用逗号分隔：
protocol InheritingProtocol: CounterDataSource, DiceGameDelegate {
  // 这里是协议的定义部分
}


// 类专属的协议
//你通过添加 AnyObject 关键字到协议的继承列表，就可以限制协议只能被类类型采纳（以及非结构体或者非枚举的类型）。
protocol SomeClassOnlyProtocol: AnyObject,DiceGameDelegate  {
  // 这里是类专属协议的定义部分
}

// 协议限制（where关键字来使用）
extension Collection where Iterator.Element: TextRepresentable {
  var textualDescription: String {
    let itemsAsText = self.map { $0.textualDescription }
    return "[" + itemsAsText.joined(separator: ", ") + "]"
  }
}

let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]
