//
//  Inherit.swift
//  Swift语法
//
//  Created by caowei on 2020/6/12.
//  Copyright © 2020 caowei. All rights reserved.
//
/**
 继承
 */
import UIKit

class Inherit: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /**定义一个基类*/
        //不继承于其它类的类，称之为基类
        //注意：Swift 中的类并不是从一个通用的基类继承而来的。如果你不为自己定义的类指定一个超类的话，这个类就会自动成为基类
        class Vehicle {
            var currentSpeed = 0.0
            var description: String {
                return "traveling at \(currentSpeed) miles per hour"
            }
            func makeNoise() {
                // 什么也不做——因为车辆不一定会有噪音
            }
        }
        
        //新的 Bicycle 类自动继承 Vehicle 类的所有特性，比如 currentSpeed 和 description 属性，还有 makeNoise() 方法。
        class Bicycle: Vehicle {
            var hasBasket = false
        }
        
        let bicycle = Bicycle()
        bicycle.hasBasket = true
        bicycle.currentSpeed = 15.0
        print("Bicycle: \(bicycle.description)")
        // 打印“Bicycle: traveling at 15.0 miles per hour”
        
        //子类还可以继续被其它类继承，
        class Tandem: Bicycle {
            var currentNumberOfPassengers = 0
        }
        
        let tandem = Tandem()
        tandem.hasBasket = true
        tandem.currentNumberOfPassengers = 2
        tandem.currentSpeed = 22.0
        print("Tandem: \(tandem.description)")
        // 打印：“Tandem: traveling at 22.0 miles per hour”
        
        /**
         重写
         */
        //子类可以为继承来的实例方法，类方法，实例属性，类属性，或下标提供自己定制的实现。我们把这种行为叫重写.你需要在重写定义的前面加上 override 关键字
        class Train: Vehicle {
            override func makeNoise() {
                print("Choo Choo")
            }
        }
        //重写方法
        let train = Train()
        train.makeNoise()
        // 打印“Choo Choo”
        
        //重写属性
        //你可以提供定制的 getter（或 setter）来重写任何一个继承来的属性，无论这个属性是存储型还是计算型属性。子类并不知道继承来的属性是存储型的还是计算型的，它只知道继承来的属性会有一个名字和类型。你在重写一个属性时，必须将它的名字和类型都写出来。这样才能使编译器去检查你重写的属性是与超类中同名同类型的属性相匹配的。
        //你可以将一个继承来的只读属性重写为一个读写属性，只需要在重写版本的属性里提供 getter 和 setter 即可。但是，你不可以将一个继承来的读写属性重写为一个只读属性
        /**
         注意：如果你在重写属性中提供了 setter，那么你也一定要提供 getter。如果你不想在重写版本中的 getter 里修改继承来的属性值，你可以直接通过 super.someProperty 来返回继承来的值，其中 someProperty 是你要重写的属性的名字。
         */
        class Car: Vehicle {
            var gear = 1
            override var description: String {
                return super.description + " in gear \(gear)"
            }
        }
        let car = Car()
        car.currentSpeed = 25.0
        car.gear = 3
        print("Car: \(car.description)")
        // 打印“Car: traveling at 25.0 miles per hour in gear 3”
        
        /**重写属性观察器*/
        //可以通过重写属性为一个继承来的属性添加属性观察器。这样一来，无论被继承属性原本是如何实现的，当其属性值发生改变时，你就会被通知到
        /**
         注意：你不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器。这些属性的值是不可以被设置的，所以，为它们提供 willSet 或 didSet 实现也是不恰当。 此外还要注意，你不可以同时提供重写的 setter 和重写的属性观察器。如果你想观察属性值的变化，并且你已经为那个属性提供了定制的 setter，那么你在 setter 中就可以观察到任何值变化了
         */
        class AutomaticCar: Car {
            override var currentSpeed: Double {
                didSet {
                    gear = Int(currentSpeed / 10.0) + 1
                }
            }
        }
        
        let automatic = AutomaticCar()
        automatic.currentSpeed = 35.0
        print("AutomaticCar: \(automatic.description)")
        // 打印“AutomaticCar: traveling at 35.0 miles per hour in gear 4”
        
        /**
         防止重写
         */
        /**
         你可以通过把方法，属性或下标标记为 final 来防止它们被重写，只需要在声明关键字前加上 final 修饰符即可（例如：final var、final func、final class func 以及 final subscript）。
         任何试图对带有 final 标记的方法、属性或下标进行重写的代码，都会在编译时会报错。在类扩展中的方法，属性或下标也可以在扩展的定义里标记为 final。
         可以通过在关键字 class 前添加 final 修饰符（final class）来将整个类标记为 final 。这样的类是不可被继承的，试图继承这样的类会导致编译报错。
         */
        
    }

}
