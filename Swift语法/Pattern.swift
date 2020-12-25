//
//  Pattern.swift
//  Swift语法
//
//  Created by caowei on 2020/12/25.
//  Copyright © 2020 caowei. All rights reserved.
//  模式

import UIKit

class Pattern: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**可选模式（Optional Pattern）*/
        // 可选模式匹配包装在一个 Optional(Wrapped) 或者 ExplicitlyUnwrappedOptional(Wrapped) 枚举中的 Some(Wrapped) 用例中的值。可选模式由一个标识符模式和紧随其后的一个问号组成，可以像枚举用例模式一样使用。
        // 由于可选模式是 Optional 和 ImplicitlyUnwrappedOptional 枚举用例模式的语法糖，下面两种写法是等效的：
        let someOptional: Int? = 42
        // 使用枚举用例模式匹配
//        if case .Some(let x) = someOptional {
//            print(x)
//        }


        // 使用可选模式匹配
        if case let x? = someOptional {
            print(x)
        }
        
        // 可选模式为 for-in 语句提供了一种迭代数组的简便方式，只为数组中非 nil 的元素执行循环体。
        let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]
        // 只匹配非 nil 的元素
        for case let number? in arrayOfOptionalInts {
            print("Found a \(number)")
        }
        // Found a 2
        // Found a 3
        // Found a 5
        
        
        /**
         类型转换模式（Type-Casting Patterns）
         
         有两种类型转换模式，is 模式和 as 模式。is 模式只出现在 switch 语句中的 case 标签中。is 模式和 as 模式形式如下：
         
         is 类型
         模式 as 类型
         
         is 模式仅当一个值的类型在运行时和 is 模式右边的指定类型一致，或者是其子类的情况下，才会匹配这个值。is 模式和 is 运算符有相似表现，它们都进行类型转换，但是 is 模式没有返回类型。
         
         as 模式仅当一个值的类型在运行时和 as 模式右边的指定类型一致，或者是其子类的情况下，才会匹配这个值。如果匹配成功，被匹配的值的类型被转换成 as 模式右边指定的类型。

         */
        
        
        /**表达式模式（Expression Pattern）*/
        
        // 表达式模式代表表达式的值。表达式模式只出现在 switch 语句中的 case 标签中。
       // 表达式模式代表的表达式会使用 Swift 标准库中的 ~= 运算符与输入表达式的值进行比较。如果 ~= 运算符返回 true，则匹配成功。默认情况下，~= 运算符使用 == 运算符来比较两个相同类型的值。它也可以将一个整型数值与一个 Range 实例中的一段整数区间做匹配，正如下面这个例子所示：
        
        let point = (1, 2)
        switch point {
        case (0, 0):
            print("(0, 0) is at the origin.")
        case (-2...2, -2...2):
            print("(\(point.0), \(point.1)) is near the origin.")
        default:
            print("The point is at (\(point.0), \(point.1)).")
        }
        // 打印“(1, 2) is near the origin.”
        
        
        //你可以重载 ~= 运算符来提供自定义的表达式匹配行为。比如你可以重写上面的例子，将 point 表达式与字符串形式表示的点进行比较。


        
        switch point {
        case ("0", "0"):
            print("(0, 0) is at the origin.")
        default:
            print("The point is at (\(point.0), \(point.1)).")
        }
        // 打印“The point is at (1, 2).”
        
        
    }
}


// 重载 ~= 运算符对字符串和整数进行比较
func ~=(pattern: String, value: Int) -> Bool {
    return pattern == "\(value)"
}
