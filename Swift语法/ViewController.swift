//
//  ViewController.swift
//  Swift语法
//
//  Created by caowei on 2020/5/29.
//  Copyright © 2020 caowei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         简单值
         */
        //使用 let 来声明常量，使用 var 来声明变量。一个常量的值，在编译的时候，并不需要有明确的值，但是你只能为它赋值一次。这说明你可以用一个常量来命名一个值，一次赋值就可在多个地方使用。
        var myvar = 20
        myvar = 15
        print(myvar)
        
        //初始值没有提供足够的信息（或者没有初始值），那你需要在变量后面声明类型，用冒号分割
        let idou : Float = 17
        print(idou)
        
        //值永远不会被隐式转换为其他类型。如果你需要把一个值转换成其他类型，请显式转换。
        let label = "the label is"
        let w = 94
        let labelw = label + String(w)
        print(labelw)
        
        //有一种更简单的把值转换成字符串的方法：把值写到括号中，并且在括号之前写一个反斜杠（\）
        let apples = 3
        let oranges = 5
        let  apppleSum = "I have \(apples) apples"
        print(apppleSum)
        
        //使用三个双引号（"""）来包含多行字符串内容。每行行首的缩进会被去除，直到和结尾引号的缩进相匹配
        let quotation = """
        I said "I have \(apples) apples."
        And then I said "I have \(apples + oranges) pieces of fruit."
        """
        print(quotation)
        
        //使用方括号 [] 来创建数组和字典，并使用下标或者键（key）来访问元素。最后一个元素后面允许有个逗号
        var shoppingList = ["catfish","water","tulips","bule oaint"]
        shoppingList[1] = "nowater"
        
        var occupations = [
            "Malcolm": "Captain",
            "Kaylee": "Mechanic",
        ]
        occupations["Jayne"] = "Public Relations"
        print(shoppingList,occupations)
        
        //数组在添加元素时会自动变大。
        shoppingList.append("blue paint")
        print(shoppingList)
        
        //使用初始化语法来创建一个空数组或者空字典
        let emptyArray = [String]()
        let emptyDic = [String: Float]()
        print(emptyArray,emptyDic)
        
        /**
         控制流
         */
        
        //使用 if 和 switch 来进行条件操作，使用 for-in、while 和 repeat-while 来进行循环。包裹条件和循环变量的括号可以省略，但是语句体的大括号是必须的。
        let individualScores = [75, 43, 103, 87, 12]
        var teamScore = 0
        for score in individualScores {
            if score > 50 {
                teamScore += 3
            } else {
                teamScore += 1
            }
        }
        print(teamScore)
        
        //在 if 语句中，条件必须是一个布尔表达式——这意味着像 if score { ... } 这样的代码将报错，而不会隐形地与 0 做对比。
        //你可以一起使用 if 和 let 一起来处理值缺失的情况。这些值可由可选值来代表。一个可选的值是一个具体的值或者是 nil 以表示值缺失。在类型后面加一个问号（?）来标记这个变量的值是可选的。
        var optionalString: String? = "Hello"
        print(optionalString == nil)
        var optionalName: String? = "John Appleseed" //nil
        var greeting = "Hello!"
        if let name = optionalName {
            greeting = "Hello, \(name)"
        }
        print(greeting)
        
        //如果变量的可选值是 nil，条件会判断为 false，大括号中的代码会被跳过。如果不是 nil，会将值解包并赋给 let 后面的常量，这样代码块中就可以使用这个值了。(把上面的改成var optionalName: String? = nil）
        
        //另一种处理可选值的方法是通过使用 ?? 操作符来提供一个默认值。如果可选值缺失的话，可以使用默认值来代替。
        let nickName: String? = nil
        let fullName: String = "John Appleseed"
        let informalGreeting = "Hi \(nickName ?? fullName)"
        print(informalGreeting)
        
        //switch 支持任意类型的数据以及各种比较操作——不仅仅是整数以及测试相等。
        //运行 switch 中匹配到的 case 语句之后，程序会退出 switch 语句，并不会继续向下运行，所以不需要在每个子句结尾写 break。
        let vegetable = "red pepper"
        switch vegetable {
        case "celery":
            print("Add some raisins and make ants on a log.")
        case "cucumber", "watercress":
            print("That would make a good tea sandwich.")
        case let x where x.hasSuffix("pepper"):
            print("Is it a spicy \(x)?")
        default:
            print("Everything tastes good in soup.")
        }
        
        //你可以使用 for-in 来遍历字典，需要一对儿变量来表示每个键值对。字典是一个无序的集合，所以他们的键和值以任意顺序迭代结束。
        let interestingNumbers = [
            "Prime": [2, 3, 5, 7, 11, 13],
            "Fibonacci": [1, 1, 2, 3, 5, 8],
            "Square": [1, 4, 9, 16, 25],
        ]
        var largest = 0
        for (kind, numbers) in interestingNumbers {
            for number in numbers {
                if number > largest {
                    largest = number
                }
            }
        }
        print(largest)
        
        //使用 while 来重复运行一段代码直到条件改变。循环条件也可以在结尾，保证能至少循环一次。
        var n = 2
        while n < 100 {
            n *= 2
        }
        print(n)
        
        var m = 2
        repeat {
            m *= 2
        } while m < 100
        print(m)
        
        //你可以在循环中使用 ..< 来表示下标范围(使用 ..< 创建的范围不包含上界，如果想包含的话需要使用 ...)
        var total = 0
        for i in 0..<4 {
            total += i
        }
        print(total)
        
        greet(person: "Bob", day: "Friday")
        greet2("John", on: "Friday")
        
        let statistics = calculateStatistics(scores: [5,3,100,3,9])
        print(statistics)
        print(statistics.sum)
        print(statistics.2)
        
        let fit = returnFifteen()
        print(fit)
        
        let increment = makeIncrementer()//这里是返回addOne()
        print(increment(7))
        
        let numbers = [20, 19, 7, 13]
        hasAnyMatches(list: numbers, condition: lessThanTen)
        
        //函数实际上是一种特殊的闭包:它是一段能之后被调取的代码。闭包中的代码能访问闭包作用域中的变量和函数，即使闭包是在一个不同的作用域被执行的——你已经在嵌套函数的例子中看过了。你可以使用 {} 来创建一个匿名闭包。使用 in 将参数和返回值类型的声明与闭包函数体进行分离。
        //map:map方法作用是把数组[T]通过闭包函数把每一个数组中的元素变成U类型的值，最后组成数组[U]。定义如下：
        //func map(transform: (T) -> U) -> [U]
        
        let mapNum =  numbers.map({
            (number: Int) -> Int in
            let result = 3 * number
            return result
        })
        print(mapNum)
        
        //有很多种创建更简洁的闭包的方法。如果一个闭包的类型已知，比如作为一个代理的回调，你可以忽略参数，返回值，甚至两个都忽略。单个语句闭包会把它语句的值当做结果返回。
        let mapNum2 = numbers.map({ number in 3 * number})
        print(mapNum2)
        
        //你可以通过参数位置而不是参数名字来引用参数——这个方法在非常短的闭包中非常有用。当一个闭包作为最后一个参数传给一个函数的时候，它可以直接跟在圆括号后面。当一个闭包是传给函数的唯一参数，你可以完全忽略圆括号。
       // $0 来表示闭包的第一个参数，$1 来表示第二个，以此类推
        //https://www.jianshu.com/p/013a1d82cad5
        let sortedNumbers = numbers.sorted { $0 > $1 }//numbers.sorted(by: >)
        print(sortedNumbers)
        
        
        /**
         对象和类
         */
        let shape = Shape()
        shape.numberOfSides = 7
        var shapeDescription = shape.simpleDescription()
        
        let test = Square(sideLength: 5.2, name: "my test square")
