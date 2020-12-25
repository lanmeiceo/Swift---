//
//  Feature.swift
//  Swift语法
//
//  Created by caowei on 2020/12/24.
//  Copyright © 2020 caowei. All rights reserved.
//  特性

import UIKit

class Feature: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /**声明特性*/
        /**
         discardableResult
         该特性用于的函数或方法声明，以抑制编译器中函数或方法被调用而其返回值没有被使用时的警告。

         */

        /**
         dynamicCallable
         该特性用于类、结构体、枚举或协议，以将该类型的实例视为可调用的函数。该类型必须实现 dynamicallyCall(withArguments:)、dynamicallyCall(withKeywordArguments:) 方法之一，或两者同时实现。
         你可以调用 dynamicCallable特性的实例，就像是调用一个任意数量参数的函数。
         */
        
        let dial = TelephoneExchange()
        // 使用动态方法调用
        dial(4, 1, 1)
        // 打印“Get Swift help on forums.swift.org”

        dial(8, 6, 7, 5, 3, 0, 9)
        // 打印“Unrecognized number”

        // 直接调用底层方法
        dial.dynamicallyCall(withArguments: [4, 1, 1])
        
        //dynamicallyCall(withArguments:) 方法的声明必须至少有一个参数遵循 ExpressibleByArrayLiteral 协议，如 [Int]，而返回值类型可以是任意类型。
        
        // 如果实现 dynamicallyCall(withKeywordArguments:) 方法，则可以在动态方法调用中包含标签。
        let repeatLabels = Repeater()
        print(repeatLabels(a: 1, b: 2, c: 3, b: 2, a: 1))
        // a
        // b b
        // c c c
        // b b
        // a
        
        //如果你同时实现两种 dynamicallyCall 方法，则当在方法调用中包含关键字参数时，会调用 dynamicallyCall(withKeywordArguments:) 方法，否则调用 dynamicallyCall(withArguments:) 方法。

        //你只能调用参数和返回值与 dynamicallyCall 方法实现匹配的动态调用实例。在下面示例的调用无法编译，因为其 dynamicallyCall(withArguments:) 实现不接受 KeyValuePairs<String, String> 参数。
