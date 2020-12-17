//
//  Expression.swift
//  Swift语法
//
//  Created by caowei on 2020/12/11.
//  Copyright © 2020 caowei. All rights reserved.
//  表达式

import UIKit

class Expression: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //通配符表达式
        //通配符表达式可以在赋值过程中显式忽略某个值。例如下面的代码中，10 被赋值给 x，而 20 则被忽略：
//        (x, _) = (10, 20)
        // x 为 10，20 被忽略
        
        // Key-path 表达式
        // Key-path 表达式引用一个类型的属性或下标。在动态语言中使场景可以使用 Key-path 表达式，例如观察键值对。格式为： \类型名.路径
        let s = SomeStructure(someValue: 12)
        let pathToProperty = \SomeStructure.someValue

        let value = s[keyPath: pathToProperty]
        // 值为 12

        //在一些可以通过类型推断来确定所访问的具体类型的上下文中，可以省略 key-path 前的类型名字。下面的代码使用 \.someProperty 代替了 SomeClass.someProperty ：

        let c = SomeClass2(someProperty: 10)
        c.observe(\.someProperty) { object, change in
            // ...
        }
        
        //使用 self 作为路径可以创建一个恒等 key path (\.self)。恒等 key path 可以作为整个实例的引用，因此你仅需一步操作便可以利用它来访问以及修改其存储的所有数据。例如：
        var compoundValue = (a: 1, b: 2)
        // 等价于 compoundValue = (a: 10, b: 20)
        compoundValue[keyPath: \.self] = (a: 10, b: 20)
        

        // 通过点语法，可以让路径包含多个属性名称，以此来访问某实例的属性的属性。下面的代码使用 key-path 表达式 \OuterStructure.outer.someValue 来访问 OuterStructure 类型中 outer 属性的 someValue 属性。

        let nested = OuterStructure(someValue: 24)
        let nestedKeyPath = \OuterStructure.outer.someValue

        let nestedValue = nested[keyPath: nestedKeyPath]
        // nestedValue 的值为 24
        
        //路径中也可以包含使用中括号的下标访问，只要下标访问的参数类型满足 Hashable 协议即可。下面的例子在 key path 中使用了下标来访问数组的第二个元素。
        let greetings = ["hello", "hola", "bonjour", "안녕"]
        let myGreeting = greetings[keyPath: \[String].[1]]
        // myGreeting 的值为 'hola'
        
        // 下标访问中使用的值可以是一个变量或者字面量，并且 key-path 表达式会使用值语义来捕获此值。下面的代码在 key-path 表达式和闭包中都使用了 index 变量来访问 greetings 数组的第三个元素。当 index 被修改时，key-path 表达式仍旧引用数组第三个元素，而闭包则使用了新的索引值。
        var index = 2
        let path = \[String].[index]
        let fn: ([String]) -> String = { strings in strings[index] }

        print(greetings[keyPath: path])
        // 打印 "bonjour"
        print(fn(greetings))
        // 打印 "bonjour"

        // 将 'index' 设置为一个新的值不会影响到 'path'
        index += 1
        print(greetings[keyPath: path])
        // 打印 "bonjour"

        // 'fn' 闭包使用了新值。
        print(fn(greetings))
        // 打印 "안녕"
     
        //路径可以使用可选链和强制解包。下面的代码在 key path 中使用了可选链来访问可选字符串的属性。
        let firstGreeting: String? = greetings.first
        print(firstGreeting?.count as Any)
        // 打印 "Optional(5)"
        
        // 使用 key path 实现同样的功能
        let count = greetings[keyPath: \[String].first?.count]
        print(count as Any)
        // 打印 "Optional(5)"
        
        
        //可以混合使用各种 key path 组件来访问一些深度嵌套类型的值。下面的代码通过组合不同的组件，使用 key-path 表达式访问了一个字典数组中不同的值和属性。
        let interestingNumbers = ["prime": [2, 3, 5, 7, 11, 13, 17],
                                  "triangular": [1, 3, 6, 10, 15, 21, 28],
                                  "hexagonal": [1, 6, 15, 28, 45, 66, 91]]
        print(interestingNumbers[keyPath: \[String: [Int]].["prime"]] as Any)
        // 打印 "Optional([2, 3, 5, 7, 11, 13, 17])"
        print(interestingNumbers[keyPath: \[String: [Int]].["prime"]![0]])
        // 打印 "2"
        print(interestingNumbers[keyPath: \[String: [Int]].["hexagonal"]!.count])
        // 打印 "7"
        print(interestingNumbers[keyPath: \[String: [Int]].["hexagonal"]!.count.bitWidth])// 中位数
        // 打印 "64"
        
        // 你可以在平时提供函数或者闭包的上下文里使用 key path 表达式。特别地，你可以用根类型是 SomeType 和路径产生 Value 类型值的 key path 表达式来替换类型是 (SomeType) -> Value 的函数或者闭包。
        var toDoList = [
            Task(description: "Practice ping-pong.", completed: false),
            Task(description: "Buy a pirate costume.", completed: true),
            Task(description: "Visit Boston in the Fall.", completed: false),
        ]
        // 下面两种写法是等价的。
        let descriptions = toDoList.filter(\.completed).map(\.description)
        let descriptions2 = toDoList.filter { $0.completed }.map { $0.description }
        
      //  任何 key path 表达式的副作用发生的关键在于表达式在哪里被执行。例如，如果你在 key path 表达式中的一个下标里使用函数调用，该函数只会在表达式计算的时候调用一次，而不是每次这个 key path 被使用的时候。
        func makeIndex() -> Int {
            print("Made an index")
            return 0
        }
        // 下面这行调用 makeIndex()。
        let taskKeyPath = \[Task][makeIndex()]
        // 打印 "Made an index"
        
        // 使用 taskKeyPath 不会再次调用 makeIndex()。
        let someTask = toDoList[keyPath: taskKeyPath]

        
        /**选择器表达式*/
        /**选择器表达式可以让你通过选择器来引用在 Objective-C 中方法（method）和属性（property）的 setter 和 getter 方法。
         #selector(方法名)
         #selector(getter: 属性名) #selector(setter: 属性名)         */
        
