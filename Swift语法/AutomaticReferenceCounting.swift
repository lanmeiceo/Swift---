//
//  AutomaticReferenceCounting.swift
//  Swift语法
//
//  Created by caowei on 2020/11/7.
//  Copyright © 2020 caowei. All rights reserved.
//  自动引用计数

import UIKit

class AutomaticReferenceCounting: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var john: Person3?
        var unit4A: Apartment?
        
        john!.apartment = unit4A
        unit4A!.tenant = john
        
        //不幸的是，这两个实例关联后会产生一个循环强引用。Person 实例现在有了一个指向 Apartment 实例的强引用，而 Apartment 实例也有了一个指向 Person 实例的强引用。因此，当你断开 john 和 unit4A 变量所持有的强引用时，引用计数并不会降为 0，实例也不会被 ARC 销毁：
        john = nil
        unit4A = nil
        
        // 注意，当你把这两个变量设为 nil 时，没有任何一个析构器被调用。循环强引用会一直阻止 Person 和 Apartment 类实例的销毁，这就在你的应用程序中造成了内存泄漏。

        /** 无主引用*/
        
        var cust: Customer?
        cust = Customer(name: "John Appleseed")
        cust!.card = CreditCard(number: 1234_5678_9012_3456, customer: cust!)
        
        // 由于再也没有指向 Customer 实例的强引用，该实例被销毁了。其后，再也没有指向 CreditCard 实例的强引用，该实例也随之被销毁了：
        john = nil
        // 打印“John Appleseed is being deinitialized”
        // 打印“Card #1234567890123456 is being deinitialized”
        
        // 最后的代码展示了在 john 变量被设为 nil 后 Customer 实例和 CreditCard 实例的析构器都打印出了“销毁”的信息。

        
        /**无主引用和隐式解包可选值属性*/
        // 上述的意义在于你可以通过一条语句同时创建 Country 和 City 的实例，而不产生循环强引用，并且 capitalCity 的属性能被直接访问，而不需要通过感叹号来解包它的可选值：
        var country = Country2(name: "Canada", capitalName: "Ottawa")
        print("\(country.name)'s capital city is called \(country.capitalCity.name)")
        // 打印“Canada's capital city is called Ottawa”
        
        /**闭包的循环强引用*/
       // 例如，可以将一个闭包赋值给 asHTML 属性，这个闭包能在 text 属性是 nil 时使用默认文本，这是为了避免返回一个空的 HTML 标签：
        let heading = HTMLElement(name: "h1")
        let defaultText = "some default text"
        heading.asHTML = {
            return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
        }
        print(heading.asHTML())
        // 打印“<h1>some default text</h1>”

        // HTMLElement 类只提供了一个构造器，通过 name 和 text（如果有的话）参数来初始化一个新元素。该类也定义了一个析构器，当 HTMLElement 实例被销毁时，打印一条消息。

        var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
        print(paragraph!.asHTML())
        // 打印“<p>hello, world</p>”
        //不幸的是，上面写的 HTMLElement 类产生了类实例和作为 asHTML 默认值的闭包之间的循环强引用。循环强引用如下图所示：

        /**弱引用和无主引用*/
        var paragraph2: HTMLElementUnowned? = HTMLElementUnowned(name: "p", text: "hello, world")
        print(paragraph2!.asHTML())
        // 打印“<p>hello, world</p>”
        
        //这一次，闭包以无主引用的形式捕获 self，并不会持有 HTMLElement 实例的强引用。如果将 paragraph 赋值为 nil，HTMLElement 实例将会被销毁，并能看到它的析构器打印出的消息：
        paragraph = nil
        // 打印“p is being deinitialized”
    }
}

// 类实例之间的循环强引用
class Person3 {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person3?
    deinit { print("Apartment \(unit) is being deinitialized") }
}


// 解决实例之间的循环强引用
/**
 Swift 提供了两种办法用来解决你在使用类的属性时所遇到的循环强引用问题：弱引用（weak reference）和无主引用（unowned reference）。
 弱引用和无主引用允许循环引用中的一个实例引用另一个实例而不保持强引用。这样实例能够互相引用而不产生循环强引用。
 当其他的实例有更短的生命周期时，使用弱引用，也就是说，当其他实例析构在先时。在上面公寓的例子中，很显然一个公寓在它的生命周期内会在某个时间段没有它的主人，所以一个弱引用就加在公寓类里面，避免循环引用。相比之下，当其他实例有相同的或者更长生命周期时，请使用无主引用
 */

/** 弱引用*/

// 下面的例子跟上面 Person 和 Apartment 的例子一致，但是有一个重要的区别。这一次，Apartment 的 tenant 属性被声明为弱引用：
//class Person {
//    let name: String
//    init(name: String) { self.name = name }
//    var apartment: Apartment?
//    deinit { print("\(name) is being deinitialized") }
//}

