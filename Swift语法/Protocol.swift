//
//  Protocol.swift
//  Swift语法
//
//  Created by caowei on 2020/9/12.
//  Copyright © 2020 caowei. All rights reserved.
//

/**
 协议 定义了一个蓝图，规定了用来实现某一特定任务或者功能的方法、属性，以及其他需要的东西。类、结构体或枚举都可以遵循协议，并为协议定义的这些要求提供具体实现。某个类型能够满足某个协议的要求，就可以说该类型遵循这个协议。
 除了遵循协议的类型必须实现的要求外，还可以对协议进行扩展，通过扩展来实现一部分要求或者实现一些附加功能，这样遵循协议的类型就能够使用这些功能。
 */

import UIKit

class Protocol: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let john = Person(fullName: "John Appleseed")
        // john.fullName 为 "John Appleseed"

        /**方法要求*/
        let generator = LinearCongruentialGenerator()
        print("Here's a random number: \(generator.random())")
        // 打印 “Here's a random number: 0.37464991998171”
        print("And another one: \(generator.random())")
        // 打印 “And another one: 0.729023776863283”

        /**异变方法要求*/
        var lightSwitch = OnOffSwitch.off
        lightSwitch.toggle()
        // lightSwitch 现在的值为 .on
        
        /**协议作为类型*/
        var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
        for _ in 1...5 {
            print("Random dice roll is \(d6.roll())")
        }
        // Random dice roll is 3
        // Random dice roll is 5
        // Random dice roll is 4
        // Random dice roll is 5
        // Random dice roll is 4
        
        
        /**委托*/
        let tracker = DiceGameTracker()
        let game = SnakesAndLadders()
        game.delegate = tracker
        game.play()
        // Started a new game of Snakes and Ladders
        // The game is using a 6-sided dice
        // Rolled a 3
        // Rolled a 5
        // Rolled a 4
        // Rolled a 5
        // The game lasted for 4 turns
        
        /**在扩展里添加协议遵循*/
        
        let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
        print(d12.textualDescription)
        // 打印 “A 12-sided dice”
        
        // 同样，SnakesAndLadders 类也可以通过扩展来采纳和遵循 TextRepresentable 协议：
        print(game.textualDescription)
        // 打印 “A game of Snakes and Ladders with 25 squares”
        
        // 有条件地遵循协议
        let myDice = [d6, d12]
        print(myDice.textualDescription)
        // 打印 "[A 6-sided dice, A 12-sided dice]"
        
        /** 在扩展里声明采纳协议*/
        let simonTheHamster = Hamster(name: "Simon")
        let somethingTextRepresentable: TextRepresentable = simonTheHamster
        print(somethingTextRepresentable.textualDescription)
        // 打印 “A hamster named Simon”
        
        
        /**使用合成实现来采纳协议*/
        let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
        let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
        if twoThreeFour == anotherTwoThreeFour {
            print("These two vectors are also equivalent.")
        }
        // 打印 "These two vectors are also equivalent."
        
        // 下面的例子中定义了 SkillLevel 枚举类型，其中定义了初学者（beginner）、中级（intermediate）和专家（expert）三种等级，专家等级会由额外的星级（stars）来进行排名。
        //Comparable是一个协议，它要求类型能够进行比较并返回一种布尔值来表示它们之间的关系。如果一个类型遵循了Comparable协议，那么它就可以被排序或者在其他需要比较的场合中被使用。
        enum SkillLevel: Comparable {
            case beginner
            case intermediate
            //这里的 expert(stars: Int) 是一个关联值，它表示一个包含不同等级技能的枚举值 SkillLevel.expert
            case expert(stars: Int)
        }
        
        var levels = [SkillLevel.beginner,SkillLevel.beginner,SkillLevel.expert(stars: 5),SkillLevel.expert(stars: 3)]
        for level in levels.sorted() {
            print(level)
        }
        // 打印 "beginner"
        // 打印 "intermediate"
        // 打印 "expert(stars: 3)"
        // 打印 "expert(stars: 5)"
        
        /**协议类型的集合*/
        // 协议类型可以在数组或者字典这样的集合中使用，在 协议类型 提到了这样的用法。下面的例子创建了一个元素类型为 TextRepresentable 的数组：
        let things: [TextRepresentable] = [game, d12, simonTheHamster]
        for thing in things {
            print(thing.textualDescription)
        }
        // A game of Snakes and Ladders with 25 squares
        // A 12-sided dice
        // A hamster named Simon
        
        // 注意 thing 常量是 TextRepresentable 类型而不是 Dice，DiceGame，Hamster 等类型，即使实例在幕后确实是这些类型中的一种。由于 thing 是 TextRepresentable 类型，任何 TextRepresentable 的实例都有一个 textualDescription 属性，所以在每次循环中可以安全地访问 thing.textualDescription。
        
        
        /**协议合成*/
        let birthdayPerson = Person2(name: "ma", age: 21)
        wishHappyBirthday(to: birthdayPerson)
        // 打印 “Happy birthday Malcolm - you're 21!”

        
        /**检查协议一致性*/
        // Circle，Country，Animal 并没有一个共同的基类，尽管如此，它们都是类，它们的实例都可以作为 AnyObject 类型的值，存储在同一个数组中：
        let objects: [AnyObject] = [
            Circle(radius: 2.0),
            Country(area: 243_610),
            Animal(legs: 4)
        ]
        // 如下所示，objects 数组可以被迭代，并对迭代出的每一个元素进行检查，看它是否遵循 HasArea 协议：
        for object in objects {
            if let objectWithArea = object as? HasArea {
                print("Area is \(objectWithArea.area)")
            } else {
                print("Something that doesn't have an area")
            }
        }
        // Area is 12.5663708
        // Area is 243610.0
        // Something that doesn't have an area
        
        // 当迭代出的元素遵循 HasArea 协议时，将 as? 操作符返回的可选值通过可选绑定，绑定到 objectWithArea 常量上。objectWithArea 是 HasArea 协议类型的实例，因此 area 属性可以被访问和打印。
        // objects 数组中的元素的类型并不会因为强转而丢失类型信息，它们仍然是 Circle，Country，Animal 类型。然而，当它们被赋值给 objectWithArea 常量时，只被视为 HasArea 类型，因此只有 area 属性能够被访问。
        
        /**协议扩展*/
        // 通过协议扩展，所有遵循协议的类型，都能自动获得这个扩展所增加的方法实现而无需任何额外修改：
        let generator = LinearCongruentialGenerator()
        print("Here's a random number: \(generator.random())")
        // 打印 “Here's a random number: 0.37464991998171”
        print("And here's a random Boolean: \(generator.randomBool())")
        // 打印 “And here's a random Boolean: true”

        
        /**为协议扩展添加限制条件*/
        let equalNumbers = [100, 100, 100, 100, 100]
        let differentNumbers = [100, 100, 200, 100, 200]
        
        print(equalNumbers.allEqual())
        // 打印 "true"
        print(differentNumbers.allEqual())
        // 打印 "false"
    }
}

