//
//  ConstructionProcess.swift
//  Swift语法
//
//  Created by caowei on 2020/7/6.
//  Copyright © 2020 caowei. All rights reserved.
//

import UIKit

class ConstructionProcess: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         构造器
         */
        //构造器在创建某个特定类型的新实例时被调用。它的最简形式类似于一个不带任何形参的实例方法，以关键字 init 命名：
//        init() {
//            // 在此处执行构造过程
//        }
        
        struct Fahrenheit {
            var temperature: Double
            init() {
                temperature = 32.0
            }
        }
        var f = Fahrenheit()
        print("The default temperature is \(f.temperature)° Fahrenheit")
        // 打印“The default temperature is 32.0° Fahrenheit”

        //自定义构造过程
        struct Celsius {
            var temperatureInCelsius: Double
            init(fromFahrenheit fahrenheit: Double) {
                temperatureInCelsius = (fahrenheit - 32.0) / 1.8
            }
            init(fromKelvin kelvin: Double) {
                temperatureInCelsius = kelvin - 273.15
            }
        }

        let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
        // boilingPointOfWater.temperatureInCelsius 是 100.0
        let freezingPointOfWater = Celsius(fromKelvin: 273.15)
        // freezingPointOfWater.temperatureInCelsius 是 0.0
        //第一个构造器拥有一个构造形参，其实参标签为 fromFahrenheit，形参命名为 fahrenheit；第二个构造器也拥有一个构造形参，其实参标签为 fromKelvin，形参命名为 kelvin。这两个构造器都将单一的实参转换成摄氏温度值，并保存在属性 temperatureInCelsius 中。
        
        
        //可选属性类型
        //如果你自定义的类型有一个逻辑上允许值为空的存储型属性——无论是因为它无法在初始化时赋值，还是因为它在之后某个时机可以赋值为空——都需要将它声明为 可选类型。可选类型的属性将自动初始化为 nil，表示这个属性是特意在构造过程设置为空。
        class SurveyQuestion {
            var text: String
            var response: String?// SurveyQuestion 的实例初始化时，它将自动赋值为 nil，表明“暂时还没有字符“。
            init(text: String) {
                self.text = text
            }
            func ask() {
                print(text)
            }
        }

        let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
        cheeseQuestion.ask()
        // 打印“Do you like cheese?”
        cheeseQuestion.response = "Yes, I do like cheese."
        
        //构造过程中常量属性的赋值
        //你可以在构造过程中的任意时间点给常量属性赋值，只要在构造过程结束时它设置成确定的值。一旦常量属性被赋值，它将永远不可更改。
        //注意：对于类的实例来说，它的常量属性只能在定义它的类的构造过程中修改；不能在子类中修改。
        //你可以修改上面的 SurveyQuestion 示例，用常量属性替代变量属性 text，表示问题内容 text 在 SurveyQuestion 的实例被创建之后不会再被修改。尽管 text 属性现在是常量，我们仍然可以在类的构造器中设置它的值
        
        //结构体的逐一成员构造器
        /**
         结构体如果没有定义任何自定义构造器，它们将自动获得一个逐一成员构造器（memberwise initializer）。不像默认构造器，即使存储型属性没有默认值，结构体也能会获得逐一成员构造器。
         */
        struct Size0 {
            var width = 0.0, height = 0.0
        }
        let twoByTwo = Size(width: 2.0, height: 2.0)
        
        /**
         值类型的构造器代理
         */
        //构造器可以通过调用其它构造器来完成实例的部分构造过程。这一过程称为构造器代理，它能避免多个构造器间的代码重复
        //构造器代理的实现规则和形式在值类型和类类型中有所不同。值类型（结构体和枚举类型）不支持继承，所以构造器代理的过程相对简单，因为它们只能代理给自己的其它构造器。类则不同，它可以继承自其它类（请参考 继承）。这意味着类有责任保证其所有继承的存储型属性在构造时也能正确的初始化
        //对于值类型，你可以使用 self.init 在自定义的构造器中引用相同类型中的其它构造器。并且你只能在构造器内部调用 self.init。
        //请注意，如果你为某个值类型定义了一个自定义的构造器，你将无法访问到默认构造器（如果是结构体，还将无法访问逐一成员构造器）。这种限制避免了在一个更复杂的构造器中做了额外的重要设置，但有人不小心使用自动生成的构造器而导致错误的情况
        //注意：假如你希望默认构造器、逐一成员构造器以及你自己的自定义构造器都能用来创建实例，可以将自定义的构造器写到扩展（extension）中，而不是写在值类型的原始定义中。
        struct Size {
            var width = 0.0, height = 0.0
        }

        struct Point {
            var x = 0.0, y = 0.0
        }
        struct Rect {
            var origin = Point()
            var size = Size()
            init() {}

            init(origin: Point, size: Size) {
                self.origin = origin
                self.size = size
            }

            init(center: Point, size: Size) {
                let originX = center.x - (size.width / 2)
                let originY = center.y - (size.height / 2)
                self.init(origin: Point(x: originX, y: originY), size: size)
            }
        }
        let basicRect = Rect()
        // basicRect 的 origin 是 (0.0, 0.0)，size 是 (0.0, 0.0)
        let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
            size: Size(width: 5.0, height: 5.0))
        // originRect 的 origin 是 (2.0, 2.0)，size 是 (5.0, 5.0)
        let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
            size: Size(width: 3.0, height: 3.0))
        // centerRect 的 origin 是 (2.5, 2.5)，size 是 (3.0, 3.0)
        
        /**
         类的继承和构造过程
         */
        //Swift 为类类型提供了两种构造器来确保实例中所有存储型属性都能获得初始值，它们被称为指定构造器和便利构造器
        //指定构造器和便利构造器
        //指定构造器是类中最主要的构造器。一个指定构造器将初始化类中提供的所有属性，并调用合适的父类构造器让构造过程沿着父类链继续往上进行。
        //便利构造器是类中比较次要的、辅助型的构造器。你可以定义便利构造器来调用同一个类中的指定构造器，并为部分形参提供默认值。你也可以定义便利构造器来创建一个特殊用途或特定输入值的实例。
        //指定构造器和便利构造器的语法
        
        //类的指定构造器的写法跟值类型简单构造器一样
