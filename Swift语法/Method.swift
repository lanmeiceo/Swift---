//
//  Method.swift
//  Swift语法
//
//  Created by caowei on 2020/6/4.
//  Copyright © 2020 caowei. All rights reserved.
//
/**
方法
*/
/**
 结构体和枚举能够定义方法是 Swift 与 C/Objective-C 的主要区别之一。在 Objective-C 中，类是唯一能定义方法的类型。但在 Swift 中，你不仅能选择是否要定义一个类/结构体/枚举，还能灵活地在你创建的类型（类/结构体/枚举）上定义方法。
 */
import UIKit

class Method: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**实例方法*/
        class Counter {
            var count = 0
            func increment() {
                count += 1
            }
            // 让计数器按一个指定的整数值递增
            func increment(by amount: Int) {
                count += amount
            }
            func reset() {
                count = 0
            }
        }

        
        let counter = Counter()// 初始计数值是0
        counter.increment()// 计数值现在是1
        counter.increment(by: 5)// 计数值现在是6
        counter.reset()// 计数值现在是0
        
        //函数参数可以同时有一个局部名称（在函数体内部使用）和一个外部名称（在调用函数时使用
        
        /**self 属性*/
        //上面例子中的 increment 方法还可以这样写
        class Counter2 {
            var count = 0
            func increment2() {
                self.count += 1
            }
        }
        
        /**⚠️实际上，你不必在你的代码里面经常写 self。不论何时，只要在一个方法中使用一个已知的属性或者方法名称，如果你没有明确地写 self，Swift 假定你是指当前实例的属性或者方法。这种假定在上面的 Counter 中已经示范了：Counter 中的三个实例方法中都使用的是 count（而不是 self.count）*/
        
        /**使用这条规则的主要场景是实例方法的某个参数名称与实例的某个属性名称相同的时候。在这种情况下，参数名称享有优先权，并且在引用属性时必须使用一种更严格的方式。这时你可以使用 self 属性来区分参数名称和属性名称*/

        //下面的例子中，self 消除方法参数 x 和实例属性 x 之间的歧义⚠️
        struct Point0 {
            var x = 0.0, y = 0.0
            func isToTheRightOf(x: Double) -> Bool {
                //如果不使用 self 前缀，Swift会认为 x 的两个用法都引用了名为 x 的方法参数
                return self.x > x
            }
        }
        let somePoint0 = Point0(x: 4.0, y: 5.0)
        if somePoint0.isToTheRightOf(x: 1.0) {
            print("This point is to the right of the line where x == 1.0")
        }// 打印“This point is to the right of the line where x == 1.0”
        
        
        /**在实例方法中修改值类型*/
        /**⚠️结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改*/
        /**但是，如果你确实需要在某个特定的方法中修改结构体或者枚举的属性，你可以为这个方法选择 可变（mutating）行为，然后就可以从其方法内部改变它的属性；并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中。方法还可以给它隐含的 self 属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例。  */
        //要使用 可变方法，将关键字 mutating 放到方法的 func 关键字之前就可以了
        struct Point {
            var x = 0.0, y = 0.0
            mutating func moveBy(x deltaX: Double, y deltaY: Double) {
                x += deltaX
                y += deltaY
            }
        }
        var somePoint = Point(x: 1.0, y: 1.0)
        somePoint.moveBy(x: 2.0, y: 3.0)
        print("The point is now at (\(somePoint.x), \(somePoint.y))")
        // 打印“The point is now at (3.0, 4.0)”
        
        //注意，不能在结构体类型的常量（a constant of structure type）上调用可变方法，因为其属性不能被改变，即使属性是变量属性