//        test.area()
//        test.simpleDescription()
        print(test.area())
        print(test.simpleDescription())
        
        print(test.fatherName())
         
        let triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
        print(triangle.perimeter) //9.3
        triangle.perimeter = 9.9
        print(triangle.sideLength) //3.3000000000000003
        
        let triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
        print(triangleAndSquare.square.sideLength)
        print(triangleAndSquare.triangle.sideLength)
        
        
    }


}

/**
 函数和闭包
 */

//使用 func 来声明一个函数，使用名字和参数来调用函数。使用 -> 来指定函数返回值的类型。
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}

//默认情况下，函数使用它们的参数名称作为它们参数的标签，在参数名称前可以自定义参数标签，或者使用 _ 表示不使用参数标签。
func greet2(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}

//使用元组来生成复合值，比如让一个函数返回多个值。该元组的元素可以用名称或数字来获取。
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    return (min, max, sum)
}

//函数可以嵌套。被嵌套的函数可以访问外侧函数的变量，你可以使用嵌套函数来重构一个太长或者太复杂的函数。
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}

//函数是第一等类型，这意味着函数可以作为另一个函数的返回值
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}

//函数也可以当做参数传入另一个函数
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}

/**
 对象和类
 */
//使用 class 和类名来创建一个类。类中属性的声明和常量、变量声明一样，唯一的区别就是它们的上下文是类。同样，方法和函数声明也一样。
class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
    
}

//这个版本的 Shape 类缺少了一些重要的东西：一个构造函数来初始化类实例。使用 init 来创建一个构造器。
class NameShape {
    var numberOfSides: Int = 0
    var name: String
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}
//如果你需要在对象释放之前进行一些清理工作，使用 deinit 创建一个析构函数。

//子类的定义方法是在它们的类名后面加上父类的名字，用冒号分割。创建类的时候并不需要一个标准的根类，所以你可以根据需要添加或者忽略父类。

//子类如果要重写父类的方法的话，需要用 override 标记——如果没有添加 override 就重写父类方法的话编译器会报错。编译器同样会检测 override 标记的方法是否确实在父类中
class Square: NameShape {
    var sideLength: Double
    init(sideLength: Double, name: String) {
        //在调用父类构造函数之前，必须保证本类的属性都已经完成初始化
        self.sideLength = sideLength
        
        //super.init() 必须放在本类属性初始化的后面，保证本类属性全部初始化完成
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    func fatherName() -> String {
        return name
    }
    
    override func simpleDescription() -> String {
        return  "A square with sides of length \(sideLength)."
    }
}

//除了简单的存储属性，还有使用 getter 和 setter 的计算属性
//如果只重写 get 方法,默认为 readOnly
/**
 注意 EquilateralTriangle 类的构造器执行了三步：
 设置子类声明的属性值
 调用父类的构造器
 改变父类定义的属性值。其他的工作比如调用方法、getters 和 setters 也可以在这个阶段完成。
 */
class EquilateralTriangle: NameShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        //在 perimeter 的 setter 中，新值的名字是 newValue。你可以在 set 之后的圆括号中显式地设置一个名字。?
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
          return "An equilateral triangle with sides of length \(sideLength)."
    }
}

//如果你不需要计算属性，但是仍然需要在设置一个新值之前或者之后运行代码，使用 willSet 和 didSet。写入的代码会在属性值发生改变时调用，但不包含构造器中发生值改变的情况。比如，下面的类确保三角形的边长总是和正方形的边长相同。
class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}