class ApartmentWeak {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person3?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

// Person 实例依然保持对 Apartment 实例的强引用，但是 Apartment 实例只持有对 Person 实例的弱引用。这意味着当你通过把 john 变量赋值为 nil 而断开其所保持的强引用时，再也没有指向 Person 实例的强引用了：


/**无主引用*/
// 和弱引用类似，无主引用不会牢牢保持住引用的实例。和弱引用不同的是，无主引用在其他实例有相同或者更长的生命周期时使用。你可以在声明属性或者变量时，在前面加上关键字 unowned 表示这是一个无主引用。
// 无主引用通常都被期望拥有值。不过 ARC 无法在实例被销毁后将无主引用设为 nil，因为非可选类型的变量不允许被赋值为 nil。
/**
 重点
 使用无主引用，你必须确保引用始终指向一个未销毁的实例。
 如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误。
 */


/**
 下面的例子定义了两个类，Customer 和 CreditCard，模拟了银行客户和客户的信用卡。这两个类中，每一个都将另外一个类的实例作为自身的属性。这种关系可能会造成循环强引用。
 
 Customer 和 CreditCard 之间的关系与前面弱引用例子中 Apartment 和 Person 的关系略微不同。在这个数据模型中，一个客户可能有或者没有信用卡，但是一张信用卡总是关联着一个客户。为了表示这种关系，Customer 类有一个可选类型的 card 属性，但是 CreditCard 类有一个非可选类型的 customer 属性。
 
 此外，只能通过将一个 number 值和 customer 实例传递给 CreditCard 构造器的方式来创建 CreditCard 实例。这样可以确保当创建 CreditCard 实例时总是有一个 customer 实例与之关联。
 
 由于信用卡总是关联着一个客户，因此将 customer 属性定义为无主引用，用以避免循环强引用：
 */
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64 //CreditCard 类的 number 属性被定义为 UInt64 类型而不是 Int 类型，以确保 number 属性的存储量在 32 位和 64 位系统上都能足够容纳 16 位的卡号。

    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}


// 无主引用和隐式解包可选值属性

// Person 和 Apartment 的例子展示了两个属性的值都允许为 nil，并会潜在的产生循环强引用。这种场景最适合用弱引用来解决。
// Customer 和 CreditCard 的例子展示了一个属性的值允许为 nil，而另一个属性的值不允许为 nil，这也可能会产生循环强引用。这种场景最适合通过无主引用来解决。

// 然而，存在着第三种场景，在这种场景中，两个属性都必须有值，并且初始化完成后永远不会为 nil。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解包可选值属性。

// 这使两个属性在初始化完成后能被直接访问（不需要可选解包），同时避免了循环引用。这一节将为你展示如何建立这种关系。

// 下面的例子定义了两个类，Country 和 City，每个类将另外一个类的实例保存为属性。在这个模型中，每个国家必须有首都，每个城市必须属于一个国家。为了实现这种关系，Country 类拥有一个 capitalCity 属性，而 City 类有一个 country 属性：

class Country2 {
    let name: String
    var capitalCity: City2!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City2(name: capitalName, country: self)
    }
}

class City2 {
    let name: String
    unowned let country: Country2
    init(name: String, country: Country2) {
        self.name = name
        self.country = country
    }
}

//Country 的构造器调用了 City 的构造器。然而，只有 Country 的实例完全初始化后，Country 的构造器才能把 self 传给 City 的构造器。在 两段式构造过程 中有具体描述。
// 为了满足这种需求，通过在类型结尾处加上感叹号（City!）的方式，将 Country 的 capitalCity 属性声明为隐式解包可选值类型的属性。这意味着像其他可选类型一样，capitalCity 属性的默认值为 nil，但是不需要解包它的值就能访问它。在 隐式解包可选值 中有描述。

// 由于 capitalCity 默认值为 nil，一旦 Country 的实例在构造器中给 name 属性赋值后，整个初始化过程就完成了。这意味着一旦 name 属性被赋值后，Country 的构造器就能引用并传递隐式的 self。Country 的构造器在赋值 capitalCity 时，就能将 self 作为参数传递给 City 的构造器。

// 上述的意义在于你可以通过一条语句同时创建 Country 和 City 的实例，而不产生循环强引用，并且 capitalCity 的属性能被直接访问，而不需要通过感叹号来解包它的可选值：

// code

// 在上面的例子中，使用隐式解包可选值值意味着满足了类的构造器的两个构造阶段的要求。capitalCity 属性在初始化完成后，能像非可选值一样使用和存取，同时还避免了循环强引用。