//        let fixedPoint = Point(x: 3.0, y: 3.0)
//        fixedPoint.moveBy(x: 2.0, y: 3.0)
        // 这里将会报告一个错误
        
        /**在可变方法中给 self 赋值⚠️*/
        //可变方法能够赋给隐含属性 self 一个全新的实例。上面 Point 的例子可以用下面的方式改写：
        struct Point2 {
            var x = 0.0, y = 0.0
            mutating func moveBy(x deltaX: Double, y deltaY: Double) {
                self = Point2(x: x + deltaX, y: y + deltaY)
            }
        }
        
        //枚举的可变方法可以把 self 设置为同一枚举类型中不同的成员：⚠️
        enum TriStateSwitch {
            case off, low, high
            mutating func next() {
                switch self {
                case .off:
                    self = .low
                case .low:
                    self = .high
                case .high:
                    self = .off
                }
            }
        }
        var ovenLight = TriStateSwitch.low
        ovenLight.next()// ovenLight 现在等于 .high
        ovenLight.next()// ovenLight 现在等于 .off
        //上面的例子中定义了一个三态切换的枚举。每次调用 next() 方法时，开关在不同的电源状态（off, low, high）之间循环切换。
        
        
        /**⚠️类型方法(类方法)*/
        /**
         实例方法是被某个类型的实例调用的方法。你也可以定义在类型本身上调用的方法，这种方法就叫做类型方法。在方法的 func 关键字之前加上关键字 static，来指定类型方法。类还可以用关键字 class 来指定，从而允许子类重写父类该方法的实现。*/
        /**在 Objective-C 中，你只能为 Objective-C 的类类型（classes）定义类型方法（type-level methods）。在 Swift 中，你可以为所有的类、结构体和枚举定义类型方法。每一个类型方法都被它所支持的类型显式包含   */
        
        //类型方法和实例方法一样用点语法调用。但是，你是在类型上调用这个方法，而不是在实例上调用。下面是如何在 SomeClass 类上调用类型方法的例子：
        class SomeClass {
            class func someTypeMethod() {
                // 在这里实现类型方法
            }
        }
        SomeClass.someTypeMethod()

        
        //在类型方法的方法体（body）中，self 属性指向这个类型本身，而不是类型的某个实例。这意味着你可以用 self 来消除类型属性和类型方法参数之间的歧义（类似于我们在前面处理实例属性和实例方法参数时做的那样）。
        //一般来说，在类型方法的方法体中，任何未限定的方法和属性名称，可以被本类中其他的类型方法和类型属性引用。一个类型方法可以直接通过类型方法的名称调用本类中的其它类型方法，而无需在方法名称前面加上类型名称。类似地，在结构体和枚举中，也能够直接通过类型属性的名称访问本类中的类型属性，而不需要前面加上类型名称
        struct LevelTracker {
            static var highestUnlockedLevel = 1
            var currentLevel = 1

            static func unlock(_ level: Int) {
                if level > highestUnlockedLevel { highestUnlockedLevel = level }
            }

            static func isUnlocked(_ level: Int) -> Bool {
                return level <= highestUnlockedLevel
            }

            //因为允许在调用 advance(to:) 时候忽略返回值，不会产生编译警告，所以函数被标注为 @discardableResult 属性，⚠️
            @discardableResult
            mutating func advance(to level: Int) -> Bool {
                if LevelTracker.isUnlocked(level) {
                    currentLevel = level
                    return true
                } else {
                    return false
                }
            }
        }
        
        
        class Player {
            var tracker = LevelTracker()
            let playerName: String
            func complete(level: Int) {
                LevelTracker.unlock(level + 1)
                tracker.advance(to: level + 1)
            }
            init(name: String) {
                playerName = name
            }
        }
        
        var player = Player(name: "Argyrios")
        player.complete(level: 1)
        print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
        // 打印“highest unlocked level is now 2”
        
        player = Player(name: "Beto")
        if player.tracker.advance(to: 6) {
            print("player is now on level 6")
        } else {
            print("level 6 has not yet been unlocked")
        }
        // 打印“level 6 has not yet been unlocked”
        
    }
}