//        init(parameters) {
//            statements
//        }
        
        //便利构造器也采用相同样式的写法，但需要在 init 关键字之前放置 convenience 关键字，并使用空格将它们俩分开
//        convenience init(parameters) {
//            statements
//        }
        
        //类类型的构造器代理
        //为了简化指定构造器和便利构造器之间的调用关系，Swift 构造器之间的代理调用遵循以下三条规则：
        /**
         规则 1
             指定构造器必须调用其直接父类的的指定构造器。
         规则 2
             便利构造器必须调用同类中定义的其它构造器。
         规则 3
             便利构造器最后必须调用指定构造器
             
         一个更方便记忆的方法是：
         指定构造器必须总是向上代理
         便利构造器必须总是横向代理
         
         */
        
        /**两段式构造过程*/
        //Swift 中类的构造过程包含两个阶段。第一个阶段，类中的每个存储型属性赋一个初始值。当每个存储型属性的初始值被赋值后，第二阶段开始，它给每个类一次机会，在新实例准备使用之前进一步自定义它们的存储型属性。
        //两段式构造过程的使用让构造过程更安全，同时在整个类层级结构中给予了每个类完全的灵活性。两段式构造过程可以防止属性值在初始化之前被访问，也可以防止属性被另外一个构造器意外地赋予不同的值。
        //注意：Swift 的两段式构造过程跟 Objective-C 中的构造过程类似。最主要的区别在于阶段 1，Objective-C 给每一个属性赋值 0 或空值（比如说 0 或 nil）。Swift 的构造流程则更加灵活，它允许你设置定制的初始值，并自如应对某些属性不能以 0 或 nil 作为合法默认值的情况
        /**
         Swift 编译器将执行 4 种有效的安全检查，以确保两段式构造过程不出错地完成：
         安全检查 1
             指定构造器必须保证它所在类的所有属性都必须先初始化完成，之后才能将其它构造任务向上代理给父类中的构造器。
         如上所述，一个对象的内存只有在其所有存储型属性确定之后才能完全初始化。为了满足这一规则，指定构造器必须保证它所在类的属性在它往上代理之前先完成初始化。
         安全检查 2
             指定构造器必须在为继承的属性设置新值之前向上代理调用父类构造器。如果没这么做，指定构造器赋予的新值将被父类中的构造器所覆盖。
         安全检查 3
             便利构造器必须为任意属性（包括所有同类中定义的）赋新值之前代理调用其它构造器。如果没这么做，便利构造器赋予的新值将被该类的指定构造器所覆盖。
         安全检查 4
             构造器在第一阶段构造完成之前，不能调用任何实例方法，不能读取任何实例属性的值，不能引用 self 作为一个值。
         类的实例在第一阶段结束以前并不是完全有效的。只有第一阶段完成后，类的实例才是有效的，才能访问属性和调用方法。
         */
        /**
         以下是基于上述安全检查的两段式构造过程展示
         阶段 1
         类的某个指定构造器或便利构造器被调用。
         完成类的新实例内存的分配，但此时内存还没有被初始化。
         指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化。
         指定构造器切换到父类的构造器，对其存储属性完成相同的任务。
         这个过程沿着类的继承链一直往上执行，直到到达继承链的最顶部。
         当到达了继承链最顶部，而且继承链的最后一个类已确保所有的存储型属性都已经赋值，这个实例的内存被认为已经完全初始化。此时阶段 1 完成。
         阶段 2
         从继承链顶部往下，继承链中每个类的指定构造器都有机会进一步自定义实例。构造器此时可以访问 self、修改它的属性并调用实例方法等等。
         最终，继承链中任意的便利构造器有机会自定义实例和使用 self。
         */
        
        /**跟 Objective-C 中的子类不同，Swift 中的子类默认情况下不会继承父类的构造器。Swift 的这种机制可以防止一个父类的简单构造器被一个更精细的子类继承，而在用来创建子类时的新实例时没有完全或错误被初始化*/
        //当你在编写一个和父类中指定构造器相匹配的子类构造器时，你实际上是在重写父类的这个指定构造器。因此，你必须在定义子类构造器时带上 override 修饰符。即使你重写的是系统自动提供的默认构造器，也需要带上 override 修饰符
        //如果你编写了一个和父类便利构造器相匹配的子类构造器，由于子类不能直接调用父类的便利构造器（每个规则都在上文 类的构造器代理规则 有所描述），因此，严格意义上来讲，你的子类并未对一个父类构造器提供重写。最后的结果就是，你在子类中“重写”一个父类便利构造器时，不需要加 override 修饰符
        
        class Vehicle {
            var numberOfWheels = 0
            var description: String {
                return "\(numberOfWheels) wheel(s)"
            }
        }
        class Bicycle: Vehicle {
            override init() {
                super.init()
                numberOfWheels = 2
            }
        }
        let bicycle = Bicycle()
        print("Bicycle: \(bicycle.description)")
        // 打印“Bicycle: 2 wheel(s)”
        
        //如果子类的构造器没有在阶段 2 过程中做自定义操作，并且父类有一个无参数的指定构造器，你可以在所有子类的存储属性赋值之后省略 super.init() 的调用。
        //这个例子定义了另一个 Vehicle 的子类 Hoverboard ，只设置它的 color 属性。这个构造器依赖隐式调用父类的构造器来完成，而不是显示调用 super.init()。
        class Hoverboard: Vehicle {
            var color: String
            init(color: String) {
                self.color = color
                // super.init() 在这里被隐式调用
            }
            override var description: String {
                return "\(super.description) in a beautiful \(color)"
            }
        }
        
        let hoverboard = Hoverboard(color: "silver")
        print("Hoverboard: \(hoverboard.description)")
        // Hoverboard: 0 wheel(s) in a beautiful silver
        
        /**注意：子类可以在构造过程修改继承来的变量属性，但是不能修改继承来的常量属性。*/
        
        /**构造器的自动继承*/
        //如上所述，子类在默认情况下不会继承父类的构造器。但是如果满足特定条件，父类构造器是可以被自动继承的。事实上，这意味着对于许多常见场景你不必重写父类的构造器，并且可以在安全的情况下以最小的代价继承父类的构造器。
        /**假设你为子类中引入的所有新属性都提供了默认值，以下 2 个规则将适用
         规则 1
             如果子类没有定义任何指定构造器，它将自动继承父类所有的指定构造器。
         规则 2
             如果子类提供了所有父类指定构造器的实现——无论是通过规则 1 继承过来的，还是提供了自定义实现——它将自动继承父类所有的便利构造器。
         即使你在子类中添加了更多的便利构造器，这两条规则仍然适用
         
         */
        
        /**指定构造器和便利构造器实践*/
        class Food {
            var name: String
            init(name: String) {
                self.name = name
            }

            convenience init() {
                self.init(name: "[Unnamed]")
            }
        }
        //Food 类同样提供了一个没有参数的便利构造器 init()。这个 init() 构造器为新食物提供了一个默认的占位名字，通过横向代理到指定构造器 init(name: String) 并给参数 name 赋值为 [Unnamed] 来实现：
         let mysteryMeat = Food()
         // mysteryMeat 的名字是 [Unnamed]
        
        
        class RecipeIngredient: Food {
            var quantity: Int
            init(name: String, quantity: Int) {
                self.quantity = quantity
                super.init(name: name)
            }
            override convenience init(name: String) {
                self.init(name: name, quantity: 1)
            }
        }
    
        let oneMysteryItem = RecipeIngredient()
        let oneBacon = RecipeIngredient(name: "Bacon")
        let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
        
        class ShoppingListItem: RecipeIngredient {
            var purchased = false
            var description: String {
                var output = "\(quantity) x \(name)"
                output += purchased ? " ✔" : " ✘"
                return output
            }
        }
        
        var breakfastList = [ShoppingListItem(),ShoppingListItem(name: "Bacon"),ShoppingListItem(name: "Eggs", quantity: 6)];
        breakfastList[0].name = "Orange juice"
        breakfastList[0].purchased = true
        for item in breakfastList {
            print(item.description)
        }
        // 1 x orange juice ✔
        // 1 x bacon ✘
        // 6 x eggs ✘
        
        /**可失败构造器*/
        //有时候，定义一个构造器可失败的类，结构体或者枚举是很有用的。这里所指的“失败” 指的是，如给构造器传入无效的形参，或缺少某种所需的外部资源，又或是不满足某种必要的条件等
        //为了妥善处理这种构造过程中可能会失败的情况。你可以在一个类，结构体或是枚举类型的定义中，添加一个或多个可失败构造器。其语法为在 init 关键字后面添加问号（init?）
        /**注意：可失败构造器的参数名和参数类型，不能与其它非可失败构造器的参数名，及其参数类型相同*/
        //可失败构造器会创建一个类型为自身类型的可选类型的对象。你通过 return nil 语句来表明可失败构造器在何种情况下应该 “失败
        //注意：严格来说，构造器都不支持返回值。因为构造器本身的作用，只是为了确保对象能被正确构造。因此你只是用 return nil 表明可失败构造器构造失败，而不要用关键字 return 来表明构造成功。
        
        //例如，实现针对数字类型转换的可失败构造器。确保数字类型之间的转换能保持精确的值，使用这个 init(exactly:) 构造器。如果类型转换不能保持值不变，则这个构造器构造失败。
        let wholeNumber: Double = 12345.0
        let pi = 3.14159
        if let valueMaintained = Int(exactly: wholeNumber) {
            print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
        }
        //打印“12345.0 conversion to Int maintains value of 12345”
        
        let valueChanged = Int(exactly: pi)
        // valueChanged 是 Int? 类型，不是 Int 类型
        if valueChanged == nil {
            print("\(pi) conversion to Int does not maintain value")
        }
        // 打印“3.14159 conversion to Int does not maintain value”
        
        //受一个名为 species 的 String 类型形参的可失败构造器。这个可失败构造器检查传入的species 值是否为一个空字符串。如果为空字符串，则构造失败。否则，species 属性被赋值，构造成功。
        struct Animal {
            let species: String
            init?(species: String) {
                if species.isEmpty {
                    return nil
                }
                self.species = species
            }
        }
        
        let someCreature = Animal(species: "Giraffe")
        // someCreature 的类型是 Animal? 而不是 Animal
        
        //你可以通过该可失败构造器来尝试构建一个 Animal 的实例，并检查构造过程是否成功：
        if let giraffe = someCreature {
            print("An animal was initialized with a species of \(giraffe.species)")
        }
        // 打印“An animal was initialized with a species of Giraffe”
        
        //如果你给该可失败构造器传入一个空字符串到形参 species，则会导致构造失败
        let anonymousCreature = Animal(species: "")
        // anonymousCreature 的类型是 Animal?, 而不是 Animal

        if anonymousCreature == nil {
            print("The anonymous creature could not be initialized")
        }
        // 打印“The anonymous creature could not be initialized”
        
        // 注意：检查空字符串的值（如 ""，而不是 "Giraffe" ）和检查值为 nil 的可选类型的字符串是两个完全不同的概念。上例中的空字符串（""）其实是一个有效的，非可选类型的字符串。这里我们之所以让 Animal 的可失败构造器构造失败，只是因为对于 Animal 这个类的 species 属性来说，它更适合有一个具体的值，而不是空字符串。
        
        //构造失败的传递
        //无论是向上代理还是横向代理，如果你代理到的其他可失败构造器触发构造失败，整个构造过程将立即终止，接下来的任何构造代码不会再被执行。
        class Product {
            let name: String
            init?(name: String) {
                if name.isEmpty {
                    return nil
                }
                self.name = name
            }
        }
        
        class CartItem: Product {
            let quantity: Int
            init?(name: String, quantity: Int) {
                if quantity < 1 {
                    return nil
                }
                self.quantity = quantity
                super.init(name: name)
            }
        }
        //如果你通过传入一个非空字符串 name 以及一个值大于等于 1 的 quantity 来创建一个 CartItem 实例，那么构造方法能够成功被执行
        if let twoSocks = CartItem(name: "sock", quantity: 2) {
            print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
        }
        // 打印“Item: sock, quantity: 2”
        
        //倘若你以一个值为 0 的 quantity 来创建一个 CartItem 实例，那么将导致 CartItem 构造器失败
        if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
            print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
        } else {
            print("Unable to initialize zero shirts")
        }
        // 打印“Unable to initialize zero shirts”

        //同样地，如果你尝试传入一个值为空字符串的 name 来创建一个 CartItem 实例，那么将导致父类 Product 的构造过程失败：
        if let oneUnnamed = CartItem(name: "", quantity: 1) {
            print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
        } else {
            print("Unable to initialize one unnamed product")
        }
        // 打印“Unable to initialize one unnamed product”
        
        //重写一个可失败构造器
        //你可以在子类中重写父类的可失败构造器。或者你也可以用子类的非可失败构造器重写一个父类的可失败构造器。这使你可以定义一个不会构造失败的子类，即使父类的构造器允许构造失败。
        // 注意： 当你用子类的非可失败构造器重写父类的可失败构造器时，向上代理到父类的可失败构造器的唯一方式是对父类的可失败构造器的返回值进行强制解包
        // 注意：你可以用非可失败构造器重写可失败构造器，但反过来却不行
        class Document {
            var name: String?
            // 该构造器创建了一个 name 属性的值为 nil 的 document 实例
            init() {}
            // 该构造器创建了一个 name 属性的值为非空字符串的 document 实例
            init?(name: String) {
                if name.isEmpty {
                    return nil
                }
                self.name = name
            }
        }
        
        //下面这个例子，定义了一个 Document 类的子类 AutomaticallyNamedDocument。这个子类重写了所有父类引入的指定构造器。这些重写确保了无论是使用 init() 构造器，还是使用 init(name:) 构造器，在没有名字或者形参传入空字符串时，生成的实例中的 name 属性总有初始值 "[Untitled]"：
        class AutomaticallyNamedDocument: Document {
            override init() {
                super.init()
                self.name = "[Untitled]"
            }
            override init?(name: String) {
                super.init()
                if name.isEmpty {
                    self.name = "[Untitled]"
                } else {
                    self.name = name
                }
            }
        }
        
        //你可以在子类的不可失败构造器中使用强制解包来调用父类的可失败构造器。比如，下面的 UntitledDocument 子类的 name 属性的值总是 "[Untitled]"，它在构造过程中使用了父类的可失败构造器 init?(name:)：
        class UntitledDocument: Document {
            override init() {
                super.init(name: "[Untitled]")!
            }
        }
        
        // init! 可失败构造器
        // 通常来说我们通过在 init 关键字后添加问号的方式（init?）来定义一个可失败构造器，但你也可以通过在 init 后面添加感叹号的方式来定义一个可失败构造器（init!），该可失败构造器将会构建一个对应类型的隐式解包可选类型的对象。
       // 你可以在 init? 中代理到 init!，反之亦然。你也可以用 init? 重写 init!，反之亦然。你还可以用 init 代理到 init!，不过，一旦 init! 构造失败，则会触发一个断言。
        
        //必要构造器
        // 在类的构造器前添加 required 修饰符表明所有该类的子类都必须实现该构造器：
        class SomeClass {
            required init() {
                // 构造器的实现代码
            }
        }
        
        //子类重写父类的必要构造器时，必须在子类的构造器前也添加 required 修饰符，表明该构造器要求也应用于继承链后面的子类。在重写父类中必要的指定构造器时，不需要添加 override 修饰符
        class SomeSubclass: SomeClass {
            required init() {
                // 构造器的实现代码
            }
        }
        
        //通过闭包或函数设置属性的默认值
        //如果某个存储型属性的默认值需要一些自定义或设置，你可以使用闭包或全局函数为其提供定制的默认值。每当某个属性所在类型的新实例被构造时，对应的闭包或函数会被调用，而它们的返回值会当做默认值赋值给这个属性。
        // 这种类型的闭包或函数通常会创建一个跟属性类型相同的临时变量，然后修改它的值以满足预期的初始状态，最后返回这个临时变量，作为属性的默认值。
        // 下面模板介绍了如何用闭包为属性提供默认值：
        