/**协议语法*/
protocol SomeProtocol0 {
    // 这里是协议的定义部分
}

//要让自定义类型遵循某个协议，在定义类型时，需要在类型名称后加上协议名称，中间以冒号（:）分隔。遵循多个协议时，各协议之间用逗号（,）分隔：
//struct SomeStructure: FirstProtocol, AnotherProtocol {
//    // 这里是结构体的定义部分
//}

// 若是一个类拥有父类，应该将父类名放在遵循的协议名之前，以逗号分隔：
//class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
//    // 这里是类的定义部分
//}

/**属性要求*/
/**协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性。协议不指定属性是存储属性还是计算属性，它只指定属性的名称和类型。此外，协议还指定属性是可读的还是可读可写的。
如果协议要求属性是可读可写的，那么该属性不能是常量属性或只读的计算型属性。如果协议只要求属性是可读的，那么该属性不仅可以是可读的，如果代码需要的话，还可以是可写的。*/
// 协议总是用 var 关键字来声明变量属性，在类型声明后加上 { set get } 来表示属性是可读可写的，可读属性则用 { get } 来表示
protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

// 在协议中定义类型属性时，总是使用 static 关键字作为前缀。当类类型遵循协议时，除了 static 关键字，还可以使用 class 关键字来声明类型属性
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