/**闭包的循环强引用*/
// 循环强引用还会发生在当你将一个闭包赋值给类实例的某个属性，并且这个闭包体中又使用了这个类实例时。这个闭包体中可能访问了实例的某个属性，例如 self.someProperty，或者闭包中调用了实例的某个方法，例如 self.someMethod()。这两种情况都导致了闭包“捕获”self，从而产生了循环强引用。

// Swift 提供了一种优雅的方法来解决这个问题，称之为 闭包捕获列表（closure capture list）。同样的，在学习如何用闭包捕获列表打破循环强引用之前，先来了解一下这里的循环强引用是如何产生的，这对我们很有帮助。

class HTMLElement {

    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }


    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }

}

// HTMLElement 类定义了一个 name 属性来表示这个元素的名称，例如代表头部元素的 "h1"，代表段落的 "p"，或者代表换行的 "br"。HTMLElement 还定义了一个可选属性 text，用来设置 HTML 元素呈现的文本。
// 除了上面的两个属性，HTMLElement 还定义了一个 lazy 属性 asHTML。这个属性引用了一个将 name 和 text 组合成 HTML 字符串片段的闭包。该属性是 Void -> String 类型，或者可以理解为“一个没有参数，返回 String 的函数”。
// 默认情况下，闭包赋值给了 asHTML 属性，这个闭包返回一个代表 HTML 标签的字符串。如果 text 值存在，该标签就包含可选值 text；如果 text 不存在，该标签就不包含文本。对于段落元素，根据 text 是 "some text" 还是 nil，闭包会返回 "<p>some text</p>" 或者 "<p />"。
// 可以像实例方法那样去命名、使用 asHTML 属性。然而，由于 asHTML 是闭包而不是实例方法，如果你想改变特定 HTML 元素的处理方式的话，可以用自定义的闭包来取代默认值。

/**
 注意
 asHTML 声明为 lazy 属性，因为只有当元素确实需要被处理为 HTML 输出的字符串时，才需要使用 asHTML。也就是说，在默认的闭包中可以使用 self，因为只有当初始化完成以及 self 确实存在后，才能访问 lazy 属性。
 */

// 不幸的是，上面写的 HTMLElement 类产生了类实例和作为 asHTML 默认值的闭包之间的循环强引用。循环强引用如下图所示：

// 实例的 asHTML 属性持有闭包的强引用。但是，闭包在其闭包体内使用了 self（引用了 self.name 和 self.text），因此闭包捕获了 self，这意味着闭包又反过来持有了 HTMLElement 实例的强引用。这样两个对象就产生了循环强引用。（更多关于闭包捕获值的信息，请参考 值捕获）。
/**
 注意
 虽然闭包多次使用了 self，它只捕获 HTMLElement 实例的一个强引用。
 */


/**解决闭包的循环强引用*/
/**
 在定义闭包时同时定义捕获列表作为闭包的一部分，通过这种方式可以解决闭包和类实例之间的循环强引用。捕获列表定义了闭包体内捕获一个或者多个引用类型的规则。跟解决两个类实例间的循环强引用一样，声明每个捕获的引用为弱引用或无主引用，而不是强引用。应当根据代码关系来决定使用弱引用还是无主引用。

 */

/**
 注意
 Swift 有如下要求：只要在闭包内使用 self 的成员，就要用 self.someProperty 或者 self.someMethod()（而不只是 someProperty 或 someMethod()）。这提醒你可能会一不小心就捕获了 self。
 */

/**定义捕获列表*/
/**
 捕获列表中的每一项都由一对元素组成，一个元素是 weak 或 unowned 关键字，另一个元素是类实例的引用（例如 self）或初始化过的变量（如 delegate = self.delegate）。这些项在方括号中用逗号分开。

 */
//如果闭包有参数列表和返回类型，把捕获列表放在它们前面：

//
//lazy var someClosure = {
//    [unowned self, weak delegate = self.delegate]
//    (index: Int, stringToProcess: String) -> String in
//    // 这里是闭包的函数体
//}

//如果闭包没有指明参数列表或者返回类型，它们会通过上下文推断，那么可以把捕获列表和关键字 in 放在闭包最开始的地方：

//lazy var someClosure = {
//    [unowned self, weak delegate = self.delegate] in
//    // 这里是闭包的函数体
//}

/**弱引用和无主引用*/
//在闭包和捕获的实例总是互相引用并且总是同时销毁时，将闭包内的捕获定义为 无主引用。
// 相反的，在被捕获的引用可能会变为 nil 时，将闭包内的捕获定义为 弱引用。弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为 nil。这使我们可以在闭包体内检查它们是否存在。
// 注意：如果被捕获的引用绝对不会变为 nil，应该用无主引用，而不是弱引用。

//前面的 HTMLElement 例子中，无主引用是正确的解决循环强引用的方法。这样编写 HTMLElement 类来避免循环强引用：

class HTMLElementUnowned {

    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }

}
