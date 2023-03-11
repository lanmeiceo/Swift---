//
//  MemorySafe.swift
//  Swift语法
//
//  Created by caowei on 2020/11/7.
//  Copyright © 2020 caowei. All rights reserved.
//  内存安全
/**
 默认情况下，Swift 会阻止你代码里不安全的行为。例如，Swift 会保证变量在使用之前就完成初始化，在内存被回收之后就无法被访问，并且数组的索引会做越界检查。
 Swift 也保证同时访问同一块内存时不会冲突，通过约束代码里对于存储地址的写操作，去获取那一块内存的访问独占权。因为 Swift 自动管理内存，所以大部分时候你完全不需要考虑内存访问的事情。然而，理解潜在的冲突也是很重要的，可以避免你写出访问冲突的代码。而如果你的代码确实存在冲突，那在编译时或者运行时就会得到错误。
 */

import UIKit

class MemorySafe: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

/**方法里 self 的访问冲突*/

// 一个结构体的 mutating 方法会在调用期间对 self 进行写访问。例如，想象一下这么一个游戏，每一个玩家都有血量，受攻击时血量会下降，并且有敌人的数量，使用特殊技能时会减少敌人数量。

struct Player {
    var name: String
    var health: Int
    var energy: Int

    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

//var oscar = Player(name: "Oscar", health: 10, energy: 10)
//var maria = Player(name: "Maria", health: 5, energy: 10)
//oscar.shareHealth(with: &maria)  // 正常

//oscar.shareHealth(with: &oscar)
// 错误：oscar 访问冲突


/**属性的访问冲突*/
// 如结构体，元组和枚举的类型都是由多个独立的值组成的，例如结构体的属性或元组的元素。因为它们都是值类型，修改值的任何一部分都是对于整个值的修改，意味着其中一个属性的读或写访问都需要访问整一个值。例如，元组元素的写访问重叠会产生冲突：

func balance2(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

//var playerInformation = (health: 10, energy: 20)
//balance2(&playerInformation.health, &playerInformation.energy)
 //错误：playerInformation 的属性访问冲突


// 上面的例子里，传入同一元组的元素对 balance(_:_:) 进行调用，产生了冲突，因为 playerInformation 的访问产生了写访问重叠。playerInformation.health 和 playerInformation.energy 都被作为 in-out 参数传入，意味着 balance(_:_:) 需要在函数调用期间对它们发起写访问。任何情况下，对于元组元素的写访问都需要对整个元组发起写访问。这意味着对于 playerInfomation 发起的两个写访问重叠了，造成冲突。

// 下面的代码展示了一样的错误，对于一个存储在全局变量里的结构体属性的写访问重叠了。

//var holly = Player(name: "Holly", health: 10, energy: 10)
//balance(&holly.health, &holly.energy)  // 错误

//在实践中，大多数对于结构体属性的访问都会安全的重叠。例如，将上面例子里的变量 holly 改为本地变量而非全局变量，编译器就会可以保证这个重叠访问是安全的：⚠️
func someFunction() {
    var oscar = Player(name: "Oscar", health: 10, energy: 10)
    balance(&oscar.health, &oscar.energy)  // 正常
}

// 上面的例子里，oscar 的 health 和 energy 都作为 in-out 参数传入了 balance(_:_:) 里。编译器可以保证内存安全，因为两个存储属性任何情况下都不会相互影响。

/**
 限制结构体属性的重叠访问对于保证内存安全不是必要的。保证内存安全是必要的，但因为访问独占权的要求比内存安全还要更严格——意味着即使有些代码违反了访问独占权的原则，也是内存安全的，所以如果编译器可以保证这种非专属的访问是安全的，那 Swift 就会允许这种行为的代码运行。特别是当你遵循下面的原则时，它可以保证结构体属性的重叠访问是安全的：

 你访问的是实例的存储属性，而不是计算属性或类的属性

 结构体是本地变量的值，而非全局变量

 结构体要么没有被闭包捕获，要么只被非逃逸闭包捕获了

 如果编译器无法保证访问的安全性，它就不会允许那次访问。
 */

