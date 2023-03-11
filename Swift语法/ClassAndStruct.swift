//
//  ClassAndStruct.swift
//  Swift语法
//
//  Created by caowei on 2020/6/4.
//  Copyright © 2020 caowei. All rights reserved.
//
/**
类和结构体
*/
/**结构体和类对比*/
/**
 Swift 中结构体和类有很多共同点。两者都可以：
 定义属性用于存储值
 定义方法用于提供功能
 定义下标操作用于通过下标语法访问它们的值
 定义构造器用于设置初始值
 通过扩展以增加默认实现之外的功能
 遵循协议以提供某种标准功能

 与结构体相比，类还有如下的附加功能：
 继承允许一个类继承另一个类的特征
 类型转换允许在运行时检查和解释一个类实例的类型
 析构器允许一个类实例释放任何其所被分配的资源
 引用计数允许对一个类的多次引用
 
 类支持的附加功能是以增加复杂性为代价的。作为一般准则，优先使用结构体，因为它们更容易理解，仅在适当或必要时才使用类。实际上，这意味着你的大多数自定义数据类型都会是结构体和枚举
 */
/**
 每当你定义一个新的结构体或者类时，你都是定义了一个新的 Swift 类型。请使用 UpperCamelCase 这种方式来命名类型（如这里的 SomeClass 和 SomeStructure），以便符合标准 Swift 类型的大写命名风格（如 String，Int 和 Bool）。请使用 lowerCamelCase 这种方式来命名属性和方法（如 frameRate 和 incrementCount），以便和类型名区分
 (一句话总结：结构体和类首字母大写，方法属性首字母小写)
 */
import UIKit