//        repeatLabels(a: "four") // Error
        
        
        
        /**dynamicMemberLookup
         该特性用于类、结构体、枚举或协议，让其能在运行时查找成员。该类型必须实现 subscript(dynamicMemberLookup:) 下标。
         
         在显式成员表达式中，如果指定成员没有相应的声明，则该表达式被理解为对该类型的 subscript(dynamicMemberLookup:) 下标调用，将有关该成员的信息作为参数传递。下标接收参数既可以是键路径，也可以是成员名称字符串；如果你同时实现这两种方式的下标调用，那么以键路径参数方式为准。

         */
        
        //按成员名进行的动态成员查找可用于围绕编译时无法进行类型检查的数据创建包装类型，例如在将其他语言的数据桥接到 Swift 时。例如：
        let s = DynamicStruct()

        // 使用动态成员查找
        let dynamic = s.someDynamicMember
        print(dynamic)
        // 打印“325”

        // 直接调用底层下标
        let equivalent = s[dynamicMember: "someDynamicMember"]
        print(dynamic == equivalent)
        // 打印“true”
        
       // 根据键路径来动态地查找成员，可用于创建一个包裹数据的包装类型，该类型支持在编译时期进行类型检查。例如：
        let point = Point2(x: 381, y: 431)
        let wrapper = PassthroughWrapper(value: point)
        print(wrapper.x)
        
        
        /**
         frozen
         
         针对枚举或者结构体的声明使用该特性，可以限制你对该类型的修改。它只有在编译迭代库时被允许使用。未来版本的库不能通过添加、删除或重新排序枚举的 case 或结构的存储实例属性来更改声明。在未冻结的类型上，这些操作都是允许的，但是他们破坏了冻结类型的 ABI 兼容性。
         
         注意
         当编译器不处于迭代库的模式，所有的结构体和枚举都是隐性冻结，并且该特性会被忽视。
         */
        
        /**
         inlinable
         
         该特性用于函数、方法、计算属性、下标、便利构造器或析构器的声明，以将该声明的实现公开为模块公开接口的一部分。编译器允许在调用处把 inlinable 标记的符号替换为符号实现的副本。
         
         内联代码可以与任意模块中 public 访问级别的符号进行交互，同时可以与在相同模块中标记 usableFromInline 特性的 internal 访问级别的符号进行交互。内联代码不能与 private 或 fileprivate 级别的符号进行交互。
         
         该特性不能用于嵌套在函数内的声明，也不能用于 fileprivate 或 private 访问级别的声明。在内联函数内定义的函数和闭包都是隐式内联的，即使他们不能标记该特性。
         */
        
        /**
         nonobjc
         
         针对方法、属性、下标、或构造器的声明使用该特性将覆盖隐式的 objc 特性。nonobjc 特性告诉编译器该声明不能在 Objective-C 代码中使用，即便它能在 Objective-C 中表示。
         
         该特性用在扩展中，与在没有明确标记为 objc 特性的扩展中给每个成员添加该特性具有相同效果。
         
         可以使用 nonobjc 特性解决标有 objc 的类中桥接方法的循环问题，该特性还允许对标有 objc 的类中的构造器和方法进行重载。
         
         标有 nonobjc 特性的方法不能重写标有 objc 特性的方法。然而，标有 objc 特性的方法可以重写标有 nonobjc 特性的方法。同样，标有 nonobjc 特性的方法不能满足标有 @objc 特性的协议中的方法要求。
         */
        
        
        /**
         objc
         该特性用于修饰任何可以在 Objective-C 中表示的声明。比如，非嵌套类、协议、非泛型枚举（仅限原始值为整型的枚举）、类的属性和方法（包括存取方法）、协议以及协议中的可选成员、构造器以及下标运算符。objc 特性告诉编译器这个声明可以在 Objective-C 代码中使用。
         该特性用在扩展中，与在没有明确标记为 nonobjc 特性的扩展中给每个成员添加该特性具有相同效果。
         编译器隐式地将 objc 特性添加到 Objective-C 中定义的任何类的子类。但是，子类不能是泛型的，并且不能继承于任何泛型类。你可以将 objc 特性显式添加到满足这些条件的子类，来指定其 Objective-C 名称，如下所述。添加了 objc 的协议不能继承于没有此特性的协议。
         在以下情况中同样会隐式的添加 objc 特性：
         父类有 objc 特性，且重写为子类的声明。
         遵循带有 objc 特性协议的声明。
         带有 IBAction、IBSegueAction、IBOutlet、IBDesignable、IBInspectable、NSManaged 或 GKInspectable 特性的声明。
         如果你将 objc 特性应用于枚举，每一个枚举 case 都会以枚举名称和 case 名称组合的方式暴露在 Objective-C 代码中。实例名称的首字母大写。例如，在 Swift 枚举类型 Planet 中有一个名为 Venus 的 case，该 case 暴露在 Objective-C 代码中时叫做 PlanetVenus。
         objc 特性可以接受一个可选的特性参数，由标识符构成。当你想把 objc 所修饰的实体以一个不同的名字暴露给 Objective-C 时，你就可以使用这个特性参数。你可以使用这个参数来命名类、枚举类型、枚举 case、协议、方法、存取方法以及构造器。如果你要指定类、协议或枚举在 Objective-C 下的名称，请在名称上包含三个字母的前缀，就像 Objective-C 编程 中的 约定描述的一样。下面的例子把 ExampleClass 中的 enabled 属性的取值方法暴露给 Objective-C，名字是 isEnabled，而不是它原来的属性名。

         */
        
        /**
         propertyWrapper
         在类、结构体或者枚举的声明时使用该特性，可以让其成为一个属性包装器。如果将该特性应用在一个类型上，将会创建一个与该类型同名的自定义特性。将这个新的特性用于类、结构体、枚举的属性，则可以通过包装器的实例封装对该属性的访问。局部和全局变量不能使用属性包装器。
         包装器必须定义一个 wrappedValue 实例属性。该属性 wrapped value 是该属性存取方法暴露的值。大多数时候，wrappedValue 是一个计算属性，但它可以是一个存储属性。包装器负责定义和管理其包装值所需的任何底层存储。编译器通过在包装属性的名称前加下划线（_）来为包装器的实例提供同步存储。例如，someProperty 的包装器存储为 _someProperty。包装器的同步存储具有 private 的访问控制级别。
         拥有属性包装器的属性可以包含 willSet 和 didSet 闭包，但是不能重写编译器合成的 get 和 set 闭包。
         Swift 为属性包装器的构造函数提供了两种形式的语法糖。可以在包装值的定义中使用赋值语法，将赋值语句右侧的表达式作为值传递给属性包装器构造函数中的 wrappedValue 参数。同样的，你也可以为包装器提供一些参数，这些参数将会传递给包装器的构造函数。就像下面的例子，SomeStruct 中，定义 SomeWrapper 的地方各自调用了对应的构造函数。
         */
        
        /**网上Demo*/
        // https://www.jianshu.com/p/ff4c048f0cf4
        
        ///具体的业务代码。
        UserDefaultsConfig.hadShownGuideView = false
        print(UserDefaultsConfig.hadShownGuideView) // false
        UserDefaultsConfig.hadShownGuideView = true
        print(UserDefaultsConfig.hadShownGuideView) // true
        
        
        //属性包装器中 projected value 是它可以用来暴露额外功能的第二个值。属性包装器的作者负责确认其映射值的含义并定义公开映射值的接口。若要通过属性包装器来映射值，请在包装器的类型上定义 projectedValue 实例属性。编译器通过在包装属性的名称前面加上美元符号（$）来合成映射值的标识符。例如，someProperty 的映射值是 $someProperty。映射值具有与原始包装属性相同的访问控制级别 ???
        let se = SomeStruct2()
        se.x           // Int value
        se.$x          // SomeProjection value
        se.$x.wrapper  // WrapperWithProjection value

        
    }
}

