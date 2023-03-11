//
//  Closure.swift
//  Swift语法
//
//  Created by caowei on 2020/6/4.
//  Copyright © 2020 caowei. All rights reserved.
//
/**
 闭包⚠️❓
 */
/**
 闭包是自包含的函数代码块，可以在代码中被传递和使用。Swift 中的闭包与 C 和 Objective-C 中的代码块（blocks）以及其他一些编程语言中的匿名函数（Lambdas）比较相似。
 
 闭包可以捕获和存储其所在上下文中任意常量和变量的引用。被称为包裹常量和变量。 Swift 会为你管理在捕获过程中涉及到的所有内存操作。
 
 其他参考资料：https://zhuanlan.zhihu.com/p/92464947
 https://www.cnswift.org/closures
 */
import UIKit

class Closure: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**排序方法*/
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        func backword(_ s1: String, _ s2: String) -> Bool {
            return s1 > s2
        }
        var reversedNames = names.sorted(by: backword)//["Ewa", "Daniella", "Chris", "Barry", "Alex"]
        print(reversedNames)

        /**
        闭包表达式语法
        { (parameters) -> return type in
            statements
        }
        */
        /**
         需要注意的是内联闭包参数和返回值类型声明与 backward(_:_:) 函数类型声明相同。在这两种方式中，都写成了 (s1: String, s2: String) -> Bool。然而在内联闭包表达式中，函数和返回值类型都写在大括号内，而不是大括号外。
         */
        /**
         闭包的函数体部分由关键字 in 引入。该关键字表示闭包的参数和返回值类型定义已经完成，闭包函数体即将开始。
         */
        var reverdedNames2 = names.sorted(by: { (s1: String, s2: String) -> Bool in
            return s1 > s2
        })
        //由于这个闭包的函数体部分如此短，以至于可以将其改写成一行代码：
        //该例中 sorted(by:) 方法的整体调用保持不变，一对圆括号仍然包裹住了方法的整个参数。然而，参数现在变成了内联闭包
        var reverdedNames3 = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 })
        
        /**根据上下文推断类型*/

        /**
         因为排序闭包函数是作为 sorted(by:) 方法的参数传入的，Swift 可以推断其参数和返回值的类型。sorted(by:) 方法被一个字符串数组调用，因此其参数必须是 (String, String) -> Bool 类型的函数。这意味着 (String, String) 和 Bool 类型并不需要作为闭包表达式定义的一部分。因为所有的类型都可以被正确推断，返回箭头（->）和围绕在参数周围的括号也可以被省略：
         */
        var reverdedNames4 = names.sorted(by: { s1, s2 in return s1 > s2} )
        /**
         实际上，通过内联闭包表达式构造的闭包作为参数传递给函数或方法时，总是能够推断出闭包的参数和返回值类型。这意味着闭包作为函数或者方法的参数时，你几乎不需要利用完整格式构造内联闭包。
         尽管如此，你仍然可以明确写出有着完整格式的闭包。如果完整格式的闭包能够提高代码的可读性，则我们更鼓励采用完整格式的闭包。而在 sorted(by:) 方法这个例子里，显然闭包的目的就是排序。由于这个闭包是为了处理字符串数组的排序，因此读者能够推测出这个闭包是用于字符串处理的。
         */
 
        /**单表达式闭包的隐式返回*/
        //单行表达式闭包可以通过省略 return 关键字来隐式返回单行表达式的结果，如上版本的例子可以改写为
        var reverdedNames5 = names.sorted(by: { s1, s2 in s1 > s2} )

        /**参数名称缩写*/
        /**Swift 自动为内联闭包提供了参数名称缩写功能，你可以直接通过 $0，$1，$2 来顺序调用闭包的参数，以此类推。*/
        /**如果你在闭包表达式中使用参数名称缩写，你可以在闭包定义中省略参数列表，并且对应参数名称缩写的类型会通过函数类型进行推断。in 关键字也同样可以被省略，因为此时闭包表达式完全由闭包函数体构成*/
        var reverdedNames6 = names.sorted(by: { $0 > $1 } )
        
        /**运算符方法*/
        /**实际上还有一种更简短的方式来编写上面例子中的闭包表达式。Swift 的 String 类型定义了关于大于号（>）的字符串实现，其作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值。而这正好与 sorted(by:) 方法的参数需要的函数类型相符合。因此，你可以简单地传递一个大于号，Swift 可以自动推断找到系统自带的那个字符串函数的实现*/

        /**尾随闭包❓*/
        /**如果你需要将一个很长的闭包表达式作为最后一个参数传递给函数，将这个闭包替换成为尾随闭包的形式很有用。尾随闭包是一个书写在函数圆括号之后的闭包表达式，函数支持将其作为最后一个参数调用。在使用尾随闭包时，你不用写出它的参数标签*/
        //参数列表只有一个参数，它是一个闭包，闭包的类型为 () -> Void,这个闭包没有任何参数，也没有返回值，它只是执行一些操作
        func someFunctionThatTakesAClosure(closure: () -> Void) {
            // 函数体部分
        }


        // 以下是不使用尾随闭包进行函数调用
        someFunctionThatTakesAClosure(closure: {
            // 闭包主体部分
        })

        // 以下是使用尾随闭包进行函数调用
        someFunctionThatTakesAClosure() {
            // 闭包主体部分
        }
        
        //上章节中的字符串排序闭包可以作为尾随包的形式改写在 sorted(by:) 方法圆括号的外面：
        var reverdedNames7 = names.sorted() { $0 > $1 }
        //如果闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，你甚至可以把 () 省略掉
        var reverdedNames8 = names.sorted { $0 > $1 }

        /**
         当闭包非常长以至于不能在一行中进行书写时，尾随闭包变得非常有用。举例来说，Swift 的 Array 类型有一个 map(_:) 方法，这个方法获取一个闭包表达式作为其唯一参数。该闭包函数会为数组中的每一个元素调用一次，并返回该元素所映射的值。具体的映射方式和返回值类型由闭包来指定。
         当提供给数组的闭包应用于每个数组元素后，map(_:) 方法将返回一个新的数组，数组中包含了与原数组中的元素一一对应的映射后的值。
         */
        //下例介绍了如何在 map(_:) 方法中使用尾随闭包将 Int 类型数组 [16, 58, 510] 转换为包含对应 String 类型的值的数组 ["OneSix", "FiveEight", "FiveOneZero"]
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
        //map(_:) 为数组中每一个元素调用了一次闭包表达式。你不需要指定闭包的输入参数 number 的类型，因为可以通过要映射的数组类型进行推断
        //在该例中，局部变量 number 的值由闭包中的 number 参数获得，因此可以在闭包函数体内对其进行修改，(闭包或者函数的参数总是常量)，闭包表达式指定了返回类型为 String，以表明存储映射值的新数组类型为 String。
        let strings = numbers.map{
            (number) -> String in
            var number = number
            var output = ""
            repeat {
                output = digitNames[number % 10]! + output
                number /= 10
            } while number > 0
            return output
        }
        
        /**值捕获*/
        /**闭包可以在其被定义的上下文中捕获常量或变量。即使定义这些常量和变量的原作用域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值。⚠️*/
        /**Swift 中，可以捕获值的闭包的最简单形式是嵌套函数，也就是定义在其他函数的函数体内的函数。嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量*/
        //makeIncrementer 返回类型为 () -> Int,这意味着其返回的是一个函数
        //makeIncrementer(forIncrement:) 有一个 Int 类型的参数，其外部参数名为 forIncrement，内部参数名为 amount
        func makeIncrementer(forIncrement amount: Int) -> () -> Int {
            var runningTotal = 0
            func incrementer() -> Int {
                runningTotal += amount
                return runningTotal
            }
            return incrementer
        }
        let incrementByTen = makeIncrementer(forIncrement: 10)
        //注意：这里每次调用runningTotal的值都会增加⚠️
        incrementByTen()// 返回的值为10
        incrementByTen()// 返回的值为20
        incrementByTen()// 返回的值为30
     
        //如果你创建了另一个 incrementer，它会有属于自己的引用，指向一个全新、独立的 runningTotal 变量：
        //注意：由于重新runningTotal ，runningTotal重新开始
        let incrementBySeven = makeIncrementer(forIncrement: 7)
        incrementBySeven()// 返回的值为7
        //再次调用原来的 incrementByTen 会继续增加它自己的 runningTotal 变量，该变量和 incrementBySeven 中捕获的变量没有任何联系：
        incrementByTen()// 返回的值为40
        
        
        /**闭包是引用类型(地址传递)*/
        /**上面的例子中，incrementBySeven 和 incrementByTen 都是常量，但是这些常量指向的闭包仍然可以增加其捕获的变量的值。这是因为函数和闭包都是引用类型。
         无论你将函数或闭包赋值给一个常量还是变量，你实际上都是将常量或变量的值设置为对应函数或闭包的引用。上面的例子中，指向闭包的引用 incrementByTen 是一个常量，而并非闭包内容本身*/
        /**这也意味着如果你将闭包赋值给了两个不同的常量或变量，两个值都会指向同一个闭包*/
        let alsoIncrementByTen = incrementByTen
        alsoIncrementByTen()
        // 返回的值为50

        
        /**逃逸闭包*/
        //在 doSomething 方法返回后，我们首先打印了 instance.x 的值，这将输出 200，因为第二个闭包直接修改了 x 的值。
        let instance = SomeClass()
        instance.doSomething()
        print(instance.x)// 打印出“200”

        //来看 completionHandlers.first?() 这行代码。它从 completionHandlers 数组中获取第一个元素，即之前添加到该数组中的逃逸闭包，然后调用它。由于闭包中的语句 self.x = 100，所以这将再次将 SomeClass 实例的属性 x 设置为 100。
        completionHandlers.first?()//数组第一个元素
        print(instance.x) // 打印出“100”❓
        
        
        /**自动闭包*/
        /**自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。这种便利语法让你能够省略闭包的花括号，用一个普通的表达式来代替显式的闭包。*/
        /**自动闭包让你能够延迟求值，因为直到你调用这个闭包，代码段才会被执行。延迟求值对于那些有副作用（Side Effect）和高计算成本的代码来说是很有益处的，因为它使得你能控制代码的执行时机。下面的代码展示了闭包如何延时求值*/
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(customersInLine.count)// 打印出“5”
        /**尽管在闭包的代码中，customersInLine 的第一个元素被移除了，不过在闭包被调用之前，这个元素是不会被移除的。如果这个闭包永远不被调用，那么在闭包里面的表达式将永远不会执行，那意味着列表中的元素永远不会被移除。请注意，customerProvider 的类型不是 String，而是 () -> String，一个没有参数且返回值为 String 的函数⚠️*/
        let customerProvider = { customersInLine.remove(at: 0) }
        print(customersInLine.count)// 打印出“5”

        print("Now serving \(customerProvider())!")// Prints "Now serving Chris!"
        
        print(customersInLine.count)// 打印出“4”
        
        //将闭包作为参数传递给函数时，你能获得同样的延时求值行为
        func serve(customer customerProvider: () -> String) {
            print("Now serving \(customerProvider())!")
        }
        serve(customer: { customersInLine.remove(at: 0) } )// 打印出“Now serving Alex!”
        
        /**上面的 serve(customer:) 函数接受一个返回顾客名字的显式的闭包。下面这个版本的 serve(customer:) 完成了相同的操作，不过它并没有接受一个显式的闭包，而是通过将参数标记为 @autoclosure 来接收一个自动闭包。现在你可以将该函数当作接受 String 类型参数（而非闭包）的函数来调用。customerProvider 参数将自动转化为一个闭包，因为该参数被标记了 @autoclosure 特性。⚠️*/
        // customersInLine is ["Ewa", "Barry", "Daniella"]
        func serve2(customer customerProvider: @autoclosure () -> String) {
            print("Now serving \(customerProvider())!")
        }
        serve2(customer: customersInLine.remove(at: 0))// 打印“Now serving Ewa!”
        /**注意：过度使用 autoclosures 会让你的代码变得难以理解。上下文和函数名应该能够清晰地表明求值是被延迟执行的。*/
        
        /**如果你想让一个自动闭包可以“逃逸”，则应该同时使用 @autoclosure 和 @escaping 属性。*/
        /**collectCustomerProviders(_:) 函数并没有调用传入的 customerProvider 闭包，而是将闭包追加到了 customerProviders 数组中。这个数组定义在函数作用域范围外，这意味着数组内的闭包能够在函数返回之后被调用。因此，customerProvider 参数必须允许“逃逸”出函数作用域。*/
        // customersInLine i= ["Barry", "Daniella"]
        var customerProviders: [() -> String] = []
        func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
            customerProviders.append(customerProvider)
        }
        collectCustomerProviders(customersInLine.remove(at: 0))
        collectCustomerProviders(customersInLine.remove(at: 0))

        print("Collected \(customerProviders.count) closures.")
        // 打印“Collected 2 closures.”
        for customerProvider in customerProviders {
            print("Now serving \(customerProvider())!")
        }
        // 打印“Now serving Barry!”
        // 打印“Now serving Daniella!”
    }
}