// FullyNamed 协议除了要求遵循协议的类型提供 fullName 属性外，并没有其他特别的要求。这个协议表示，任何遵循 FullyNamed 的类型，都必须有一个可读的 String 类型的实例属性 fullName。
protocol FullyNamed {
    var fullName: String { get }
}

// 下面是一个遵循 FullyNamed 协议的简单结构体
// 这个例子中定义了一个叫做 Person 的结构体，用来表示一个具有名字的人。从第一行代码可以看出，它遵循了 FullyNamed 协议
struct Person: FullyNamed {
    var fullName: String
}

// Starship 类把 fullName 作为只读的计算属性来实现。每一个 Starship 类的实例都有一个名为 name 的非可选属性和一个名为 prefix 的可选属性。 当 prefix 存在时，计算属性 fullName 会将 prefix 插入到 name 之前，从而得到一个带有 prefix 的 fullName。
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
// ncc1701.fullName 为 "USS Enterprise"


/**方法要求*/
// 协议可以要求遵循协议的类型实现某些指定的实例方法或类方法。这些方法作为协议的一部分，像普通方法一样放在协议的定义中，但是不需要大括号和方法体。可以在协议中定义具有可变参数的方法，和普通方法的定义方式相同。但是，不支持为协议中的方法提供默认参数。
// 正如属性要求中所述，在协议中定义类方法的时候，总是使用 static 关键字作为前缀。即使在类实现时，类方法要求使用 class 或 static 作为关键字前缀，前面的规则仍然适用：
protocol SomeFuncProtocol {
    static func someTypeMethod()
}

// 下面的例子定义了一个只含有一个实例方法的协议：
// RandomNumberGenerator 协议要求遵循协议的类型必须拥有一个名为 random， 返回值类型为 Double 的实例方法。RandomNumberGenerator 协议并不关心每一个随机数是怎样生成的，它只要求必须提供一个随机数生成器。
protocol RandomNumberGenerator {
    func random() -> Double
}

// 下边是一个遵循并符合 RandomNumberGenerator 协议的类。该类实现了一个叫做 线性同余生成器（linear congruential generator） 的伪随机数算法
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


/**异变方法要求*/
// 有时需要在方法中改变（或异变）方法所属的实例。例如，在值类型（即结构体和枚举）的实例方法中，将 mutating 关键字作为方法的前缀，写在 func 关键字之前，表示可以在该方法中修改它所属的实例以及实例的任意属性的值。
// 如果你在协议中定义了一个实例方法，该方法会改变遵循该协议的类型的实例，那么在定义协议时需要在方法前加 mutating 关键字。这使得结构体和枚举能够遵循此协议并满足此方法要求。
// 注意：实现协议中的 mutating 方法时，若是类类型，则不用写 mutating 关键字。而对于结构体和枚举，则必须写 mutating 关键字

// Togglable 协议只定义了一个名为 toggle 的实例方法。顾名思义，toggle() 方法将改变实例属性，从而切换遵循该协议类型的实例的状态。
// toggle() 方法在定义的时候，使用 mutating 关键字标记，这表明当它被调用时，该方法将会改变遵循协议的类型的实例：
protocol Togglable {
    mutating func toggle()
}

// 当使用枚举或结构体来实现 Togglable 协议时，需要提供一个带有 mutating 前缀的 toggle() 方法。
// 下面定义了一个名为 OnOffSwitch 的枚举。这个枚举在两种状态之间进行切换，用枚举成员 On 和 Off 表示。枚举的 toggle() 方法被标记为 mutating，以满足 Togglable 协议的要求：
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


