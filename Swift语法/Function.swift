//
//  Function.swift
//  Swift语法
//
//  Created by caowei on 2020/6/4.
//  Copyright © 2020 caowei. All rights reserved.
//
/**
 函数
 */
import UIKit

class Function: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /**函数的定义与调用*/
        print(greetf(person: "Anna"))
        // 打印“Hello, Anna!”
        print(greetf(person: "Brian"))
        // 打印“Hello, Brian!”
        
        print(greetAgain(person: "Anna"))
        // 打印“Hello again, Anna!”
        
        //多参数函数
        print(greetf(person: "Tim", alreadyGreeted: true))
        // 打印“Hello again, Tim!”
        
        //调用函数时，可以忽略该函数的返回值：
        printAndCount(string: "hello, world")
        // 打印“hello, world”，并且返回值 12
        printWithoutCounting(string: "hello, world")
        // 打印“hello, world”，但是没有返回任何值
        
        /**多重返回值函数*/
        let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
        print("min is \(bounds.min) and max is \(bounds.max)")
        // 打印“min is -6 and max is 109”
        
        /**隐式返回的函数*/
        print(greeting(for: "Dave"))// 打印 "Hello, Dave!"
        
        print(greet(person: "Bill", from: "Cupertino"))
        // 打印“Hello Bill!  Glad you could visit from Cupertino.”
        
        /**使用函数类型*/
        //定义一个叫做 mathFunction 的变量，类型是‘一个有两个 Int 型的参数并返回一个 Int 型的值的函数’，并让这个新变量指向 addTwoInts 函数”。
        var mathFunction: (Int, Int) -> Int = addTwoInts//// anotherMathFunction 被推断为 (Int, Int) -> Int 类型
        //现在，你可以用 mathFunction 来调用被赋值的函数了：
        print("Result: \(mathFunction(2, 3))")
        
        //当 printMathResult(_:_:_:) 被调用时，它被传入 addTwoInts 函数和整数 3 和 5。它用传入 3 和 5 调用 addTwoInts，并输出结果：8。
        printMathResult(addTwoInts, 3, 5)// 打印“Result: 8”
    
        
        var currentValue = 3
        let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
        // moveNearerToZero 现在指向 stepBackward() 函数。
        
        
        print("Counting to zero:")
        // Counting to zero:
        while currentValue != 0 {
            print("\(currentValue)... ")
            currentValue = moveNearerToZero(currentValue)
        }
        print("zero!")
        // 3...
        // 2...
        // 1...
        // zero!
        
        /**嵌套函数*/
        func chooseStepFunction(backward: Bool) -> (Int) -> Int {
            func stepForward(input: Int) -> Int { return input + 1 }
            func stepBackward(input: Int) -> Int { return input - 1 }
            return backward ? stepBackward : stepForward
        }
        var currentValue2 = -4
        let moveNearerToZero2 = chooseStepFunction(backward: currentValue2 > 0)
        // moveNearerToZero now refers to the nested stepForward() function
        while currentValue2 != 0 {
            print("\(currentValue2)... ")
            currentValue2 = moveNearerToZero2(currentValue2)
        }
        print("zero!")
        // -4...
        // -3...
        // -2...
        // -1...
        // zero!
    }
}

/**函数的定义与调用*/
func greetf(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

//为了简化这个函数的定义，可以将问候消息的创建和返回写成一句
func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}

/**多参数函数*/
func greetf(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greetf(person: person)
    }
}

/**无返回值函数*/
/**严格地说，即使没有明确定义返回值，该 greet(Person：) 函数仍然返回一个值。没有明确定义返回类型的函数的返回一个 Void 类型特殊值，该值为一个空元组，写成 ()*/
//这个函数直接打印一个 String 值，而不是返回它：
func greet(person: String) {
    print("Hello, \(person)!")
}

func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}

/**多重返回值函数*/
//minMax(array:) 函数返回一个包含两个 Int 值的元组，这些值被标记为 min 和 max ，以便查询函数的返回值时可以通过名字访问它们
func minMax(array: [Int]) -> (min: Int, max :Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

/**可选元组返回类型*/
//如果函数返回的元组类型有可能整个元组都“没有值”，你可以使用可选的 元组返回类型反映整个元组可以是 nil 的事实。你可以通过在元组类型的右括号后放置一个问号来定义一个可选元组，例如 (Int, Int)? 或 (String, Int, Bool)?
func minMaxOptional(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

/**隐式返回的函数*/
//greeting(for:) 函数的完整定义是打招呼内容的返回，这就意味着它能使用隐式返回这样更简短的形式。anothergreeting(for:) 函数返回同样的内容，却因为 return 关键字显得函数更长。任何一个可以被写成一行 return 语句的函数都可以忽略 return。
func greeting(for person: String) -> String {
    "Hello, " + person + "!"
}

/**函数参数标签和参数名称*/
/**每个函数参数都有一个参数标签（argument label）以及一个参数名称（parameter name）。参数标签在调用函数的时候使用；调用的时候需要将函数的参数标签写在对应的参数前面。参数名称在函数的实现中使用。默认情况下，函数参数使用参数名称来作为它们的参数标签。*/
func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
}

/**指定参数标签*/
//你可以在参数名称前指定它的参数标签，中间以空格分隔
func someFunction(argumentLabel parameterName: Int) {
    // 在函数体内，parameterName 代表参数值
}

//这个版本的 greet(person:) 函数，接收一个人的名字和他的家乡，并且返回一句问候：
func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
//参数标签的使用能够让一个函数在调用时更有表达力，更类似自然语言，并且仍保持了函数内部的可读性以及清晰的意图。

/**忽略参数标签*/
//如果你不希望为某个参数添加一个标签，可以使用一个下划线（_）来代替一个明确的参数标签
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
     // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
}
//someFunction(1, secondParameterName: 2)

