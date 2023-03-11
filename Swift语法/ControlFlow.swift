//
//  ControlFlow.swift
//  Swift语法
//
//  Created by caowei on 2020/6/4.
//  Copyright © 2020 caowei. All rights reserved.
//
/**
 控制流
 */
/**
 Swift 提供了多种流程控制结构，包括可以多次执行任务的 while 循环，基于特定条件选择执行不同代码分支的 if、guard 和 switch 语句，还有控制流程跳转到其他代码位置的 break 和 continue 语句。
 Swift 还提供了 for-in 循环，用来更简单地遍历数组（Array），字典（Dictionary），区间（Range），字符串（String）和其他序列类型。
 Swift 的 switch 语句比许多类 C 语言要更加强大。case 还可以匹配很多不同的模式，包括范围匹配，元组（tuple）和特定类型匹配。switch 语句的 case 中匹配的值可以声明为临时常量或变量，在 case 作用域内使用，也可以配合 where 来描述更复杂的匹配条件。
 */
import UIKit

class ControlFlow: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //你也可以通过遍历一个字典来访问它的键值对。遍历字典时，字典的每项元素会以 (key, value) 元组的形式返回，你可以在 for-in 循环中使用显式的常量名称来解读 (key, value) 元组。下面的例子中，字典的键声明会为 animalName 常量，字典的值会声明为 legCount 常量
        let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
        for (animalName, legCount) in numberOfLegs {
            print("\(animalName)s have \(legCount) legs")
        }
        // cats have 4 legs
        // ants have 6 legs
        // spiders have 8 legs
        
        //如果你不需要区间序列内每一项的值，你可以使用下划线（_）替代变量名来忽略这个值：⚠️
        let base = 3
        let power = 10
        var answer = 1
        for _ in 1...power {
            answer *= base
        }
        print("\(base) to the power of \(power) is \(answer)")
        // 输出“3 to the power of 10 is 59049”
        
        let minutes = 60
        for tickMark in 0..<minutes {
            // 每一分钟都渲染一个刻度线（60次）
            //            print(tickMark)
        }
        //一些用户可能在其 UI 中可能需要较少的刻度。他们可以每 5 分钟作为一个刻度。使用 stride(from:to:by:) 函数跳过不需要的标记。
        let minuteInterval = 5
        //其中from to，最后一个值将会小(大)于to的值
        for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
            // 每5分钟渲染一个刻度线（0, 5, 10, 15 ... 45, 50, 55）
            print(tickMark)
        }
        //可以在闭区间使用 stride(from:through:by:) 起到同样作用：
        let hours = 12
        let hourInterval = 3
        //而from through，最后一个值将会小(大)于等于through的值

        for tickMark in stride(from: 3, through: hours, by: hourInterval) {
            // 每3小时渲染一个刻度线（3, 6, 9, 12）
        }
        
        let finalSquare2 = 25
        let board2 = [Int](repeating: 0, count: finalSquare2 + 1)//26 个 Int 0 值初始化
        print(" board is \(board2)")
        
        let anotherCharacter: Character = "a"
        switch anotherCharacter {
        case "a", "A"://不要写成case "a": case "A":
            print("The letter A")
        default:
            print("Not the letter A")
        }
        // 输出“The letter A”
        //case 分支的模式也可以是一个值的区间
        //可以使用元组在同一个 switch 语句中测试多个值
        
        //switch的tuple, 匹配所有可能的值https://gist.github.com/greatjam/e6792b293d4bd225cba5aa048b5f70b4

        let somePoint = (1, 1)
        switch somePoint {
        case (0, 0):
            print("\(somePoint) is at the origin")
        case (_, 0):
            print("\(somePoint) is on the x-axis")
        case (0, _):
            print("\(somePoint) is on the y-axis")
        case (-2...2, -2...2):
            print("\(somePoint) is inside the box")
        default:
            print("\(somePoint) is outside of the box")
        }
        // 输出“(1, 1) is inside the box”
        
        let anotherPoint = (2, 0)
        switch anotherPoint {
            //⚠️
        case (let x, 0)://将匹配一个纵坐标为 0 的点，并把这个点的横坐标赋给临时的常量 x
            print("on the x-axis with an x value of \(x)")
        case (0, let y):
            print("on the y-axis with a y value of \(y)")
        case let (x, y)://请注意，这个 switch 语句不包含默认分支。这是因为最后一个 case ——case let(x, y) 声明了一个可以匹配余下所有值的元组。这使得 switch 语句已经完备了，因此不需要再书写默认分支
            print("somewhere else at (\(x), \(y))")
        }
        // 输出“on the x-axis with an x value of 2”
        
        //case 分支的模式可以使用 where 语句来判断额外的条件⚠️
        let yetAnotherPoint = (1, -1)
        switch yetAnotherPoint {
        case let (x, y) where x == y:
            print("(\(x), \(y)) is on the line x == y")
        case let (x, y) where x == -y:
            print("(\(x), \(y)) is on the line x == -y")
        case let (x, y):
            print("(\(x), \(y)) is just some arbitrary point")
        }
        // 输出“(1, -1) is on the line x == -y”
        
        //contiune
        let puzzleInput = "great minds think alike"
        var puzzleOutput = ""
        for character in puzzleInput {
            switch character {
            case "a", "e", "i", "o", "u", " ":
                continue
            default:
                puzzleOutput.append(character)
            }
        }
        print(puzzleOutput)
        //匹配到元音字母和空格字符时不做处理，而不是让每一个匹配到的字符都被打印。
        // 输出“grtmndsthnklk”
        
        //fallthrough
        let integerToDescribe = 5
        var description = "The number \(integerToDescribe) is"
        switch integerToDescribe {
        case 2, 3, 5, 7, 11, 13, 17, 19:
            description += " a prime number, and also"
        fallthrough//使用 fallthrough 关键字来“贯穿”到 default 分支中(即已经执行了case 还会继续往下，这里会执行default)⚠️
        default:
            description += " an integer."
        }
        print(description)
        //注意:fallthrough 关键字不会检查它下一个将会落入执行的 case 中的匹配条件。fallthrough 简单地使代码继续连接到下一个 case 中的代码，这和 C 语言标准中的 switch 语句特性是一样的
        // 输出“The number 5 is a prime number, and also an integer.”
        
        //带标签的语句
        /**
         对于一个条件语句，你可以使用 break 加标签的方式，来结束这个被标记的语句。对于一个循环语句，你可以使用 break 或者 continue 加标签，来结束或者继续这条被标记语句的执行。
         声明一个带标签的语句是通过在该语句的关键词的同一行前面放置一个标签，作为这个语句的前导关键字（introducor keyword），并且该标签后面跟随一个冒号。下面是一个针对 while 循环体的标签语法，同样的规则适用于所有的循环体和条件语句。
         label name: while condition {
         statements
         }
         */
        let finalSquare = 25
        var board = [Int](repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        var square = 0
        var diceRoll = 0
        gameLoop: while square != finalSquare {
            diceRoll += 1
            if diceRoll == 7 { diceRoll = 1 }
            switch square + diceRoll {
            case finalSquare:
                // 骰子数刚好使玩家移动到最终的方格里，游戏结束。
                break gameLoop//语句跳转控制去执行 while 循环体后的第一行代码，意味着游戏结束。
            case let newSquare where newSquare > finalSquare:
                // 骰子数将会使玩家的移动超出最后的方格，那么这种移动是不合法的，玩家需要重新掷骰子
                continue gameLoop//结束本次 while 循环，开始下一次循环。
            default:
                // 合法移动，做正常的处理
                square += diceRoll
                square += board[square]
            }
        }
        print("Game over!")
        /**
         如果上述的 break 语句没有使用 gameLoop 标签，那么它将会中断 switch 语句而不是 while 循环。使用 gameLoop 标签清晰的表明了 break 想要中断的是哪个代码块。
         同时请注意，当调用 continue gameLoop 去跳转到下一次循环迭代时，这里使用 gameLoop 标签并不是严格必须的。因为在这个游戏中，只有一个循环体，所以 continue 语句会影响到哪个循环体是没有歧义的。然而，continue 语句使用 gameLoop 标签也是没有危害的。这样做符合标签的使用规则，同时参照旁边的 break gameLoop，能够使游戏的逻辑更加清晰和易于理解。
         */
        
        /**
         提前退出
         */
        //像 if 语句一样，guard 的执行取决于一个表达式的布尔值。我们可以使用 guard 语句来要求条件必须为真时，以执行 guard 语句后的代码。不同于 if 语句，一个 guard 语句总是有一个 else 从句，如果条件不为真则执行 else 从句中的代码。
        //相比于可以实现同样功能的 if 语句，按需使用 guard 语句会提升我们代码的可读性。它可以使你的代码连贯的被执行而不需要将它包在 else 块中，它可以使你在紧邻条件判断的地方，处理违规的情况
        func greet(person: [String: String]) {
            guard let name = person["name"] else {
                return
            }

            print("Hello \(name)!")

            guard let location = person["location"] else {
                print("I hope the weather is nice near you.")
                return
            }

            print("I hope the weather is nice in \(location).")
        }

        greet(person: ["name": "John"])
        // 输出“Hello John!”
        // 输出“I hope the weather is nice near you.”
        greet(person: ["name": "Jane", "location": "Cupertino"])
        // 输出“Hello Jane!”
        // 输出“I hope the weather is nice in Cupertino.”
        
        
        /**
         检测 API 可用性
         */
        if #available(iOS 10, macOS 10.12, *) {
            // 在 iOS 使用 iOS 10 的 API, 在 macOS 使用 macOS 10.12 的 API
        } else {
            // 使用先前版本的 iOS 和 macOS 的 API
        }
        
    }

}