/**构造器要求*/
// 协议可以要求遵循协议的类型实现指定的构造器。你可以像编写普通构造器那样，在协议的定义里写下构造器的声明，但不需要写花括号和构造器的实体：
protocol SomeProtocol2 {
    init(someParameter: Int)
}


/**协议构造器要求的类实现*/
// 你可以在遵循协议的类中实现构造器，无论是作为指定构造器，还是作为便利构造器。无论哪种情况，你都必须为构造器实现标上 required 修饰符
// 使用 required 修饰符可以确保所有子类也必须提供此构造器实现，从而也能遵循协议。
// 注意：如果类已经被标记为 final，那么不需要在协议构造器的实现中使用 required 修饰符，因为 final 类不能有子类。
//class SomeProtocolClass: SomeProtocol3 {
//    required init(someParameter: Int) {
//        // 这里是构造器的实现部分
//    }
//}

// 如果一个子类重写了父类的指定构造器，并且该构造器满足了某个协议的要求，那么该构造器的实现需要同时标注 required 和 override 修饰符
protocol SomeProtocol4 {
    init()
}

class SomeSuperClass4 {
    init() {
        // 这里是构造器的实现部分
    }
}

class SomeSubClass: SomeSuperClass4, SomeProtocol4 {
    // 因为遵循协议，需要加上 required
    // 因为继承自父类，需要加上 override
    required override init() {
        // 这里是构造器的实现部分
    }
}


/**可失败构造器要求*/
// 协议还可以为遵循协议的类型定义可失败构造器要求
// 遵循协议的类型可以通过可失败构造器（init?）或非可失败构造器（init）来满足协议中定义的可失败构造器要求。协议中定义的非可失败构造器要求可以通过非可失败构造器（init）或隐式解包可失败构造器（init!）来满足。


/**协议作为类型*/
// 尽管协议本身并未实现任何功能，但是协议可以被当做一个功能完备的类型来使用。协议作为类型使用，有时被称作「存在类型」，这个名词来自「存在着一个类型 T，该类型遵循协议 T」。
/**
 协议可以像其他普通类型一样使用，使用场景如下：
 作为函数、方法或构造器中的参数类型或返回值类型
 作为常量、变量或属性的类型
 作为数组、字典或其他容器中的元素类型
 */
// 注意： 协议是一种类型，因此协议类型的名称应与其他类型（例如 Int，Double，String）的写法相同，使用大写字母开头的驼峰式写法，例如（FullyNamed 和 RandomNumberGenerator）。

// 下面是将协议作为类型使用的例子：

//generator 属性的类型为 RandomNumberGenerator，因此任何遵循了 RandomNumberGenerator 协议的类型的实例都可以赋值给 generator.除此之外并无其他要求。并且由于其类型是 RandomNumberGenerator，在 Dice 类中与 generator 交互的代码，必须适用于所有 generator 实例都遵循的方法。这句话的意思是不能使用由 generator 底层类型提供的任何方法或属性。但是你可以通过向下转型，从协议类型转换成底层实现类型，比如从父类向下转型为子类。

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    // Dice 类还有一个构造器，用来设置初始状态。构造器有一个名为 generator，类型为 RandomNumberGenerator 的形参。在调用构造方法创建 Dice 的实例时，可以传入任何遵循 RandomNumberGenerator 协议的实例给 generator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        // 因为 generator 遵循了 RandomNumberGenerator 协议，可以确保它有个 random() 方法可供调用。
        return Int(generator.random() * Double(sides)) + 1
    }
}

/**委托*/
// 委托是一种设计模式，它允许类或结构体将一些需要它们负责的功能委托给其他类型的实例。委托模式的实现很简单：定义协议来封装那些需要被委托的功能，这样就能确保遵循协议的类型能提供这些功能。委托模式可以用来响应特定的动作，或者接收外部数据源提供的数据，而无需关心外部数据源的类型。

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
        board = Array(repeating: 0, count: finalSquare + 1)
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

    //⚠️
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