@dynamicCallable
struct TelephoneExchange {
    func dynamicallyCall(withArguments phoneNumber: [Int]) {
        if phoneNumber == [4, 1, 1] {
            print("Get Swift help on forums.swift.org")
        } else {
            print("Unrecognized number")
        }
    }
}

@dynamicCallable
struct Repeater {
    func dynamicallyCall(withKeywordArguments pairs: KeyValuePairs<String, Int>) -> String {
        return pairs
            .map { label, count in
                repeatElement(label, count: count).joined(separator: " ")
            }
            .joined(separator: "\n")
    }
}

@dynamicMemberLookup
struct DynamicStruct {
    let dictionary = ["someDynamicMember": 325,
                      "someOtherMember": 787]
    subscript(dynamicMember member: String) -> Int {
        return dictionary[member] ?? 1054
    }
}

struct Point2 { var x, y: Int }

@dynamicMemberLookup
struct PassthroughWrapper<Value> {
    var value: Value
    subscript<T>(dynamicMember member: KeyPath<Value, T>) -> T {
         get { return value[keyPath: member] }
     }
}


@propertyWrapper
struct SomeWrapper {
    var wrappedValue: Int
    var someValue: Double
    init() {
        self.wrappedValue = 100
        self.someValue = 12.3
    }
    init(wrappedValue: Int) {
        self.wrappedValue = wrappedValue
        self.someValue = 45.6
    }
    init(wrappedValue value: Int, custom: Double) {
        self.wrappedValue = value
        self.someValue = custom
    }
}

struct SomeStruct {
    // 使用 init()
    @SomeWrapper var a: Int

    // 使用 init(wrappedValue:)
    @SomeWrapper var b = 10

    // 两个都是使用 init(wrappedValue:custom:)
    @SomeWrapper(custom: 98.7) var c = 30
    @SomeWrapper(wrappedValue: 30, custom: 98.7) var d
}

@propertyWrapper
struct WrapperWithProjection {
    var wrappedValue: Int
    var projectedValue: SomeProjection {
        return SomeProjection(wrapper: self)
    }
}
struct SomeProjection {
    var wrapper: WrapperWithProjection
}

struct SomeStruct2 {
    @WrapperWithProjection var x = 123
}



/**网上Demo*/
@propertyWrapper
struct UserDefault<T> {
    ///这里的属性key 和 defaultValue 还有init方法都是实际业务中的业务代码
    ///我们不需要过多关注
    let key: String
    let defaultValue: T
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    ///  wrappedValue是@propertyWrapper必须要实现的属性
    /// 当操作我们要包裹的属性时  其具体set get方法实际上走的都是wrappedValue 的set get 方法。
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}

///封装一个UserDefault配置文件
struct UserDefaultsConfig {
///告诉编译器 我要包裹的是hadShownGuideView这个值。
///实际写法就是在UserDefault包裹器的初始化方法前加了个@
/// hadShownGuideView 属性的一些key和默认值已经在 UserDefault包裹器的构造方法中实现

    @UserDefault("had_shown_guide_view", defaultValue: false)
    static var hadShownGuideView: Bool
}

// 当添加新的key去保存数据的时候只用在UserDefaultsConfig 中添加新的属性和包裹器就行

struct UserDefaultsConfig2 {
    @UserDefault("had_shown_guide_view", defaultValue: false)
    static var hadShownGuideView: Bool
    ///保存用户名称
    @UserDefault("username", defaultValue: "unknown")
    static var username: String
}

