//
//  DeinitProcessViewController.swift
//  Swift语法
//
//  Created by caowei on 2020/7/27.
//  Copyright © 2020 caowei. All rights reserved.
//  析构过程

/**
 析构器只适用于类类型，当一个类的实例被释放之前，析构器会被立即调用。析构器用关键字 deinit 来标示，类似于构造器要用 init 来标示
 */

import UIKit

class DeinitProcess: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 析构过程原理
        // Swift 会自动释放不再需要的实例以释放资源。如 自动引用计数 章节中所讲述，Swift 通过自动引用计数（ARC) 处理实例的内存管理。通常当你的实例被释放时不需要手动地去清理。但是，当使用自己的资源时，你可能需要进行一些额外的清理。例如，如果创建了一个自定义的类来打开一个文件，并写入一些数据，你可能需要在类实例被释放之前手动去关闭该文件。
        // 在类的定义中，每个类最多只能有一个析构器，而且析构器不带任何参数和圆括号，如下所示：
//        deinit {
//            // 执行析构过程
//        }
        
        //析构器是在实例释放发生前被自动调用的。你不能主动调用析构器。子类继承了父类的析构器，并且在子类析构器实现的最后，父类的析构器会被自动调用。即使子类没有提供自己的析构器，父类的析构器也同样会被调用。
        
        //Bank 使用 coinsInBank 属性来跟踪它当前拥有的硬币数量。Bank 还提供了两个方法，distribute(coins:) 和 receive(coins:)，分别用来处理硬币的分发和收集。
        class Bank {
            static var coinsInBank = 10_000
            static func distribute(coins numberOfCoinsRequested: Int) -> Int {
                let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
                coinsInBank -= numberOfCoinsToVend
                return numberOfCoinsToVend
            }
            static func receive(coins: Int) {
                coinsInBank += coins
            }
        }
        
        // Player 类定义了一个 win(coins:) 方法，该方法从 Bank 对象获取一定数量的硬币，并把它们添加到玩家的钱包。Player 类还实现了一个析构器，这个析构器在 Player 实例释放前被调用。在这里，析构器的作用只是将玩家的所有硬币都返还给 Bank 对象
        class Player {
            var coinsInPurse: Int
            init(coins: Int) {
                coinsInPurse = Bank.distribute(coins: coins)
            }
            func win(coins: Int) {
                coinsInPurse += Bank.distribute(coins: coins)
            }
            deinit {
                Bank.receive(coins: coinsInPurse)
            }
        }
        
        // 创建一个 Player 实例的时候，会向 Bank 对象申请得到 100 个硬币，前提是有足够的硬币可用。这个 Player 实例存储在一个名为 playerOne 的可选类型的变量中。这里使用了一个可选类型的变量，是因为玩家可以随时离开游戏，设置为可选使你可以追踪玩家当前是否在游戏中
        var playerOne: Player? = Player(coins: 100)
        print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
        // 打印“A new player has joined the game with 100 coins”
        print("There are now \(Bank.coinsInBank) coins left in the bank")
        // 打印“There are now 9900 coins left in the bank”
        
        // 因为 playerOne 是可选的，所以在访问其 coinsInPurse 属性来打印钱包中的硬币数量和调用 win(coins:) 方法时，使用感叹号（!）强制解包：
        playerOne!.win(coins: 2_000)
        print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
        // 打印“PlayerOne won 2000 coins & now has 2100 coins”
        print("The bank now only has \(Bank.coinsInBank) coins left")
        // 打印“The bank now only has 7900 coins left”
        
        // 玩家现在已经离开了游戏。这通过将可选类型的 playerOne 变量设置为 nil 来表示，意味着“没有 Player 实例”。当这一切发生时，playerOne 变量对 Player 实例的引用被破坏了。没有其它属性或者变量引用 Player 实例，因此该实例会被释放，以便回收内存。在这之前，该实例的析构器被自动调用，玩家的硬币被返还给银行
        playerOne = nil
        print("PlayerOne has left the game")
        // 打印“PlayerOne has left the game”
        print("The bank now has \(Bank.coinsInBank) coins")
        // 打印“The bank now has 10000 coins”
    }
}