/**在扩展里添加协议遵循*/
// 即便无法修改源代码，依然可以通过扩展令已有类型遵循并符合协议。扩展可以为已有类型添加属性、方法、下标以及构造器，因此可以符合协议中的相应要求。
// 注意：通过扩展令已有类型遵循并符合协议时，该类型的所有实例也会随之获得协议中定义的各项功能。

// 例如下面这个 TextRepresentable 协议，任何想要通过文本表示一些内容的类型都可以实现该协议。这些想要表示的内容可以是实例本身的描述，也可以是实例当前状态的文本描述：
protocol TextRepresentable {
    var textualDescription: String { get }
}
// 可以通过扩展，令先前提到的 Dice 类可以扩展来采纳和遵循 TextRepresentable 协议：
extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

// 同样，SnakesAndLadders 类也可以通过扩展来采纳和遵循 TextRepresentable 协议：
extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}


/**有条件地遵循协议⚠️*/
// 泛型类型可能只在某些情况下满足一个协议的要求，比如当类型的泛型形式参数遵循对应协议时。你可以通过在扩展类型时列出限制让泛型类型有条件地遵循某协议。在你采纳协议的名字后面写泛型 where 分句。
// 下面的扩展让 Array 类型只要在存储遵循 TextRepresentable 协议的元素时就遵循 TextRepresentable 协议。

extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ",") + "]"
    }
}

/** 在扩展里声明采纳协议*/
// 当一个类型已经遵循了某个协议中的所有要求，却还没有声明采纳该协议时，可以通过空的扩展来让它采纳该协议
struct Hamster {
    var name: String
       var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}
// 从现在起，Hamster 的实例可以作为 TextRepresentable 类型使用：


/**使用合成实现来采纳协议*/

// Swift 可以自动提供一些简单场景下遵循 Equatable、Hashable 和 Comparable 协议的实现。在使用这些合成实现之后，无需再编写重复的代码来实现这些协议所要求的方法。
/**
 Swift 为以下几种自定义类型提供了 Equatable 协议的合成实现：
 遵循 Equatable 协议且只有存储属性的结构体。
 遵循 Equatable 协议且只有关联类型的枚举
 没有任何关联类型的枚举
 */
// 在包含类型原始声明的文件中声明对 Equatable 协议的遵循，可以得到 == 操作符的合成实现，且无需自己编写任何关于 == 的实现代码。Equatable 协议同时包含 != 操作符的默认实现。

// 下面的例子中定义了一个 Vector3D 结构体来表示一个类似 Vector2D 的三维向量 (x, y, z)。由于 x、y 和 z 都是满足 Equatable 的类型，Vector3D 可以得到连等判断的合成实现。
//Equatable 是一个协议（protocol），用于定义两个对象是否可以相等。遵循 Equatable 协议的类型需要实现 == 运算符，并返回一个布尔值，表示两个对象是否相等。如果两个对象相等，则应该返回 true，否则返回 false。

struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
}

/**
 Swift 为以下几种自定义类型提供了 Hashable 协议的合成实现：
 遵循 Hashable 协议且只有存储属性的结构体。
 遵循 Hashable 协议且只有关联类型的枚举
 没有任何关联类型的枚举
 */

// 在包含类型原始声明的文件中声明对 Hashable 协议的遵循，可以得到 hash(into:) 的合成实现，且无需自己编写任何关于 hash(into:) 的实现代码。

/**协议的继承*/
// 协议能够继承一个或多个其他协议，可以在继承的协议的基础上增加新的要求。协议的继承语法与类的继承相似，多个被继承的协议间用逗号分隔：
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // 这里是协议的定义部分
}

// 如下所示，PrettyTextRepresentable 协议继承了 TextRepresentable 协议
protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
           for index in 1...finalSquare {
               switch board[index] {
               case let ladder where ladder > 0:
                   output += "▲ "
               case let snake where snake < 0:
                   output += "▼ "
               default:
                   output += "○ "
               }
           }
           return output
    }
}

