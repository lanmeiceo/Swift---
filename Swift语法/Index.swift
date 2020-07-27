//
//  Index.swift
//  Swift语法
//
//  Created by caowei on 2020/6/4.
//  Copyright © 2020 caowei. All rights reserved.
//
/**
下标
*/
import UIKit

class Index: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /**下标语法*/
        /**
         下标允许你通过在实例名称后面的方括号中传入一个或者多个索引值来对实例进行查询。它的语法类似于实例方法语法和计算型属性语法。定义下标使用 subscript 关键字，与定义实例方法类似，都是指定一个或多个输入参数和一个返回类型。与实例方法不同的是，下标可以设定为读写或只读。这种行为由 getter 和 setter 实现，类似计算型属性
         */
//        subscript(index: Int) -> Int {
//            get {
//              // 返回一个适当的 Int 类型的值
//            }
//            set(newValue) {
//              // 执行适当的赋值操作
//            }
//        }
        
        /**newValue 的类型和下标操作的返回类型相同。如同计算型属性，可以不指定 setter 的参数（newValue）。如果不指定参数，setter 会提供一个名为 newValue 的默认参数。
        */
        
        //如同只读计算型属性，对于只读下标的声明，你可以通过省略 get 关键字和对应的大括号组来进行简写：
//        subscript(index: Int) -> Int {
//            // 返回一个适当的 Int 类型的值
//        }
        
        struct TimesTable {
            let multiplier: Int
            subscript(index: Int) -> Int {
                return multiplier * index
            }
        }
        //在上例中，创建了一个 TimesTable 实例，用来表示整数 3 的乘法表。数值 3 被传递给结构体的构造函数，作为实例成员 multiplier 的值
        //你可以通过下标访问 threeTimesTable 实例，例如上面演示的 threeTimesTable[6]。这条语句查询了乘法表中 3 的第六个元素，返回 3 的 6 倍即 18。
        let threeTimesTable = TimesTable(multiplier: 3)
        print("six times three is \(threeTimesTable[6])")
        // 打印“six times three is 18”

        //注意：TimesTable 例子基于一个固定的数学公式，对 threeTimesTable[someIndex] 进行赋值操作并不合适，因此下标定义为只读的
    
        struct Matrix {
            let rows: Int, columns: Int
            var grid: [Double]
            init(rows: Int, columns: Int) {
                self.rows = rows
                self.columns = columns
                grid = Array(repeating: 0.0, count: rows * columns)
            }
            func indexIsValid(row: Int, column: Int) -> Bool {
                return row >= 0 && row < rows && column >= 0 && column < columns
            }
            //Matrix 下标的 getter 和 setter 中都含有断言，用来检查下标入参 row 和 column 的值是否有效。为了方便进行断言，Matrix 包含了一个名为 indexIsValid(row:column:) 的便利方法，用来检查入参 row 和 column 的值是否在矩阵范围内：
            subscript(row: Int, column: Int) -> Double {
                get {
                    assert(indexIsValid(row: row, column: column), "Index out of range")
                    return grid[(row * columns) + column]
                }
                set {
                    assert(indexIsValid(row: row, column: column), "Index out of range")
                    grid[(row * columns) + column] = newValue
                }
            }
        }
        
        var matrix = Matrix(rows: 2, columns: 2)
        let someValue = matrix[2, 2]
        // 断言将会触发，因为 [2, 2] 已经超过了 matrix 的范围
        
        
        /**类型下标*/
        /**正如上节所述，实例下标是在特定类型的一个实例上调用的下标。你也可以定义一种在这个类型自身上调用的下标。这种下标被称作类型下标。你可以通过在 subscript 关键字之前写下 static 关键字的方式来表示一个类型下标。类类型可以使用 class 关键字来代替 static，它允许子类重写父类中对那个下标的实现。下面的例子展示了如何定义和调用一个类型下标*/
        enum Planet: Int {
            case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
            static subscript(n: Int) -> Planet {
                return Planet(rawValue: n)!
            }
        }
        let mars = Planet[4]
        print(mars)
    }

}