class ClassAndStruct: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         结构体和类都使用构造器语法来创建新的实例。构造器语法的最简单形式是在结构体或者类的类型名称后跟随一对空括号，如 Resolution() 或 VideoMode()
         */
        let someResolution = Resolution()
        let someVideoMode = VideoMode()
        
        /**属性访问*/
        //你可以通过使用点语法访问实例的属性。其语法规则是，实例名后面紧跟属性名，两者以点号（.）分隔，不带空格
        print("The width of someResolution is \(someResolution.width)")// 打印 "The width of someResolution is 0"
        
        someVideoMode.resolution.width = 1280
        print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
        // 打印 "The width of someVideoMode is now 1280"
        
        /**
         结构体类型的成员逐一构造器
         */
        /**
         所有结构体都有一个自动生成的成员逐一构造器，用于初始化新结构体实例中成员的属性。新实例中各个属性的初始值可以通过属性的名称传递到成员逐一构造器之中
         
         与结构体不同，类实例没有默认的成员逐一构造器⚠️
         */
        let vga = Resolution(width: 640, height: 480)
        
        /**
         结构体和枚举是值类型
         */
        //值类型是这样一种类型，当它被赋值给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝。
        //在之前的章节中，你已经大量使用了值类型。实际上，Swift 中所有的基本类型：整数（integer）、浮点数（floating-point number）、布尔值（boolean）、字符串（string)、数组（array）和字典（dictionary），都是值类型，其底层也是使用结构体实现的
        /**
         注意：标准库定义的集合，例如数组，字典和字符串，都对复制进行了优化以降低性能成本。新集合不会立即复制，而是跟原集合共享同一份内存，共享同样的元素。在集合的某个副本要被修改前，才会复制它的元素。而你在代码中看起来就像是立即发生了复制
         */
        let hd = Resolution(width: 1920, height: 1080)
        //因为 Resolution 是一个结构体，所以会先创建一个现有实例的副本，然后将副本赋值给 cinema 。尽管 hd 和 cinema 有着相同的宽（width）和高（height），但是在幕后它们是两个完全不同的实例
        var cinema = hd
        
        cinema.width = 2048
        print("cinema is now  \(cinema.width) pixels wide")// 打印 "cinema is now 2048 pixels wide"
        
        //然而，初始的 hd 实例中 width 属性还是 1920
        print("hd is still \(hd.width) pixels wide")// 打印 "hd is still 1920 pixels wide"
        
        /**
         将 hd 赋值给 cinema 时，hd 中所存储的值会拷贝到新的 cinema 实例中。结果就是两个完全独立的实例包含了相同的数值。由于两者相互独立，因此将 cinema 的 width 修改为 2048 并不会影响 hd 中的 width 的值⚠️
         */
        
        
        //枚举也遵循相同的行为准则
        //swift 中struct,enum 均可以包含类方法和实例方法,swift官方是不建议在struct,enum 的普通方法里修改属性变量,但是在func 前面添加 mutating 关键字之后就可以方法内修改⚠️
        enum CompassPoint {
            case north, south, east, west
            mutating func turnNorth() {
                self = .north
            }
        }
        var currentDirection = CompassPoint.west
        let rememberedDirection = currentDirection
        currentDirection.turnNorth()

        /**
         当 rememberedDirection 被赋予了 currentDirection 的值，实际上它被赋予的是值的一个拷贝。赋值过程结束后再修改 currentDirection 的值并不影响 rememberedDirection 所储存的原始值的拷贝。
         */
        print("The current direction is \(currentDirection)")
        print("The remembered direction is \(rememberedDirection)")
        // 打印 "The current direction is north"
        // 打印 "The remembered direction is west"
        
        
        /**
         类是引用类型⚠️
         */
        //与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝。因此，使用的是已存在实例的引用，而不是其拷贝。
        let tenEighty = VideoMode()
        tenEighty.resolution = hd
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0
        
        //将 tenEighty 赋值给一个名为 alsoTenEighty 的新常量，并修改 alsoTenEighty 的帧率：
        let alsoTenEighty = tenEighty
        alsoTenEighty.frameRate = 30.0
        
        //因为类是引用类型，所以 tenEight 和 alsoTenEight 实际上引用的是同一个 VideoMode 实例。换句话说，它们是同一个实例的两种叫法
        print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")// 打印 "The frameRate property of theEighty is now 30.0"
        /**
         需要注意的是 tenEighty 和 alsoTenEighty 被声明为常量而不是变量。然而你依然可以改变 tenEighty.frameRate 和 alsoTenEighty.frameRate，这是因为 tenEighty 和 alsoTenEighty 这两个常量的值并未改变。它们并不“存储”这个 VideoMode 实例，而仅仅是对 VideoMode 实例的引用。所以，改变的是底层 VideoMode 实例的 frameRate 属性，而不是指向 VideoMode 的常量引用的值。

         */
        
        
        /**
         恒等运算符
         */
        /**
         因为类是引用类型，所以多个常量和变量可能在幕后同时引用同一个类实例。（对于结构体和枚举来说，这并不成立。因为它们作为值类型，在被赋予到常量、变量或者传递到函数时，其值总是会被拷贝。）
         */
        /**
         判定两个常量或者变量是否引用同一个类实例有时很有用。为了达到这个目的，Swift 提供了两个恒等运算符：⚠️
         相同（===）
         不相同（!==）
         */
        if tenEighty === alsoTenEighty {
            print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
        }
        // 打印 "tenEighty and alsoTenEighty refer to the same VideoMode instance."
        /**
         请注意，“相同”（用三个等号表示，===）与“等于”（用两个等号表示，==）的不同。“相同”表示两个类类型（class type）的常量或者变量引用同一个类实例。“等于”表示两个实例的值“相等”或“等价”，判定时要遵照设计者定义的评判标准
         */
        
        /**
         指针
         */
        /**
         如果你有 C，C++ 或者 Objective-C 语言的经验，那么你也许会知道这些语言使用指针来引用内存中的地址。Swift 中引用了某个引用类型实例的常量或变量，与 C 语言中的指针类似，不过它并不直接指向某个内存地址，也不要求你使用星号（*）来表明你在创建一个引用。相反，Swift 中引用的定义方式与其它的常量或变量的一样。
         */
        
    }
}

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?//因为 name 是一个可选类型，它会被自动赋予一个默认值 nil，意为“没有 name 值”。
}