//        let selectorForMethod = #selector(SomeClass3.doSomething(-:))
//        let selectorForPropertyGetter = #selector(getter: SomeClass3.property)

//        let anotherSelector = #selector(SomeClass.doSomething(-:) as (SomeClass) -> (String) -> Void)

        
        /**Key-path 字符串表达式*/
        // key-path 字符串表达式可以访问一个引用 Objective-C 属性的字符串，通常在 key-value 编程和 key-value 观察 APIs 中使用。其格式如下：#keyPath ( 属性名 )
        // 属性名必须是一个可以在 Objective-C 运行时使用的属性的引用。在编译期，key-path 字符串表达式会被一个字符串字面量替换。例如：

        let cx = SomeClass4(someProperty: 12)
        let keyPath = #keyPath(SomeClass4.someProperty)
        if let value = cx.value(forKey: #keyPath(SomeClass4.someProperty)) {
            print(value)
        }
        // 打印 "12"

        print(keyPath == cx.getSomeKeyPath())
        // 打印 "true"
        
       /** 函数调用表达式*/
        // 函数调用表达式由函数名和参数列表组成，形式如下： 函数名(参数 1, 参数 2)
        // 函数名可以是值为函数类型的任意表达式。
        // 如果函数声明中指定了参数的名字，那么在调用的时候也必须得写出来。这种函数调用表达式具有以下形式：
        // 函数名(参数名 1: 参数 1, 参数名 2: 参数 2)
        
        // 如果函数的最后一个参数是函数类型，可以在函数调用表达式的尾部（右圆括号之后）加上一个闭包，该闭包会作为函数的最后一个参数。如下两种写法是等价的：
        // someFunction 接受整型和闭包的实参
//        someFunction(x, f: {$0 == 13})
//        someFunction(x) {$0 == 13}
        
        // anotherFunction 接受一个整型和两个闭包的实参
//        anotherFunction(x: x, f: { $0 == 13 }, g: { print(99) })
//        anotherFunction(x: x) { $0 == 13 } g: { print(99) }

       // 如果闭包是该函数的唯一参数，那么圆括号可以省略。
