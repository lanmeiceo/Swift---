//
//  OptionalChain.swift
//  Swift语法
//
//  Created by caowei on 2020/7/28.
//  Copyright © 2020 caowei. All rights reserved.
//  可选链

/**
 可选链式调用是一种可以在当前值可能为 nil 的可选值上请求和调用属性、方法及下标的方法。如果可选值有值，那么调用就会成功；如果可选值是 nil，那么调用将返回 nil。多个调用可以连接在一起形成一个调用链，如果其中任何一个节点为 nil，整个调用链都会失败，即返回 nil。
 注意：Swift 的可选链式调用和 Objective-C 中向 nil 发送消息有些相像，但是 Swift 的可选链式调用可以应用于任意类型，并且能检查调用是否成功。
 */

import UIKit

class OptionalChain: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 使用可选链式调用代替强制解包
        // 通过在想调用的属性、方法，或下标的可选值后面放一个问号（?），可以定义一个可选链。这一点很像在可选值后面放一个叹号（!）来强制解包它的值。它们的主要区别在于当可选值为空时可选链式调用只会调用失败，然而强制解包将会触发运行时错误。
        class Person {
            var residence: Residence0?
        }

        class Residence0 {
            var numberOfRooms = 1
        }
        
        // 假如你创建了一个新的 Person 实例，它的 residence 属性由于是可选类型而将被初始化为 nil，在下面的代码中，john 有一个值为 nil 的 residence 属性
        let john = Person()
        
        // 如果使用叹号（!）强制解包获得这个 john 的 residence 属性中的 numberOfRooms 值，会触发运行时错误，因为这时 residence 没有可以解包的值：⚠️
        let roomCount = john.residence!.numberOfRooms // 这会引发运行时错误
        
        // 可选链式调用提供了另一种访问 numberOfRooms 的方式，使用问号（?）来替代原来的叹号（!）
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        // 打印“Unable to retrieve the number of rooms.”
        
       // 在 residence 后面添加问号之后，Swift 就会在 residence 不为 nil 的情况下访问 numberOfRooms
        
        // 因为访问 numberOfRooms 有可能失败，可选链式调用会返回 Int? 类型，或称为“可选的 Int”。如上例所示，当 residence 为 nil 的时候，可选的 Int 将会为 nil，表明无法访问 numberOfRooms。访问成功时，可选的 Int 值会通过可选绑定解包，并赋值给非可选类型的 roomCount 常量。
        // 要注意的是，即使 numberOfRooms 是非可选的 Int 时，这一点也成立。只要使用可选链式调用就意味着 numberOfRooms 会返回一个 Int? 而不是 Int。
        
        // 可以将一个 Residence 的实例赋给 john.residence，这样它就不再是 nil 了：
        john.residence = Residence0()
        
        // john.residence 现在包含一个实际的 Residence 实例，而不再是 nil。如果你试图使用先前的可选链式调用访问 numberOfRooms，它现在将返回值为 1 的 Int? 类型的值：
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        // 打印“Unable to retrieve the number of rooms.”

        // 为可选链式调用定义模型类

        class Residence {
            var rooms = [Room]() // [Room] 类型的空数组
            var numberOfRooms: Int {
                return rooms.count
            }
            // 访问 rooms 数组的快捷方式，即提供可读写的下标来访问 rooms 数组中指定位置的元素。
            subscript(i: Int) -> Room {
                get {
                    return rooms[i]
                }
                set {
                    rooms[i] = newValue
                }
            }
            func printNumberOfRooms() {
                print("The number of rooms is \(numberOfRooms)")
            }
            var address: Address?
        }
        
        class Room {
            let name: String
            init(name: String) { self.name = name }
        }
        
        class Address {
            var buildingName: String?
            var buildingNumber: String?
            var street: String?
            func buildingIdentifier() -> String? {
                if buildingName != nil {
                    return buildingName
                } else if let buildingNumber = buildingNumber, let street = street {
                    return "\(buildingNumber) \(street)"
                } else {
                    return nil
                }
            }
        }
        
        class Person2 {
            var residence: Residence?
        }
        // 通过可选链式调用访问属性
        
        // 使用前面定义过的类，创建一个 Person 实例，然后像之前一样，尝试访问 numberOfRooms 属性：
        let john2 = Person2()
        if let roomCount = john2.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        // 打印“Unable to retrieve the number of rooms.”
        
        // 因为 john.residence 为 nil，所以这个可选链式调用依旧会像先前一样失败。

        // 还可以通过可选链式调用来设置属性值
        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.street = "Acacia Road"
        john2.residence?.address = someAddress
        // 在这个例子中，通过 john.residence 来设定 address 属性也会失败，因为 john.residence 当前为 nil
        
        
        // 上面代码中的赋值过程是可选链式调用的一部分，这意味着可选链式调用失败时，等号右侧的代码不会被执行。对于上面的代码来说，很难验证这一点，因为像这样赋值一个常量没有任何副作用。下面的代码完成了同样的事情，但是它使用一个函数来创建 Address 实例，然后将该实例返回用于赋值。该函数会在返回前打印“Function was called”，这使你能验证等号右侧的代码是否被执行。
        func createAddress() -> Address {
            print("Function was called.")

            let someAddress = Address()
            someAddress.buildingNumber = "29"
            someAddress.street = "Acacia Road"

            return someAddress
        }
        john2.residence?.address = createAddress()
        // 没有任何打印消息，可以看出 createAddress() 函数并未被执行
        
        
        // 通过可选链式调用来调用方法
        // 可以通过可选链式调用来调用方法，并判断是否调用成功，即使这个方法没有返回值。

       // Residence 类中的 printNumberOfRooms() 方法打印当前的 numberOfRooms 值，如下所示：

