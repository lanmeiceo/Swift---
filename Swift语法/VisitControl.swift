//
//  VisitControl.swift
//  Swift语法
//
//  Created by caowei on 2020/11/7.
//  Copyright © 2020 caowei. All rights reserved.
//  访问控制
/**
 通过修饰符 open、public、internal、fileprivate、private 来声明实体的访问级别：
 
 Swift 为代码中的实体提供了五种不同的访问级别。这些访问级别不仅与源文件中定义的实体相关，同时也与源文件所属的模块相关。
 open 和 public 级别可以让实体被同一模块源文件中的所有实体访问，在模块外也可以通过导入该模块来访问源文件里的所有实体。通常情况下，你会使用 open 或 public 级别来指定框架的外部接口。open 和 public 的区别在后面会提到。
 internal 级别让实体被同一模块源文件中的任何实体访问，但是不能被模块外的实体访问。通常情况下，如果某个接口只在应用程序或框架内部使用，就可以将其设置为 internal 级别。
 fileprivate 限制实体只能在其定义的文件内部访问。如果功能的部分实现细节只需要在文件内使用时，可以使用 fileprivate 来将其隐藏。
 private 限制实体只能在其定义的作用域，以及同一文件内的 extension 访问。如果功能的部分细节只需要在当前作用域内使用时，可以使用 private 来将其隐藏。
 open 为最高访问级别（限制最少），private 为最低访问级别（限制最多）。
 open 只能作用于类和类的成员，它和 public 的区别主要在于 open 限定的类和成员能够在模块外能被继承和重写，在下面的 子类 这一节中有详解。将类的访问级别显式指定为 open 表明你已经设计好了类的代码，并且充分考虑过这个类在其他模块中用作父类时的影响。
 */
import UIKit

class VisitControl: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