//        myData.someMethod() {$0 == 13}
//        myData.someMethod {$0 == 13}

        // 和函数类似，构造器表达式可以作为一个值。 例如：
        // 类型注解是必须的，因为 String 类型有多种构造器
        let initializer: (Int) -> String = String.init
        let oneTwoThree = [1, 2, 3].map(initializer).reduce("", +)
        print(oneTwoThree)
        // 打印“123”

        // 如果通过名字来指定某个类型，可以不用构造器表达式而直接使用类型的构造器。在其他情况下，你必须使用构造器表达式。


        /**显式成员表达式*/
        
        // 为了区分只有参数名有所不同的方法或构造器，在圆括号中写出参数名，参数名后紧跟一个冒号，对于没有参数名的参数，使用下划线代替参数名。而对于重载方法，则需使用类型注解进行区分。例如：

//        let instance = SomeClass5()
//
//        let a = instance.someMethod              // 有歧义
//        let b = instance.someMethod(_:y:)        // 无歧义
//
//        let d = instance.overloadedMethod        // 有歧义
//        let d = instance.overloadedMethod(_:y:)  // 有歧义
//        let d: (Int, Bool) -> Void  = instance.overloadedMethod(_:y:)  // 无歧义
        
        
       // 如果点号（.）出现在行首，它会被视为显式成员表达式的一部分，而不是隐式成员表达式的一部分。例如如下代码所展示的被分为多行的链式方法调用：
//        let x = [10, 3, 20, 15, 4]
//            .sort()
//            .filter { $0 > 5 }
//            .map { $0 * 100 }

        /**
         后缀 self 表达式
         后缀 self 表达式由某个表达式或类型名紧跟 .self 组成，其形式如下：
         表达式.self
         类型.self
         第一种形式返回表达式的值。例如：x.self 返回 x。
         第二种形式返回相应的类型。我们可以用它来获取某个实例的类型作为一个值来使用。例如，SomeClass.self 会返回 SomeClass 类型本身，你可以将其传递给相应函数或者方法作为参数。
         */
    }
}

struct SomeStructure {
    var someValue: Int
}

class SomeClass2: NSObject {
    @objc dynamic var someProperty: Int
    init(someProperty: Int) {
        self.someProperty = someProperty
    }
}

struct OuterStructure {
    var outer: SomeStructure
    init(someValue: Int) {
        self.outer = SomeStructure(someValue: someValue)
    }
}

// 你可以在平时提供函数或者闭包的上下文里使用 key path 表达式。特别地，你可以用根类型是 SomeType 和路径产生 Value 类型值的 key path 表达式来替换类型是 (SomeType) -> Value 的函数或者闭包。

struct Task {
    var description: String
    var completed: Bool
}

/**选择器表达式*/
class SomeClass3: NSObject {
    let property: String
    @objc(doSomethingWithInt:)
    func doSomething(_ x: Int) { }

    init(property: String) {
        self.property = property
    }
}

// 当为属性的 getter 创建选择器时，属性名可以是变量属性或者常量属性的引用。但是当为属性的 setter 创建选择器时，属性名只可以是对变量属性的引用。

// 方法名称可以包含圆括号来进行分组，并使用 as 操作符来区分具有相同方法名但类型不同的方法，例如:
extension SomeClass {
    @objc(doSomethingWithString:)
    func doSomething(_ x: String) { }
}

/**Key-path 字符串表达式*/
class SomeClass4: NSObject {
    @objc var someProperty: Int
    init(someProperty: Int) {
        self.someProperty = someProperty
    }
}

// 当在一个类中使用 key-path 字符串表达式时，可以省略类名，直接使用属性名来访问这个类的某个属性。
extension SomeClass4 {
    func getSomeKeyPath() -> String {
        return #keyPath(someProperty)
    }
}

// 由于 key-path 字符串表达式在编译期才创建，编译期可以检查属性是否存在，以及属性是否暴露给 Objective-C 运行时。


/**显式成员表达式*/
class SomeClass5 {
    func someMethod(x: Int, y: Int) {}
    func someMethod(x: Int, z: Int) {}
    func overloadedMethod(x: Int, y: Int) {}
    func overloadedMethod(x: Int, y: Bool) {}
}
