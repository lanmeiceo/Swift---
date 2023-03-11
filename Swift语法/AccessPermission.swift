//
//  AccessPermission.swift
//  Swift语法
//
//  Created by caowei on 2020/12/25.
//  Copyright © 2020 caowei. All rights reserved.
//  访问权限
/**
 1、private

 private访问级别所修饰的属性或者方法只能在当前类里访问。

 2、fileprivate

 fileprivate访问级别所修饰的属性或者方法在当前的Swift源文件里可以访问。

 3、internal（默认访问级别，internal修饰符可写可不写）

 internal访问级别所修饰的属性或方法在源代码所在的整个模块都可以访问。
 如果是框架或者库代码，则在整个框架内部都可以访问，框架由外部代码所引用时，则不可以访问。
 如果是App代码，也是在整个App代码，也是在整个App内部可以访问。

 4、public

 可以被任何人访问。但其他module中不可以被override和继承，而在module内可以被override和继承。

 5、open

 可以被任何人使用，包括override和继承。

 */
import UIKit

class AccessPermission: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         Swift 中由低至高提供了 private，fileprivate，internal，public 和 open 五种访问控制的权限。默认的 internal 在绝大部分时候是适用的，另外由于它是 Swift 中的默认的控制级，因此它也是最为方便的。
         
         我们想让同一 module (或者说是 target) 中的其他代码访问的话，保持默认的 internal 就可以了。如果我们在为其他开发者开发库的话，可能会希望用一些 public 甚至 open，因为在 target 外只能调用到 public 和 open 的代码。public 和 open 的区别在于，只有被 open 标记的内容才能在别的框架中被继承或者重写。因此，如果你只希望框架的用户使用某个类型和方法，而不希望他们继承或者重写的话，应该将其限定为 public 而非 open。

         */
        
        /**1. private 和 fileprivate 修饰属性*/

        
        let p = Per()
        print(p.name)
        
        //编译器不会提示age属性 如果强行写p.age
        //会报错'age' is inaccessible due to 'private' protection level
//        print(p.age)
        
        
        /**2、private 和 fileprivate 修饰方法时*/
        let p2 = Per2()
        p2.printNameAndAge()
        
        //用private修饰的方法不能够被调用到
        //'setNameAndAge' is inaccessible due to 'private' protection level
        // p2.setNameAndAge("superMan",100)
        
        
        
    }

}

/**1. private 和 fileprivate 修饰属性*/

class Per: NSObject {

    fileprivate var name:String = "man"
    
    private var age:Int = 1
}

//在extension中需要用到类的属性时，只要保证实在同一个文件内，无论是用private或fileprivate修饰，都是可以被正常访问的。

extension Per {
    
    func printAge()  {
        print(self.age)
        //在 当前文件的 extension 中，调用private 修饰的属性没问题
    }
    
    func prinName()  {
      //在 当前文件的 extension 中，调用fileprivate 修饰的属性没问题
        print(self.name)
    }
}


/**2、private 和 fileprivate 修饰方法时*/
class Per2: NSObject {
    fileprivate var name:String = "man"
    
    private var age:Int = 1
    
    fileprivate func printNameAndAge(){
        print("name:\(name) age:\(age)")
    }
    
    private func setNameAndAge(name:String,age:Int){
        //xxx
    }
}


/**3.子类是否能使用到private和fileprivate修饰的代码*/
/**3.1在当前文件内新加一个Peson的子类*/
class Stu: Per2 {
    //依然可访问到父类中 fileprivate 修饰的方法或属性
    func test() {
        print("来自Student: \(name) ")
        //print("来自Student: \(age) ") //此时age也是不可访问的
        
        printNameAndAge() //fileprivate 可正常调用
        
        //setNameAndAge("daming",13) //private无法调用
    }
}

/**3.2在不同文件内新加一个Peson的子类*/
//新文件Teacher.swift
//class Teacher: Per {
//    func testPrint() {
//        //可以访问extension 中的方法，没加修饰默认为 internal
//        prinName();
//        printAge();
//
//        //此时 private和fileprivate 修饰的属性或方法都无法访问到
//        //printNameAndAge()
//        //setNameAndAge(name: "SuperMan", age: 100)
//
//        // let a =  self.age
//        //let b =  self.name
//    }
//
//    //但不可以被重写
//    //Declarations from extensions cannot be overridden yet
////    override func prinName() {
////        print("子类重写 prinName")
////    }
////    override func printAge() {
////        print("子类重写 printAge")
////    }
//}

/**在Swift4中，如果子类跟父类不再同一个文件下是不能够使用fileprivate修饰的方法或属性的；且private修饰的方法和属性无论是否跟父类在同一个文件文件内，都无法使用。
 */

/**总结
 private 表示代码只能在当前作用域或者同一文件中同一类型的作用域中被使用，
 fileprivate 表示代码可以在当前文件中被访问，而不做类型限定。
 */