/**类专属的协议*/
// 你通过添加 AnyObject 关键字到协议的继承列表，就可以限制协议只能被类类型采纳（以及非结构体或者非枚举的类型）
//protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
//    // 这里是类专属协议的定义部分
//
//}

// 在以上例子中，协议 SomeClassOnlyProtocol 只能被类类型采纳。如果尝试让结构体或枚举类型采纳 SomeClassOnlyProtocol，则会导致编译时错误。
// 注意：当协议定义的要求需要遵循协议的类型必须是引用语义而非值语义时，应该采用类类型专属协议。关于引用语义和值语义的更多内容，请查看 结构体和枚举是值类型 和 类是引用类型。


/**协议合成*/
// 要求一个类型同时遵循多个协议是很有用的。你可以使用协议组合来复合多个协议到一个要求里。协议组合行为就和你定义的临时局部协议一样拥有构成中所有协议的需求。协议组合不定义任何新的协议类型。
// 协议组合使用 SomeProtocol & AnotherProtocol 的形式。你可以列举任意数量的协议，用和符号（&）分开。除了协议列表，协议组合也能包含类类型，这允许你标明一个需要的父类

// 下面的例子中，将 Named 和 Aged 两个协议按照上述语法组合成一个协议，作为函数参数的类型：

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
//⚠️
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

// 这里有一个例子：将 Location 类和前面的 Named 协议进行组合
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

//let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
//beginConcert(in: seattle)
// 打印 "Hello, Seattle!"


/**检查协议一致性*/
/**
 你可以使用 类型转换 中描述的 is 和 as 操作符来检查协议一致性，即是否遵循某协议，并且可以转换到指定的协议类型。检查和转换协议的语法与检查和转换类型是完全一样的：
 is 用来检查实例是否遵循某个协议，若遵循则返回 true，否则返回 false；
 as? 返回一个可选值，当实例遵循某个协议时，返回类型为协议类型的可选值，否则返回 nil；
 as! 将实例强制向下转换到某个协议类型，如果强转失败，将触发运行时错误。
 */
// 下面的例子定义了一个 HasArea 协议，该协议定义了一个 Double 类型的可读属性 area：

protocol HasArea {
    var area: Double { get }
}
// 如下所示，Circle 类和 Country 类都遵循了 HasArea 协议：
// Circle 类把 area 属性实现为基于存储型属性 radius 的计算型属性。Country 类则把 area 属性实现为存储型属性。这两个类都正确地遵循了 HasArea 协议。

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

// 如下所示，Animal 是一个未遵循 HasArea 协议的类：
class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}


/**可选的协议要求*/
/**
 协议可以定义可选要求，遵循协议的类型可以选择是否实现这些要求。在协议中使用 optional 关键字作为前缀来定义可选要求。可选要求用在你需要和 Objective-C 打交道的代码中。协议和可选要求都必须带上 @objc 属性。标记 @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类遵循，其他类以及结构体和枚举均不能遵循这种协议。
 */
// 使用可选要求时（例如，可选的方法或者属性），它们的类型会自动变成可选的。比如，一个类型为 (Int) -> String 的方法会变成 ((Int) -> String)?。需要注意的是整个函数类型是可选的，而不是函数的返回值。
// 协议中的可选要求可通过可选链式调用来使用，因为遵循协议的类型可能没有实现这些可选要求。类似 someOptionalMethod?(someArgument) 这样，你可以在可选方法名称后加上 ? 来调用可选方法。详细内容可在 可选链式调用 章节中查看。

// 下面的例子定义了一个名为 Counter 的用于整数计数的类，它使用外部的数据源来提供每次的增量。数据源由 CounterDataSource 协议定义，它包含两个可选要求
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

