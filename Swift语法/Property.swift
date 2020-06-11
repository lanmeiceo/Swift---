//
//  Property.swift
//  Swift语法
//
//  Created by caowei on 2020/6/4.
//  Copyright © 2020 caowei. All rights reserved.
//
/**
 属性
 */
import UIKit

class Property: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         存储属性
         */
        /**
         简单来说，一个存储属性就是存储在特定类或结构体实例里的一个常量或变量。存储属性可以是变量存储属性（用关键字 var 定义），也可以是常量存储属性（用关键字 let 定义）。
         */
        struct FixedLengthRange {
            var firstValue: Int //var,所以起始值可修改
            let length: Int //注意是let，长度无法修改
        }
        var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)// 该区间表示整数 0，1，2
        rangeOfThreeItems.firstValue = 6// 该区间现在表示整数 6，7，8
        /**FixedLengthRange 的实例包含一个名为 firstValue 的变量存储属性和一个名为 length 的常量存储属性。在上面的例子中，length 在创建实例的时候被初始化，且之后无法修改它的值，因为它是一个常量存储属性。*/
        
        /**常量结构体实例的存储属性*/
        //如果创建了一个结构体实例并将其赋值给一个常量，则无法修改该实例的任何属性，即使被声明为可变属性也不行:
        let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)// 该区间表示整数 0，1，2，3
