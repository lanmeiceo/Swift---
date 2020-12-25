//
//  GenericityParameter.swift
//  Swift语法
//
//  Created by caowei on 2020/12/25.
//  Copyright © 2020 caowei. All rights reserved.
//  泛型参数


import UIKit

class GenericityParameter: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
         泛型形参子句
         泛型形参子句指定泛型类型或函数的类型形参，以及这些参数相关的约束和要求。泛型形参子句用尖括号（<>）包住，形式如下：
         <泛型形参列表>
         
         泛型形参列表中泛型形参用逗号分开，其中每一个采用以下形式：
         类型形参 : 约束
         
         泛型形参由两部分组成：类型形参及其后的可选约束。类型形参只是占位符类型（如 T，U，V，Key，Value 等）的名字而已。你可以在泛型类型、函数的其余部分或者构造器声明，包括函数或构造器的签名中使用它（以及它的关联类型）。
         
         约束用于指明该类型形参继承自某个类或者符合某个协议或协议组合。例如，在下面的泛型函数中，泛型形参 T: Comparable 表示任何用于替代类型形参 T 的类型实参必须满足 Comparable 协议。

         */

        
        //例如，因为 Int 和 Double 均满足 Comparable 协议，所以该函数可以接受这两种类型。与泛型类型相反，调用泛型函数或构造器时不需要指定泛型实参子句。类型实参由传递给函数或构造器的实参推断而出。
        
        simpleMax(17, 42) // T 被推断为 Int 类型
        simpleMax(3.14159, 2.71828) // T 被推断为 Double 类型
        
        
        /**Where 子句*/
        /**
         要想对类型形参及其关联类型指定额外要求，可以在函数体或者类型的大括号之前添加 where 子句。where 子句由关键字 where 及其后的用逗号分隔的一个或多个要求组成。
         where : 类型要求
         where 子句中的要求用于指明该类型形参继承自某个类或符合某个协议或协议组合。尽管 where 子句提供了语法糖使其有助于表达类型形参上的简单约束（如 <T: Comparable> 等同于 <T> where T: Comparable，等等），但是依然可以用来对类型形参及其关联类型提供更复杂的约束，例如你可以强制形参的关联类型遵守协议，如，<S: Sequence> where S.Iterator.Element: Equatable 表示泛型类型 S 遵守 Sequence 协议并且关联类型 S.Iterator.Element 遵守 Equatable 协议，这个约束确保队列的每一个元素都是符合 Equatable 协议的。
         */
        
        /**也可以用操作符 == 来指定两个类型必须相同。例如，泛型形参子句 <S1: Sequence, S2: Sequence> where S1.Iterator.Element == S2.Iterator.Element 表示 S1 和 S2 必须都符合 SequenceType 协议，而且两个序列中的元素类型必须相同。

         
         */
        

        
    }

}

func simpleMax<T: Comparable>(_ x: T, _ y: T) -> T {
    if x < y {
        return y
    }
    return x
}


//如果外层的声明也有一个 where 子句，两个子句的条件都需要满足。下面的例子中，startsWithZero() 只有在 Element 同时满足 SomeProtocol 和 Numeric 才有效。
extension Collection where Element: SomeProtocol {
    func startsWithZero() -> Bool where Element: Numeric {
        return first == .zero
    }
}