// 注意:严格来讲，CounterDataSource 协议中的方法和属性都是可选的，因此遵循协议的类可以不实现这些要求，尽管技术上允许这样做，不过最好不要这样写。
// Counter 类含有 CounterDataSource? 类型的可选属性 dataSource，如下所示：
class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
    
}
// 这里使用了两层可选链式调用。首先，由于 dataSource 可能为 nil，因此在 dataSource 后边加上了 ?，以此表明只在 dataSource 非空时才去调用 increment(forCount:) 方法。其次，即使 dataSource 存在，也无法保证其是否实现了 increment(forCount:) 方法，因为这个方法是可选的。因此，increment(forCount:) 方法同样使用可选链式调用进行调用，只有在该方法被实现的情况下才能调用它，所以在 increment(forCount:) 方法后边也加上了 ?
//  调用 increment(forCount:) 方法在上述两种情形下都有可能失败，所以返回值为 Int? 类型。虽然在 CounterDataSource 协议中，increment(forCount:) 的返回值类型是非可选 Int。另外，即使这里使用了两层可选链式调用，最后的返回结果依旧是单层的可选类型。
// 在调用 increment(forCount:) 方法后，Int? 型的返回值通过可选绑定解包并赋值给常量 amount。如果可选值确实包含一个数值，也就是说，数据源和方法都存在，数据源方法返回了一个有效值。之后便将解包后的 amount 加到 count 上，增量操作完成。
// 如果没有从 increment(forCount:) 方法获取到值，可能由于 dataSource 为 nil，或者它并没有实现 increment(forCount:) 方法，那么 increment() 方法将试图从数据源的 fixedIncrement 属性中获取增量。fixedIncrement 是一个可选属性，因此属性值是一个 Int? 值，即使该属性在 CounterDataSource 协议中的类型是非可选的 Int。

// 下面的例子展示了 CounterDataSource 的简单实现。ThreeSource 类遵循了 CounterDataSource 协议，它实现了可选属性 fixedIncrement，每次会返回 3：
class ThreeSource: NSObject,CounterDataSource {
    let fixedIncrement = 3
}


/**协议扩展*/
// 协议可以通过扩展来为遵循协议的类型提供属性、方法以及下标的实现。通过这种方式，你可以基于协议本身来实现这些功能，而无需在每个遵循协议的类型中都重复同样的实现，也无需使用全局函数。

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

// 通过协议扩展，所有遵循协议的类型，都能自动获得这个扩展所增加的方法实现而无需任何额外修改：
// 协议扩展可以为遵循协议的类型增加实现，但不能声明该协议继承自另一个协议。协议的继承只能在协议声明处进行指定。

/**提供默认实现*/
// 可以通过协议扩展来为协议要求的方法、计算属性提供默认的实现。如果遵循协议的类型为这些要求提供了自己的实现，那么这些自定义实现将会替代扩展中的默认实现被使用。
// 注意：通过协议扩展为协议要求提供的默认实现和可选的协议要求不同。虽然在这两种情况下，遵循协议的类型都无需自己实现这些要求，但是通过扩展提供的默认实现可以直接调用，而无需使用可选链式调用。

// 例如，PrettyTextRepresentable 协议继承自 TextRepresentable 协议，可以为其提供一个默认的 prettyTextualDescription 属性来简单地返回 textualDescription 属性的值：
extension PrettyTextRepresentable {
    var prettyTextualDescription: String {
        return textualDescription
      }
}


/**为协议扩展添加限制条件*/
// 在扩展协议的时候，可以指定一些限制条件，只有遵循协议的类型满足这些限制条件时，才能获得协议扩展提供的默认实现。这些限制条件写在协议名之后，使用 where 子句来描述，

// 例如，你可以扩展 Collection 协议，适用于集合中的元素遵循了 Equatable 协议的情况。通过限制集合元素遵循 Equatable 协议， 作为标准库的一部分， 你可以使用 == 和 != 操作符来检查两个元素的等价性和非等价性。
extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}

// 注意：如果一个遵循的类型满足了为同一方法或属性提供实现的多个限制型扩展的要求， Swift 会使用最匹配限制的实现。