//        rangeOfFourItems.firstValue = 6 //尽管 firstValue 是个可变属性，但这里还是会报错，因为rangeOfFourItems是常量
        
        /**延时加载存储属性*/
        /**
          延时加载存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来标示一个延时加载存储属性。
        */
        //注意：必须将延时加载属性声明成变量（使用 var 关键字），因为属性的初始值可能在实例构造完成之后才会得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延时加载。
        
        let manager = DataManager()
        manager.data.append("Some data")
        manager.data.append("Some more data")

        print(manager.importer.fileName)// DataImporter 实例的 importer 属性现在被创建了
        // 输出“data.txt”
        
        /**注意：如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次。*/
        
        /**存储属性和实例变量*/
        /**
         如果您有过 Objective-C 经验，应该知道 Objective-C 为类实例存储值和引用提供两种方法。除了属性之外，还可以使用实例变量作为一个备份存储将变量值赋值给属性。
         Swift 编程语言中把这些理论统一用属性来实现。Swift 中的属性没有对应的实例变量，属性的备份存储也无法直接访问。这就避免了不同场景下访问方式的困扰，同时也将属性的定义简化成一个语句。属性的全部信息——包括命名、类型和内存管理特征——作为类型定义的一部分，都定义在一个地方。
         */
        
        /**计算属性*/
        //除存储属性外，类、结构体和枚举可以定义计算属性。计算属性不直接存储值，而是提供一个 getter 和一个可选的 setter，来间接获取和设置其他属性或变量的值
        struct Point {
            var x = 0.0, y = 0.0
        }
        struct Size {
            var width = 0.0, height = 0.0
        }
        struct Rect {
            var origin = Point()
            var size = Size()
            var center: Point {
                get {
                    let centerX = origin.x + (size.width / 2)
                    let centerY = origin.y + (size.height / 2)
                    return Point(x: centerX, y: centerY)
                }

                set(newCenter) {
                    origin.x = newCenter.x - (size.width / 2)
                    origin.y = newCenter.y - (size.height / 2)
                }
            }
        }
        
        var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0));
        let initialSquareCenter = square.center
        square.center = Point(x: 15.0, y: 15.0)
        print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
        // 打印“square.origin is now at (10.0, 10.0)”
        
        /**简化 Setter 声明*/
        //如果计算属性的 setter 没有定义表示新值的参数名，则可以使用默认名称 newValue。
        //下面是使用了简化 setter 声明的 Rect 结构体代码
        /**简化 Getter 声明*/
        //如果整个 getter 是单一表达式，getter 会隐式地返回这个表达式结果。
        //下面是另一个版本的 Rect 结构体，用到了简化的 getter 和 setter 声明：
        struct AlternativeRect {
            var origin = Point()
            var size = Size()
            var center: Point {
                get {
                    Point(x: origin.x + (size.width / 2),
                    y: origin.y + (size.height / 2))
                }
                set {
                    origin.x = newValue.x - (size.width / 2)
                    origin.y = newValue.y - (size.height / 2)
                }
            }
        }
        
        /**只读计算属性*/
        //只有 getter 没有 setter 的计算属性叫只读计算属性。只读计算属性总是返回一个值，可以通过点运算符访问，但不能设置新的值
        //注意：必须使用 var 关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。let 关键字只用来声明常量属性，表示初始化后再也无法修改的值。
        struct Cuboid {
            var width = 0.0, height = 0.0, depth = 0.0
            var volume: Double {
                return width * height * depth
            }
        }
        let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
        print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
        // 打印“the volume of fourByFiveByTwo is 40.0”
        
        
        /**属性观察器*/
        //属性观察器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器，即使新值和当前值相同的时候也不例外。
        //你可以为除了延时加载存储属性之外的其他存储属性添加属性观察器，你也可以在子类中通过重写属性的方式为继承的属性（包括存储属性和计算属性）添加属性观察器。你不必为非重写的计算属性添加属性观察器，因为你可以直接通过它的 setter 监控和响应值的变化
        /**
         可以为属性添加其中一个或两个观察器：
         willSet 在新的值被设置之前调用
         didSet 在新的值被设置之后调用
         willSet 观察器会将新的属性值作为常量参数传入，在 willSet 的实现代码中可以为这个参数指定一个名称，如果不指定则参数仍然可用，这时使用默认名称 newValue 表示
         同样，didSet 观察器会将旧的属性值作为参数传入，可以为该参数指定一个名称或者使用默认参数名 oldValue。如果在 didSet 方法中再次对该属性赋值，那么新值会覆盖旧的值。
         */
        /**
         注意：在父类初始化方法调用之后，在子类构造器中给父类的属性赋值时，会调用父类属性的 willSet 和 didSet 观察器。而在父类初始化方法调用之前，给子类的属性赋值时不会调用子类属性的观察器
         */
        struct StepCounter {
            var totalSteps: Int = 0 {
                willSet(newTotalSteps) {
                     print("将 totalSteps 的值设置为 \(newTotalSteps)")
                }
                
                didSet {
                    if totalSteps > oldValue  {
                        print("增加了 \(totalSteps - oldValue) 步")
                    }
                }
            }
            
        }
        var stepCounter = StepCounter()
        stepCounter.totalSteps = 200
        // 将 totalSteps 的值设置为 200
        // 增加了 200 步
        stepCounter.totalSteps = 360
        // 将 totalSteps 的值设置为 360
        // 增加了 160 步
        stepCounter.totalSteps = 896
        // 将 totalSteps 的值设置为 896
        // 增加了 536 步
        /**
         注意：如果将带有观察器的属性通过 in-out 方式传入函数，willSet 和 didSet 也会调用。这是因为 in-out 参数采用了拷入拷出内存模式：即在函数内部使用的是参数的 copy，函数结束后，又对参数重新赋值
         */
        
        /**
         属性包装器
         */
        /**
         属性包装器在管理属性如何存储和定义属性的代码之间添加了一个分隔层。举例来说，如果你的属性需要线程安全性检查或者需要在数据库中存储它们的基本数据，那么必须给每个属性添加同样的逻辑代码。当使用属性包装器时，你只需在定义属性包装器时编写一次管理代码，然后应用到多个属性上来进行复用
         */
        @propertyWrapper
        struct TwelveOrLess {
            private var number: Int//以 private 的方式声明 number 变量，这使得 number 仅在 TwelveOrLess 的实现中使用。
            init() { self.number = 0 }
            var wrappedValue: Int {
                get { return number }
                set { number = min(newValue, 12) }
            }
        }
        //通过在属性之前写上包装器名称作为特性的方式，你可以把一个包装器应用到一个属性上去。这里有个存储小矩形的结构体。通过 TwelveOrLess 属性包装器实现类似（挺随意的）对“小”的定义
        struct SmallRectangle {
            @TwelveOrLess var height: Int
            @TwelveOrLess var width: Int
        }
        var rectangle = SmallRectangle()
        print(rectangle.height)// 打印 "0"
        rectangle.height = 10
        print(rectangle.height)// 打印 "10"
        rectangle.height = 24
        print(rectangle.height)// 打印 "12"
        
        /**
         当你把一个包装器应用到一个属性上时，编译器将合成提供包装器存储空间和通过包装器访问属性的代码。（属性包装器只负责存储被包装值，所以没有合成这些代码。）不利用这个特性语法的情况下，你可以写出使用属性包装器行为的代码。举例来说，这是先前代码清单中的 SmallRectangle 的另一个版本。这个版本将其属性明确地包装在 TwelveOrLess 结构体中，而不是把 @TwelveOrLess 作为特性写下来：
         */
        struct SmallRectangle2 {
            //_height 和 _width 属性存着这个属性包装器的一个实例，即 TwelveOrLess。height 和 width 的 getter 和 setter 把对 wrappedValue 属性的访问包装起来。
            private var _height = TwelveOrLess()
            private var _width = TwelveOrLess()
            var height: Int {
                get { return _height.wrappedValue }
                set { _height.wrappedValue = newValue }
            }
            var width: Int {
                get { return _width.wrappedValue }
                set { _width.wrappedValue = newValue }
            }
        }
        
        /**设置被包装属性的初始值*/
        /**
         上面例子中的代码通过在 TwelveOrLess 的定义中赋予 number 一个初始值来设置被包装属性的初始值。使用这个属性包装器的代码没法为被 TwelveOrLess 包装的属性指定其他初始值。举例来说，SmallRectangle 的定义没法给 height 或者 width 一个初始值。为了支持设定一个初始值或者其他自定义操作，属性包装器需要添加一个构造器。这是 TwelveOrLess 的扩展版本，称为 SmallNumber。SmallNumber 定义了能设置被包装值和最大值的构造器
         */
        @propertyWrapper
        struct SmallNumber {
            private var maximum: Int
            private var number: Int

            var wrappedValue: Int {
                get { return number }
                set { number = min(newValue, maximum) }
            }

            init() {
                maximum = 12
                number = 0
            }
            
            init(wrappedValue: Int) {
                maximum = 12
                number = min(wrappedValue, maximum)
            }
            
            init(wrappedValue: Int, maximum: Int) {
                self.maximum = maximum
                number = min(wrappedValue, maximum)
            }
        }
        
        
        //SmallNumber 的定义包括三个构造器——init()、init(wrappedValue:) 和 init(wrappedValue:maximum:)——下面的示例使用这三个构造器来设置被包装值和最大值
        struct ZeroRectangle {
            @SmallNumber var height: Int
            @SmallNumber var width: Int
        }
        let zeroRectangle = ZeroRectangle()
        print(zeroRectangle.height, zeroRectangle.width)// 打印 "0 0"

        //当你为属性指定初始值时，Swift 使用 init(wrappedValue:) 构造器来设置包装器。举个例子
        struct UnitRectangle {
            @SmallNumber var height: Int = 1
            @SmallNumber var width: Int = 1
        }
        let unitRectangle = UnitRectangle()
        print(unitRectangle.height, unitRectangle.width)// 打印 "1 1"
        /**
         当你对一个被包装的属性写下 = 1 时，这被转换为调用 init(wrappedValue:) 构造器。调用 SmallNumber(wrappedValue: 1)来创建包装 height 和 width 的 SmallNumber 的实例。构造器使用此处指定的被包装值，且使用的默认最大值为 12
         */
        
        //当你在自定义特性后面把实参写在括号里时，Swift 使用接受这些实参的构造器来设置包装器。举例来说，如果你提供初始值和最大值，Swift 使用 init(wrappedValue:maximum:) 构造器
        struct NarrowRectangle {
            @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
            @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
        }
        let narrowRectangle = NarrowRectangle()
        print(narrowRectangle.height, narrowRectangle.width)// 打印 "2 3"
        /**通过将实参包含到属性包装器中，你可以设置包装器的初始状态，或者在创建包装器时传递其他的选项。这种语法是使用属性包装器最通用的方法。你可以为这个属性提供任何所需的实参，且它们将被传递给构造器。*/
        
        //当包含属性包装器实参时，你也可以使用赋值来指定初始值。Swift 将赋值视为 wrappedValue 参数，且使用接受被包含的实参的构造器。举个例子
        struct MixedRectangle {
            @SmallNumber var height: Int = 1
            @SmallNumber(maximum: 9) var width: Int = 2//调用 SmallNumber(wrappedValue: 2, maximum: 9)
        }
        var mixedRectangle = MixedRectangle()
        print(mixedRectangle.height)// 打印 "1"
        mixedRectangle.height = 20
        print(mixedRectangle.height) // 打印 "12"
        //调用 SmallNumber(wrappedValue: 1) 来创建包装 height 的 SmallNumber 的一个实例，这个实例使用默认最大值 12。调用 SmallNumber(wrappedValue: 2, maximum: 9) 来创建包装 width 的 SmallNumber 的一个实例
        
        /**从属性包装器中呈现一个值*/
        /**
         除了被包装值，属性包装器可以通过定义被呈现值暴露出其他功能。举个例子，管理对数据库的访问的属性包装器可以在它的被呈现值上暴露出 flushDatabaseConnection() 方法。除了以货币符号（$）开头，被呈现值的名称和被包装值是一样的。因为你的代码不能够定义以 $ 开头的属性，所以被呈现值永远不会与你定义的属性有冲突。
         在之前 SmallNumber 的例子中，如果你尝试把这个属性设置为一个很大的数值，属性包装器会在存储这个数值之前调整这个数值。以下的代码把被呈现值添加到 SmallNumber 结构体中来追踪在存储新值之前属性包装器是否为这个属性调整了新值。
         */
        @propertyWrapper
        struct SmallNumber2 {
            private var number: Int
            var projectedValue: Bool
            init() {
                self.number = 0
                self.projectedValue = false
            }
            var wrappedValue: Int {
                get { return number }
                set {
                    if newValue > 12 {
                        number = 12
                        projectedValue = true
                    } else {
                        number = newValue
                        projectedValue = false
                    }
                }
            }
        }
        struct SomeStructure2 {
            @SmallNumber2 var someNumber: Int
        }
        var someStructure = SomeStructure2()
        someStructure.someNumber = 4
        print(someStructure.$someNumber)// 打印 "false"
        someStructure.someNumber = 55
        print(someStructure.$someNumber)// 打印 "true"
        //写下 someStructure.$someNumber 即可访问包装器的被呈现值。在存储一个比较小的数值时，如 4 ，someStructure.$someNumber 的值为 false。但是，在尝试存储一个较大的数值时，如 55 ，被呈现值变为 true。
        //属性包装器可以返回任何类型的值作为它的被呈现值。在这个例子里，属性包装器要暴露的信息是：那个数值是否被调整过，所以它暴露出布尔型值来作为它的被呈现值。需要暴露出更多信息的包装器可以返回其他数据类型的实例，或者可以返回自身来暴露出包装器的实例，并把其作为它的被呈现值。
        //当从类型的一部分代码中访问被呈现值，例如属性 getter 或实例方法，你可以在属性名称之前省略 self.，就像访问其他属性一样。以下示例中的代码用 $height 和 $width 引用包装器 height 和 width 的被呈现值
        enum Size2 {
            case small, large
        }

        struct SizedRectangle {
            @SmallNumber2 var height: Int
            @SmallNumber2 var width: Int

            mutating func resize(to size: Size2) -> Bool {
                switch size {
                case .small:
                    height = 10
                    width = 20
                case .large:
                    height = 100
                    width = 100
                }
                return $height || $width
            }
        }
        var siz = SizedRectangle()
        print(siz.resize(to: Size2.large))//true
        /**
         因为属性包装器语法只是具有 getter 和 setter 的属性的语法糖，所以访问 height 和 width 的行为与访问任何其他属性的行为相同。举个例子，resize(to:) 中的代码使用它们的属性包装器来访问 height 和 width。如果调用 resize(to: .large)，.large 的 switch case 分支语句把矩形的高度和宽度设置为 100。属性包装器防止这些属性的值大于 12，且把被呈现值设置成为 true 来记下它调整过这些值的事实。在 resize(to:) 的最后，返回语句检查 $height 和 $width 来确认是否属性包装器调整过 height 或 width
         */

        
        /**
         类型属性
         */
        /**
         实例属性属于一个特定类型的实例，每创建一个实例，实例都拥有属于自己的一套属性值，实例之间的属性相互独立。
         你也可以为类型本身定义属性，无论创建了多少个该类型的实例，这些属性都只有唯一一份。这种属性就是类型属性。
         类型属性用于定义某个类型所有实例共享的数据，比如所有实例都能用的一个常量（就像 C 语言中的静态常量），或者所有实例都能访问的一个变量（就像 C 语言中的静态变量）。
         存储型类型属性可以是变量或常量，计算型类型属性跟实例的计算型属性一样只能定义成变量属性。
         */
        /**
         注意：跟实例的存储型属性不同，必须给存储型类型属性指定默认值，因为类型本身没有构造器，也就无法在初始化过程中使用构造器给类型属性赋值。
         存储型类型属性是延迟初始化的，它们只有在第一次被访问的时候才会被初始化。即使它们被多个线程同时访问，系统也保证只会对其进行一次初始化，并且不需要对其使用 lazy 修饰符
         */
        
        /**类型属性语法*/
        /**
         在 C 或 Objective-C 中，与某个类型关联的静态常量和静态变量，是作为 global（全局）静态变量定义的。但是在 Swift 中，类型属性是作为类型定义的一部分写在类型最外层的花括号内，因此它的作用范围也就在类型支持的范围内。
         使用关键字 static 来定义类型属性。在为类定义计算型类型属性时，可以改用关键字 class 来支持子类对父类的实现进行重写。下面的例子演示了存储型和计算型类型属性的语法：
         */
        struct SomeStructure {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty: Int {
                return 1
            }
        }
        enum SomeEnumeration {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty: Int {
                return 6
            }
        }
        class SomeClass {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty: Int {
                return 27
            }
        class var overrideableComputedTypeProperty: Int {
                return 107
            }

        }
        
        /**获取和设置类型属性的值*/
        /**跟实例属性一样，类型属性也是通过点运算符来访问。但是，类型属性是通过类型本身来访问，而不是通过实例*/
        print(SomeStructure.storedTypeProperty)// 打印“Some value.”
        SomeStructure.storedTypeProperty = "Another value."
        print(SomeStructure.storedTypeProperty)// 打印“Another value.”
        print(SomeEnumeration.computedTypeProperty)// 打印“6”
        print(SomeClass.computedTypeProperty)// 打印“27”
        
        /**
         AudioChannel 结构定义了 2 个存储型类型属性来实现上述功能。第一个是 thresholdLevel，表示音量的最大上限阈值，它是一个值为 10 的常量，对所有实例都可见，如果音量高于 10，则取最大上限值 10
         */
        struct AudioChannel {
            static let thresholdLevel = 10
            static var maxInputLevelForAllChannels = 0
            var currentLevel: Int = 0 {
                didSet {
                    //在第一个检查过程中，didSet 属性观察器将 currentLevel 设置成了不同的值，但这不会造成属性观察器被再次调用
                    if currentLevel > AudioChannel.thresholdLevel {
                        // 将当前音量限制在阈值之内
                        currentLevel = AudioChannel.thresholdLevel
                    }
                    if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                        // 存储当前音量作为新的最大输入音量
                        AudioChannel.maxInputLevelForAllChannels = currentLevel
                    }
                }
            }
        }
        var leftChannel = AudioChannel()
        var rightChannel = AudioChannel()
        leftChannel.currentLevel = 7
        print(leftChannel.currentLevel)// 输出“7”
        print(AudioChannel.maxInputLevelForAllChannels)// 输出“7”
        
        rightChannel.currentLevel = 11
        print(rightChannel.currentLevel)// 输出“10”
        print(AudioChannel.maxInputLevelForAllChannels)// 输出“10”
    }
}

/**
 延时加载存储属性
 */
class DataImporter {
    /*
    DataImporter 是一个负责将外部文件中的数据导入的类。
    这个类的初始化会消耗不少时间。
    */
    var fileName = "data.txt"
    // 这里会提供数据导入功能
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // 这里会提供数据管理功能
}