/**默认参数值*/
//你可以在函数体中通过给参数赋值来为任意一个参数定义默认值（Deafult Value）。当默认值被定义后，调用这个函数时可以忽略这个参数
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // 如果你在调用时候不传第二个参数，parameterWithDefault 会值为 12 传入到函数体中。
}
//someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault = 6
//someFunction(parameterWithoutDefault: 4) // parameterWithDefault = 12

/**可变参数*/
//可变参数的传入值在函数体中变为此类型的一个数组。例如，一个叫做 numbers 的 Double... 型可变参数，在函数体内可以当做一个叫 numbers 的 [Double] 型的数组常量。
//注意:一个函数最多只能拥有一个可变参数。
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

/**输入输出参数*/
//函数参数默认是常量。试图在函数体中更改参数值将会导致编译错误。这意味着你不能错误地更改参数值。如果你想要一个函数可以修改参数的值，并且想要在这些修改在函数调用结束后仍然存在，那么就应该把这个参数定义为输入输出参数
//定义一个输入输出参数时，在参数定义前加 inout 关键字。一个 输入输出参数有传入函数的值，这个值被函数修改，然后被传出函数，替换原来的值
//你只能传递变量给输入输出参数。你不能传入常量或者字面量，因为这些量是不能被修改的。当传入的参数作为输入输出参数时，需要在参数名前加 & 符，表示这个值可以被函数修改
//注意：输入输出参数不能有默认值，而且可变参数不能用 inout 标记
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
//var someInt = 3
//var anotherInt = 107
//swapTwoInts(&someInt, &anotherInt)
//print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// 打印“someInt is now 107, and anotherInt is now 3”

/**函数类型*/
//每个函数都有种特定的函数类型，函数的类型由函数的参数类型和返回类型组成。
//这两个函数的类型是 (Int, Int) -> Int，可以解读为:
//这个函数类型有两个 Int 型的参数并返回一个 Int 型的值”
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
//下面是另一个例子，一个没有参数，也没有返回值的函数
//这个函数的类型是：() -> Void，或者叫“没有参数，并返回 Void 类型的函数”。
func printHelloWorld() {
    print("hello, world")
}

//使用函数类型
//在 Swift 中，使用函数类型就像使用其他类型一样。例如，你可以定义一个类型为函数的常量或变量，并将适当的函数赋值给它：

//定义一个叫做 mathFunction 的变量，类型是‘一个有两个 Int 型的参数并返回一个 Int 型的值的函数’，并让这个新变量指向 addTwoInts 函数”。
//var mathFunction: (Int, Int) -> Int = addTwoInts
//现在，你可以用 mathFunction 来调用被赋值的函数了：
//print("Result: \(mathFunction(2, 3))")
// Prints "Result: 5"

/**函数类型作为参数类型*/
//你可以用 (Int, Int) -> Int 这样的函数类型作为另一个函数的参数类型。这样你可以将函数的一部分实现留给函数的调用者来提供。
//这个例子定义了 printMathResult(_:_:_:) 函数，它有三个参数：第一个参数叫 mathFunction，类型是 (Int, Int) -> Int，你可以传入任何这种类型的函数；第二个和第三个参数叫 a 和 b，它们的类型都是 Int，这两个值作为已给出的函数的输入值。
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}

/**函数类型作为返回类型*/
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}
//如下名为 chooseStepFunction(backward:) 的函数，它的返回类型是 (Int) -> Int 类型的函数。chooseStepFunction(backward:) 根据布尔值 backwards 来返回 stepForward(_:) 函数或 stepBackward(_:) 函数：
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

//var currentValue = 3
//let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero 现在指向 stepBackward() 函数。


/**嵌套函数*/
/**
 目前为止本章中你所见到的所有函数都叫全局函数（global functions），它们定义在全局域中。你也可以把函数定义在别的函数体中，称作 嵌套函数（nested functions）。
 默认情况下，嵌套函数是对外界不可见的，但是可以被它们的外围函数（enclosing function）调用。一个外围函数也可以返回它的某一个嵌套函数，使得这个函数可以在其他域中被使用。
 */
