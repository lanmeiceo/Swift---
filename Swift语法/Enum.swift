//
//  Enum.swift
//  Swift语法
//
//  Created by caowei on 2020/6/4.
//  Copyright © 2020 caowei. All rights reserved.
//
/**
 枚举
 */
import UIKit

class Enum: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         每个枚举定义了一个全新的类型。像 Swift 中其他类型一样，它们的名字（例如 CompassPoint 和 Planet）以一个大写字母开头。给枚举类型起一个单数名字而不是复数名字，以便于：
         */
        var directionToHead = CompassPoint.west
        //directionToHead 的类型可以在它被 CompassPoint 的某个值初始化时推断出来。一旦 directionToHead 被声明为 CompassPoint 类型，你可以使用更简短的点语法将其设置为另一个 CompassPoint 的值
        //当 directionToHead 的类型已知时，再次为其赋值可以省略枚举类型名。在使用具有显式类型的枚举值时，这种写法让代码具有更好的可读性
        directionToHead = .east
        
        /**
         使用 Switch 语句匹配枚举值
         */
        /**
         正如在 控制流 中介绍的那样，在判断一个枚举类型的值时，switch 语句必须穷举所有情况。如果忽略了 .west 这种情况，上面那段代码将无法通过编译，因为它没有考虑到 CompassPoint 的全部成员。强制穷举确保了枚举成员不会被意外遗漏。
         当不需要匹配每个枚举成员的时候，你可以提供一个 default 分支来涵盖所有未明确处理的枚举成员：
         */
        directionToHead = .south
        switch directionToHead {
        case .north:
            print("Lots of planets have a north")
        case .south:
            print("Watch out for penguins")
        case .east:
            print("Where the sun rises")
        case .west:
            print("Where the skies are blue")
        default:
            print("Not a safe place for humans")
        }
        // 打印“Watch out for penguins”
        
        /**
         枚举成员的遍历
         */
        /**
         令枚举遵循 CaseIterable 协议。Swift 会生成一个 allCases 属性，用于表示一个包含枚举所有成员的集合。下面是一个例子：
         */
        enum Beverage: CaseIterable {
            case coffee, tea, juice
        }
        let numberOfChoices = Beverage.allCases.count;
        print("\(numberOfChoices) beverages available")
        
        for beverage in Beverage.allCases {
            print(beverage)
        }
        // coffee
        // tea
        // juice
        
        /**
         关联值
         */
        /**
         枚举语法那一小节的例子演示了如何定义和分类枚举的成员。你可以为 Planet.earth 设置一个常量或者变量，并在赋值之后查看这个值。然而，有时候把其他类型的值和成员值一起存储起来会很有用。这额外的信息称为关联值，并且你每次在代码中使用该枚举成员时，还可以修改这个关联值
         */
        //两种商品条形码的枚举
        enum Barcode {
            case upc(Int, Int, Int, Int)//定义一个名为 Barcode 的枚举类型，它的一个成员值是具有 (Int，Int，Int，Int) 类型关联值的 upc
            case qrCode(String)//具有 String 类型关联值的 qrCode
        }
        //面的例子创建了一个名为 productBarcode 的变量，并将 Barcode.upc 赋值给它，关联的元组值为 (8, 85909, 51226, 3)。
        var productBarcode = Barcode.upc(8, 85909, 51226, 3)
        //同一个商品可以被分配一个不同类型的条形码
        productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
        
        /**
         你可以使用一个 switch 语句来检查不同的条形码类型，和之前使用 Switch 语句来匹配枚举值的例子一样。然而，这一次，关联值可以被提取出来作为 switch 语句的一部分。你可以在 switch 的 case 分支代码中提取每个关联值作为一个常量（用 let 前缀）或者作为一个变量（用 var 前缀）来使用：
         */
        switch productBarcode {
        case .upc(let numberSystem, let manufacturer, let product, let check):
            print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        case .qrCode(let productCode):
            print("QR code: \(productCode).")
        }
        // 打印“QR code: ABCDEFGHIJKLMNOP.”
        
        //如果一个枚举成员的所有关联值都被提取为常量，或者都被提取为变量，为了简洁，你可以只在成员名称前标注一个 let 或者 var：
        switch productBarcode {
        case let .upc(numberSystem, manufacturer, product, check):
            print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        case let .qrCode(productCode):
            print("QR code: \(productCode).")
        }
        // 打印“QR code: ABCDEFGHIJKLMNOP.”
        
        /**
         原始值
         */
        /**作为关联值的替代选择，枚举成员可以被默认值（称为原始值）预填充，这些原始值的类型必须相同。*/
        /**原始值可以是字符串、字符，或者任意整型值或浮点型值。每个原始值在枚举声明中必须是唯一的*/
        enum ASCIIControlCharacter: Character {
            case tab = "\t"
            case lineFeed = "\n"
            case carriageReturn = "\r"
        }
        
        /**注意：原始值和关联值是不同的。原始值是在定义枚举时被预先填充的值，像上述三个 ASCII 码。对于一个特定的枚举成员，它的原始值始终不变。关联值是创建一个基于枚举成员的常量或变量时才设置的值，枚举成员的关联值可以变化*/
    
        /**
         原始值的隐式赋值
         */
        /**
         在使用原始值为整数或者字符串类型的枚举时，不需要显式地为每一个枚举成员设置原始值，Swift 将会自动为你赋值
         例如，当使用整数作为原始值时，隐式赋值的值依次递增 1。如果第一个枚举成员没有设置原始值，其原始值将为 0。
         */
        enum Planet: Int {
            case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
        }
        /**在上面的例子中，Plant.mercury 的显式原始值为 1，Planet.venus 的隐式原始值为 2，依次类推。*/
        
        /**当使用字符串作为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称*/
        
        //下面的例子是 CompassPoint 枚举的细化，使用字符串类型的原始值来表示各个方向的名称
        enum CompassPoint: String {
            case north, south, east, west
        }
        //上面例子中,CompassPoint.south 拥有隐式原始值 south，依次类推。
        
        //使用枚举成员的 rawValue 属性可以访问该枚举成员的原始值
        let earthsOrder = Planet.earth.rawValue //3
        let sunsetDirection = CompassPoint.west.rawValue //west
        print(earthsOrder,sunsetDirection)
     
        /**
         使用原始值初始化枚举实例
         */
        /**
         如果在定义枚举类型的时候使用了原始值，那么将会自动获得一个初始化方法，这个方法接收一个叫做 rawValue 的参数，参数类型即为原始值类型，返回值则是枚举成员或 nil。你可以使用这个初始化方法来创建一个新的枚举实例
         */
        let possiblePlanet = Planet(rawValue: 7)// possiblePlanet 类型为 Planet? 值为 Planet.uranus
        //然而，并非所有 Int 值都可以找到一个匹配的行星。因此，原始值构造器总是返回一个可选的枚举成员。在上面的例子中，possiblePlanet 是 Planet? 类型，或者说“可选的 Planet”。
        
        //如果你试图寻找一个位置为 11 的行星，通过原始值构造器返回的可选 Planet 值将是 nil
        let positionToFind = 11
        if let somePlanet = Planet(rawValue: positionToFind) {
            switch somePlanet {
            case .earth:
                print("Mostly harmless")
            default:
                print("Not a safe place for humans")
            }
        } else {
            print("There isn't a planet at position \(positionToFind)")
        }// 打印“There isn't a planet at position 11”
        
        /**
         递归枚举
         */
        /**
         递归枚举是一种枚举类型，它有一个或多个枚举成员使用该枚举类型的实例作为关联值。使用递归枚举时，编译器会插入一个间接层。你可以在枚举成员前加上 indirect 来表示该成员可递归。
         */
        enum ArithmeticExpression {
            case number(Int)
            indirect case addition(ArithmeticExpression, ArithmeticExpression)
            indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
        }
        //也可以在枚举类型开头加上 indirect 关键字来表明它的所有成员都是可递归的
        indirect enum ArithmeticExpression2 {
            case number(Int)
            case addition(ArithmeticExpression2, ArithmeticExpression2)
            case multiplication(ArithmeticExpression2, ArithmeticExpression2)
        }
        
        /**
         上面定义的枚举类型可以存储三种算术表达式：纯数字、两个表达式相加、两个表达式相乘。枚举成员 addition 和 multiplication 的关联值也是算术表达式——这些关联值使得嵌套表达式成为可能。例如，表达式 (5 + 4) * 2，乘号右边是一个数字，左边则是另一个表达式。因为数据是嵌套的，因而用来存储数据的枚举类型也需要支持这种嵌套——这意味着枚举类型需要支持递归。下面的代码展示了使用 ArithmeticExpression 这个递归枚举创建表达式 (5 + 4) * 2
         */
        let five = ArithmeticExpression2.number(5)
        let four = ArithmeticExpression2.number(4)
        let sum = ArithmeticExpression2.addition(five, four)
        let product = ArithmeticExpression2.multiplication(sum, ArithmeticExpression2.number(2))
        
        func evaluate(_ expression: ArithmeticExpression2) -> Int {
            switch expression {
            case let .number(value):
                return value
            case let .addition(left, right):
                return evaluate(left) + evaluate(right)
            case let .multiplication(left, right):
                return evaluate(left) * evaluate(right)
            }
        }
        print(evaluate(product))// 打印“18”
        
    }
}
/**
 枚举语法
 */

/**
 与 C 和 Objective-C 不同，Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。在上面的 CompassPoint 例子中，north，south，east 和 west 不会被隐式地赋值为 0，1，2 和 3。相反，这些枚举成员本身就是完备的值，这些值的类型是已经明确定义好的 CompassPoint 类型。
 */
enum CompassPoint {
    case north
    case south
    case east
    case west
}

/**多个成员值可以出现在同一行上，用逗号隔开*/
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}