/**
 排序方法
 */
/**
 Swift 标准库提供了名为 sorted(by:) 的方法，它会基于你提供的排序闭包表达式的判断结果对数组中的值（类型确定）进行排序。一旦它完成排序过程，sorted(by:) 方法会返回一个与旧数组类型大小相同类型的新数组，该数组的元素有着正确的排序顺序。原数组不会被 sorted(by:) 方法修改。
 */


/**
 闭包表达式语法
 { (parameters) -> return type in
     statements
 }
 */

/**逃逸闭包*/
/**当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。当你定义接受闭包作为参数的函数时，你可以在参数名之前标注 @escaping，用来指明这个闭包是允许“逃逸”出这个函数的。*/
/**一种能使闭包“逃逸”出函数的方法是，将这个闭包保存在一个函数外部定义的变量中。举个例子，很多启动异步操作的函数接受一个闭包参数作为 completion handler。这类函数会在异步操作开始之后立刻返回，但是闭包直到异步操作结束后才会被调用。在这种情况下，闭包需要“逃逸”出函数，因为闭包需要在函数返回之后被调用。例如：*/
//这段代码定义了一个数组 completionHandlers，它的元素类型是无参数、无返回值的闭包(() -> Void)。
var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

/**将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self。比如说，在下面的代码中，传递到 someFunctionWithEscapingClosure(_:) 中的闭包是一个逃逸闭包，这意味着它需要显式地引用 self。相对的，传递到 someFunctionWithNonescapingClosure(_:) 中的闭包是一个非逃逸闭包，这意味着它可以隐式引用 self*/
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

/**
 // 定义一个无参数、无返回值的闭包
 let myClosure = {
     print("这是一个无参数、无返回值的闭包")
 }

 // 调用闭包
 myClosure()
 */