//        func printNumberOfRooms() {
//            print("The number of rooms is \(numberOfRooms)")
//        }
        
        // 这个方法没有返回值。然而，没有返回值的方法具有隐式的返回类型 Void，如 无返回值函数 中所述。这意味着没有返回值的方法也会返回 ()，或者说空的元组
        // 如果在可选值上通过可选链式调用来调用这个方法，该方法的返回类型会是 Void?，而不是 Void，因为通过可选链式调用得到的返回值都是可选的
        // 这样我们就可以使用 if 语句来判断能否成功调用 printNumberOfRooms() 方法，即使方法本身没有定义返回值。通过判断返回值是否为 nil 可以判断调用是否成功：
        if john2.residence?.printNumberOfRooms() != nil {
            print("It was possible to print the number of rooms.")
        } else {
            print("It was not possible to print the number of rooms.")
        }
        // 打印“It was not possible to print the number of rooms.”
        
        // 同样的，可以据此判断通过可选链式调用为属性赋值是否成功。
        
        // 通过可选链式调用给属性赋值会返回 Void?，通过判断返回值是否为 nil 就可以知道赋值是否成功：
        if (john2.residence?.address = someAddress) != nil {
            print("It was possible to set the address.")
        } else {
            print("It was not possible to set the address.")
        }
        // 打印“It was not possible to set the address.”
        
        // 通过可选链式调用访问下标
        // 通过可选链式调用，我们可以在一个可选值上访问下标，并且判断下标调用是否成功。
        // 注意：通过可选链式调用访问可选值的下标时，应该将问号放在下标方括号的前面而不是后面。可选链式调用的问号一般直接跟在可选表达式的后面。
        
        // 下面这个例子用下标访问 john.residence 属性存储的 Residence 实例的 rooms 数组中的第一个房间的名称，因为 john.residence 为 nil，所以下标调用失败了：
        if let firstRoomName = john2.residence?[0].name {
            print("The first room name is \(firstRoomName).")
        } else {
            print("Unable to retrieve the first room name.")
        }
        // 打印“Unable to retrieve the first room name.”
        
        // 类似的，可以通过下标，用可选链式调用来赋值：
        john2.residence?[0] = Room(name: "Bathroom")
        
        // 如果你创建一个 Residence 实例，并为其 rooms 数组添加一些 Room 实例，然后将 Residence 实例赋值给 john.residence，那就可以通过可选链和下标来访问数组中的元素
        let johnsHouse = Residence()
        johnsHouse.rooms.append(Room(name: "Living Room"))
        johnsHouse.rooms.append(Room(name: "Kitchen"))
        john2.residence = johnsHouse

        if let firstRoomName = john2.residence?[0].name {
            print("The first room name is \(firstRoomName).")
        } else {
            print("Unable to retrieve the first room name.")
        }
        // 打印“The first room name is Living Room.”
        
        
        // 访问可选类型的下标
        // 如果下标返回可选类型值，比如 Swift 中 Dictionary 类型的键的下标，可以在下标的结尾括号后面放一个问号来在其可选返回值上进行可选链式调用：
        var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
        testScores["Dave"]?[0] = 91
        testScores["Bev"]?[0] += 1
        testScores["Brian"]?[0] = 72
        // "Dave" 数组现在是 [91, 82, 84]，"Bev" 数组现在是 [80, 94, 81]
        
        
        // 连接多层可选链式调用
        // 可以通过连接多个可选链式调用在更深的模型层级中访问属性、方法以及下标。然而，多层可选链式调用不会增加返回值的可选层级。
        /**
         也就是说：
         如果你访问的值不是可选的，可选链式调用将会返回可选值。
         如果你访问的值就是可选的，可选链式调用不会让可选返回值变得“更可选”。
         */
        
        // john.residence 现在包含一个有效的 Residence 实例。然而，john.residence.address 的值当前为 nil。因此，调用 john.residence?.address?.street 会失败。
        if let johnsStreet = john2.residence?.address?.street {
            print("John's street name is \(johnsStreet).")
        } else {
            print("Unable to retrieve the address.")
        }
        // 打印“Unable to retrieve the address.”
        
        // 如果为 john.residence.address 赋值一个 Address 实例，并且为 address 中的 street 属性设置一个有效值，我们就能过通过可选链式调用来访问 street 属性：
        let johnsAddress = Address()
        johnsAddress.buildingName = "The Larches"
        johnsAddress.street = "Laurel Street"
        john2.residence?.address = johnsAddress

        if let johnsStreet = john2.residence?.address?.street {
            print("John's street name is \(johnsStreet).")
        } else {
            print("Unable to retrieve the address.")
        }
        // 打印“John's street name is Laurel Street.”
        
        // 在方法的可选返回值上进行可选链式调用
        // 下面的例子中，通过可选链式调用来调用 Address 的 buildingIdentifier() 方法。这个方法返回 String? 类型的值。如上所述，通过可选链式调用来调用该方法，最终的返回值依旧会是 String? 类型：
        if let buildingIdentifier = john2.residence?.address?.buildingIdentifier() {
            print("John's building identifier is \(buildingIdentifier).")
        }
        // 打印“John's building identifier is The Larches.”
        
        // 如果要在该方法的返回值上进行可选链式调用，在方法的圆括号后面加上问号即可：⚠️
        if let beginsWithThe =
            john2.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
                if beginsWithThe {
                    print("John's building identifier begins with \"The\".")
                } else {
                    print("John's building identifier does not begin with \"The\".")
                }
        }
        // 打印“John's building identifier begins with "The".”
        
        // 注意：在上面的例子中，在方法的圆括号后面加上问号是因为你要在 buildingIdentifier() 方法的可选返回值上进行可选链式调用，而不是 buildingIdentifier() 方法本身
    }
}