//        class someClas {
//            let someProP: SomeType = {
//                // 在这个闭包中给 someProperty 创建一个默认值
//                // someValue 必须和 SomeType 类型相同
//                return someValue
//            }()
//        }
        // 注意闭包结尾的花括号后面接了一对空的小括号。这用来告诉 Swift 立即执行此闭包。如果你忽略了这对括号，相当于将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。
        // 注意：如果你使用闭包来初始化属性，请记住在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能在闭包里访问其它属性，即使这些属性有默认值。同样，你也不能使用隐式的 self 属性，或者调用任何实例方法。
       
        //boardColors 数组是通过一个闭包来初始化并设置颜色值的
        //Chessboard 结构体定义了一个属性 boardColors，它是一个包含 64 个 Bool 值的数组。在数组中，值为 true 的元素表示一个黑格，值为 false 的元素表示一个白格。数组中第一个元素代表棋盘上左上角的格子，最后一个元素代表棋盘上右下角的格子。
        struct Chessboard {
            let boardColors: [Bool] = {
                var temporaryBoard = [Bool]()
                var isBlack = false
                for i in 1...8 {
                    for j in 1...8 {
                        temporaryBoard.append(isBlack)
                        isBlack = !isBlack
                    }
                    isBlack = !isBlack
                }
                return temporaryBoard
            }()
            func squareIsBlackAt(row: Int, column: Int) -> Bool {
                return boardColors[(row * 8) + column]
            }
        }
        
        // 每当一个新的 Chessboard 实例被创建时，赋值闭包则会被执行，boardColors 的默认值会被计算出来并返回。上面例子中描述的闭包将计算出棋盘中每个格子对应的颜色，并将这些值保存到一个临时数组 temporaryBoard 中，最后在构建完成时将此数组作为闭包返回值返回。这个返回的数组会保存到 boardColors 中，并可以通过工具函数 squareIsBlackAtRow 来查询：
        let board = Chessboard()
        print(board.squareIsBlackAt(row: 0, column: 1))
        // 打印“true”
        print(board.squareIsBlackAt(row: 7, column: 7))
        // 打印“false”
    }

}
