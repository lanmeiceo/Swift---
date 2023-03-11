//
//  ViewController.swift
//  Swift语法
//
//  Created by caowei on 2020/5/29.
//  Copyright © 2020 caowei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         简单值
         */
        //使用 let 来声明常量，使用 var 来声明变量。一个常量的值，在编译的时候，并不需要有明确的值，但是你只能为它赋值一次。这说明你可以用一个常量来命名一个值，一次赋值就可在多个地方使用。
        var myvar = 20
        myvar = 15
        print(myvar)
        
        //初始值没有提供足够的信息（或者没有初始值），那你需要在变量后面声明类型，用冒号分割
        let idou : Float = 17
        print(idou)
        
        //当推断浮点数的类型时，Swift 总是会选择 Double 而不是 Float。
        //如果表达式中同时出现了整数和浮点数，会被推断为 Double 类型：
        let anotherPi = 3 + 0.14159//// anotherPi 会被推测为 Double 类型
        
        //这个例子中，常量 three 的值被用来创建一个 Double 类型的值，所以加号两边的数类型须相同。如果不进行转换，两者无法相加。
        let three = 3
        let pointo = 0.141
        let pi = Double(three) + pointo
        
        //浮点数到整数的反向转换同样行，整数类型可以用 Double 或者 Float 类型来初始化：
        //当用这种方式来初始化一个新的整数值时，浮点值会被截断。也就是说 4.75 会变成 4，-3.9 会变成 -3。
        let integerPi = Int(pi)// integerPi 等于 3，所以被推测为 Int 类型
        
        /**初始化空字符串*/
        let emptyString = ""               // 空字符串字面量
        let anotherEmptyString = String()  // 初始化方法
        // 两个字符串均为空并等价。
        print(emptyString,anotherEmptyString)
        
        //你可以通过检查 Bool 类型的 isEmpty 属性来判断该字符串是否为空：
        if emptyString.isEmpty {
             print("空空")
        }
        
        /**使用字符*/
        // for-in 循环来遍历字符串，获取字符串中每一个字符的值
        for character in "Dog!🐶" {
            print(character)
        }
        /**
         D
         o
         g
         !
         🐶
         */
        
        //符串可以通过传递一个值类型为 Character 的数组作为自变量来初始化
        let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
        let catString = String(catCharacters)
        print(catString)
        // 打印输出：“Cat!🐱”
        
        /**连接字符串和字符*/
        //字符串可以通过加法运算符（+）相加在一起（或称“连接”）创建一个新的字符串：
        let string1 = "hello"
        let string2 = " there"
        var welcome = string1 + string2
        print(welcome)
        // welcome 现在等于 "hello there"
                
        //如果你需要使用多行字符串字面量来拼接字符串，并且你需要字符串每一行都以换行符结尾，包括最后一行：
        let badStart = """
        one
        two
        """
        let end = """
        three
        """
        print(badStart + end)
        // 打印两行:
        // one
        // twothree

        let goodStart = """
        one
        two

        """
        print(goodStart + end)
        // 打印三行:
        // one
        // two
        // three
        
        //你也可以通过加法赋值运算符（+=）将一个字符串添加到一个已经存在字符串变量上
        var instruction = "look over"
        instruction += string2
        print(instruction)
        
       //你可以用 append() 方法将一个字符附加到一个字符串变量的尾部
        let exclamationMark: Character = "!"
        welcome.append(exclamationMark)//"hello there!"
        print(welcome)
        
        //注意:你不能将一个字符串或者字符添加到一个已经存在的字符变量上，因为字符变量只能包含一个字符

        
        //值永远不会被隐式转换为其他类型。如果你需要把一个值转换成其他类型，请显式转换。
        let label = "the label is"
        let w = 94
        let labelw = label + String(w)
        print(labelw)
        
        //有一种更简单的把值转换成字符串的方法：把值写到括号中，并且在括号之前写一个反斜杠（\）
        let apples = 3
        let oranges = 5
        let  apppleSum = "I have \(apples) apples"
        print(apppleSum)
        
        //使用三个双引号（"""）来包含多行字符串内容。每行行首的缩进会被去除，直到和结尾引号的缩进相匹配
        let quotation = """
        I said "I have \(apples) apples."
        And then I said "I have \(apples + oranges) pieces of fruit."
        """
        print(quotation)
        
        //如果你的代码中，多行字符串字面量包含换行符的话，则多行字符串字面量中也会包含换行符。如果你想换行，以便加强代码的可读性，但是你又不想在你的多行字符串字面量中出现换行符的话，你可以用在行尾写一个反斜杠（\）作为续行符
        let softWrappedQuotation = """
        The White Rabbit put on his spectacles.  "Where shall I begin, \
        please your Majesty?" he asked.

        "Begin at the beginning," the King said gravely, "and go on \
        till you come to the end; then stop."
        """
        print(softWrappedQuotation)
        //为了让一个多行字符串字面量开始和结束于换行符，请将换行写在第一行和最后一行，例如：
        let lineBreaks = """

        This string starts with a line break.
        It also ends with a line break.

        """
        print(lineBreaks)
        
        
        /**字符串插值:字符串插值是一种构建新字符串的方式，可以在其中包含常量、变量、字面量和表达式。字符串字面量和多行字符串字面量都可以使用字符串插值。你插入的字符串字面量的每一项都在以反斜线为前缀的圆括号中*/
        //插值字符串中写在括号中的表达式不能包含非转义反斜杠（\），并且不能包含回车或换行符。不过，插值字符串可以包含其他字面量
        let multiplier = 3
        let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
        // message 是 "3 times 2.5 is 7.5"
        
        /**字符串字面量的特殊字符*/
        let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
        print(wiseWords)//输出"Imagination is more important than knowledge" - Einstein
        let dollarSign = "\u{24}"             // $，Unicode 标量 U+0024
        let blackHeart = "\u{2665}"           // ♥，Unicode 标量 U+2665
        let sparklingHeart = "\u{1F496}"      // 💖，Unicode 标量 U+1F496
        print(dollarSign,blackHeart,sparklingHeart)
        //由于多行字符串字面量使用了三个双引号，而不是一个，所以你可以在多行字符串字面量里直接使用双引号（"）而不必加上转义符（\）。要在多行字符串字面量中使用 """ 的话，就需要使用至少一个转义符（\）
        let threeDoubleQuotes = """
        Escaping the first quote \"""
        Escaping all three quotes \"\"\"
        """
        print(threeDoubleQuotes)
        /**输出
         Escaping the first quote """
         Escaping all three quotes """
         */
        
        /**扩展字符串分隔符*/
        /**您可以将字符串文字放在扩展分隔符中，这样字符串中的特殊字符将会被直接包含而非转义后的效果。将字符串放在引号（"）中并用数字符号（#）括起来。例如，打印字符串文字 #"Line 1 \nLine 2"# 会打印换行符转义序列（\n）而不是给文字换行。
        如果需要字符串文字中字符的特殊效果，请匹配转义字符（\）后面添加与起始位置个数相匹配的 # 符。 例如，如果您的字符串是 #"Line 1 \nLine 2"# 并且您想要换行，则可以使用 #"Line 1 \#nLine 2"# 来代替。 同样，###"Line1 \###nLine2"### 也可以实现换行效果。*/
        let threeMoreDoubleQuotationMarks = #"""
        Here are three more double quotes: """
        """#
        print(threeMoreDoubleQuotationMarks)//输出Here are three more double quotes: """
        let tests = ###"Line1 \###nLine2"###
        print(tests)

        /**字符串索引*/
        /**
        每一个 String 值都有一个关联的索引（index）类型，String.Index，它对应着字符串中的每一个 Character 的位置
         前面提到，不同的字符可能会占用不同数量的内存空间，所以要知道 Character 的确定位置，就必须从 String 开头遍历每一个 Unicode 标量直到结尾。因此，Swift 的字符串不能用整数（integer）做索引。
         使用 startIndex 属性可以获取一个 String 的第一个 Character 的索引。使用 endIndex 属性可以获取最后一个 Character 的后一个位置的索引。因此，endIndex 属性不能作为一个字符串的有效下标。如果 String 是空串，startIndex 和 endIndex 是相等的。
         通过调用 String 的 index(before:) 或 index(after:) 方法，可以立即得到前面或后面的一个索引。你还可以通过调用 index(_:offsetBy:) 方法来获取对应偏移量的索引，这种方式可以避免多次调用 index(before:) 或 index(after:) 方法
         */
        let greeting = "Guten Tag!"
        greeting[greeting.startIndex]//G
        greeting[greeting.index(before: greeting.endIndex)]//!
        greeting[greeting.index(after: greeting.startIndex)]//u
        let index = greeting.index(greeting.startIndex, offsetBy: 7)
        greeting[index]//a
        
        //试图获取越界索引对应的 Character，将引发一个运行时错误。
//        greeting[greeting.endIndex] // error
//        greeting.index(after: greeting.endIndex) // error
 
        //使用 indices 属性会创建一个包含全部索引的范围（Range），用来在一个字符串中访问单个字符。
        for idx in greeting.indices {
            print("\(greeting[idx]) ", terminator: "")
        }//G u t e n   T a g !
        //注意:你可以使用 startIndex 和 endIndex 属性或者 index(before:) 、index(after:) 和 index(_:offsetBy:) 方法在任意一个确认的并遵循 Collection 协议的类型里面，如上文所示是使用在 String 中，你也可以使用在 Array、Dictionary 和 Set 中。
        
        /**
         布尔值:Swift 有两个布尔常量，true 和 false
         */
        //如果你在需要使用 Bool 类型的地方使用了非布尔值，Swift 的类型安全机制会报错。下面的例子会报告一个编译时错误：
        let i = 1
        if i == 1 {
            // 这个例子会编译成功(写成if i不会通过编译，会报错)
        }
        /**插入和删除*/
        //调用 insert(_:at:) 方法可以在一个字符串的指定索引插入一个字符，调用 insert(contentsOf:at:) 方法可以在一个字符串的指定索引插入一个段字符串
        var welcomeStr = "hello"
        welcomeStr.insert("!", at: welcomeStr.endIndex)// "hello!"
        welcomeStr.insert(contentsOf: " there", at: welcomeStr.index(before: welcomeStr.endIndex))//"hello there!"
        print(welcomeStr)
        
        //调用 remove(at:) 方法可以在一个字符串的指定索引删除一个字符，调用 removeSubrange(_:) 方法可以在一个字符串的指定索引删除一个子字符串
        welcomeStr.remove(at: welcomeStr.index(before: welcomeStr.endIndex))//"hello there"
        let range = welcome.index(welcomeStr.endIndex, offsetBy: -6)..<welcomeStr.endIndex
        welcomeStr.removeSubrange(range)//"hello"
        //注意：你可以使用 insert(_:at:)、insert(contentsOf:at:)、remove(at:) 和 removeSubrange(_:) 方法在任意一个确认的并遵循 RangeReplaceableCollection 协议的类型里面，如上文所示是使用在 String 中，你也可以使用在 Array、Dictionary 和 Set 中
        
        /**子字符串*/
        let greetingStr = "Hello, world!"
        let gIndex = greetingStr.firstIndex(of: ",") ?? greetingStr.endIndex
        let beginning = greetingStr[..<gIndex]//"Hello"
        // 把结果转化为 String 以便长期存储。
        let newStr = String(beginning)
        print(newStr)
        /**
         就像 String，每一个 Substring 都会在内存里保存字符集。而 String 和 Substring 的区别在于性能优化上，Substring 可以重用原 String 的内存空间，或者另一个 Substring 的内存空间（String 也有同样的优化，但如果两个 String 共享内存的话，它们就会相等）。这一优化意味着你在修改 String 和 Substring 之前都不需要消耗性能去复制内存。就像前面说的那样，Substring 不适合长期存储 —— 因为它重用了原 String 的内存空间，原 String 的内存空间必须保留直到它的 Substring 不再被使用为止。

         上面的例子，greeting 是一个 String，意味着它在内存里有一片空间保存字符集。而由于 beginning 是 greeting 的 Substring，它重用了 greeting 的内存空间。相反，newString 是一个 String —— 它是使用 Substring 创建的，拥有一片自己的内存空间。下面的图展示了他们之间的关系：
         */
        
        /**比较字符串*/
        //Swift 提供了三种方式来比较文本值：字符串字符相等、前缀相等和后缀相等
        
        /**
         集合的可变性
         如果创建一个数组、集合或字典并且把它分配成一个变量，这个集合将会是可变的。这意味着可以在创建之后添加、修改或者删除数据项。如果把数组、集合或字典分配成常量，那么它就是不可变的，它的大小和内容都不能被改变。
         */
        

        /**数组:数组使用有序列表存储同一类型的多个值。相同的值可以多次出现在一个数组的不同位置中*/
        /**Swift 中数组的完整写法为 Array<Element>，其中 Element 是这个数组中唯一允许存在的数据类型。也可以使用像 [Element] 这样的简单语法。尽管两种形式在功能上是一样的，但是推荐较短的那种，而且在本文中都会使用这种形式来使用数组。*/
        //1.你可以使用构造语法来创建一个由特定数据类型构成的空数组
        var someInts = [Int]()//通过构造函数的类型，someInts 的值类型被推断为 [Int]
        //如果代码上下文中已经提供了类型信息，例如一个函数参数或者一个已经定义好类型的常量或者变量，你可以使用空数组语句创建一个空数组，它的写法很简单：[]（一对空方括号）
        someInts.append(3333)//someInts 现在包含一个 Int 值[3333]
        someInts = []// someInts 现在是空数组，但是仍然是 [Int] 类型的。
        print(someInts)
        //2.创建一个带有默认值的数组
        /**Swift 中的 Array 类型还提供一个可以创建特定大小并且所有数据都被默认的构造方法。可以把准备加入新数组的数据项数量（count）和适当类型的初始值（repeating）传入数组构造函数*/
        let threeDoubles = Array(repeating: 0.0, count: 3)//threeDoubles 是一种 [Double] 数组，等价于 [0.0, 0.0, 0.0]
        //3.通过两个数组相加创建一个数组
        let anotherThreeDoubles = Array(repeating: 2.5, count: 3)// anotherThreeDoubles 被推断为 [Double]，等价于 [2.5, 2.5, 2.5]
        let sixDoubles = threeDoubles + anotherThreeDoubles// sixDoubles 被推断为 [Double]，等价于 [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
        print(sixDoubles)
        
        //4.用数组字面量构造数组
        //shoppingList 并且存储 String 的数组
        //注意:shoppingList 数组被声明为变量（var 关键字创建）而不是常量（let 创建）是因为之后会有更多的数据项被插入其中。
        var shopList: [String] = ["鸡蛋", "牛奶"]
        
        //5.访问和修改数组
        //5.1可以使用数组的只读属性 count 来获取数组中的数据项数量
        //5.2使用布尔属性 isEmpty 作为一个缩写形式去检查 count 属性是否为 0
        if shopList.isEmpty {
        }
        //5.3也可以使用 append(_:) 方法在数组后面添加新的数据项：
        shopList.append("面粉")
        //5.4也可以使用加法赋值运算符（+=）直接将另一个相同类型数组中的数据添加到该数组后面：
        shopList += ["发酵粉"]
        shopList += ["奶酪", "奶油", "火腿肠"]
        print(shopList)//["鸡蛋", "牛奶", "面粉", "发酵粉", "奶酪", "奶油", "火腿肠"] //7项
        //5.5还可以利用下标来一次改变一系列数据值，即使新数据和原有数据的数量是不一样的
        shopList[4...6] = ["香蕉", "苹果"]
        print(shopList)//["鸡蛋", "牛奶", "面粉", "发酵粉", "香蕉", "苹果"] //6项
        //5.6通过调用数组的 insert(_:at:) 方法在某个指定索引值之前添加数据项
        shopList.insert("梨子", at: 0)//remove(at:)移除
        //5.7如果你只想把数组中的最后一项移除，可以使用 removeLast() 方法而不是 remove(at:) 方法来避免需要获取数组的 count 属性。就像后者一样，前者也会返回被移除的数据项：
        shopList.removeLast()
        
        //6.数组的遍历
        //6.1你可以使用 for-in 循环来遍历数组中所有的数据项：
        for item in shopList {
            print(item)
        }
        //6.2如果同时需要每个数据项的值和索引值，可以使用 enumerated() 方法来进行数组遍历。enumerated() 返回一个由索引值和数据值组成的元组数组。索引值从零开始，并且每次增加一；如果枚举一整个数组，索引值将会和数据值一一匹配。你可以把这个元组分解成临时常量或者变量来进行遍历
        for (index, value) in shopList.enumerated() {
            print("Item \(String(index + 1)): \(value)")
        }
        
        
        /**集合类型语法*/
        //Swift 中的集合类型被写为 Set<Element>，这里的 Element 表示集合中允许存储的类型。和数组不同的是，集合没有等价的简化形式。
        //创建和构造一个空的集合
        var letters = Set<Character>()//通过构造器，这里 letters 变量的类型被推断为 Set<Character>
        //如果上下文提供了类型信息，比如作为函数的参数或者已知类型的变量或常量，你可以通过一个空的数组字面量创建一个空的集合
        letters.insert("a")//letters 现在含有1个 Character 类型的值
        letters = []//letters 现在是一个空的 Set，但是它依然是 Set<Character> 类型
        
        var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
        // favoriteGenres 被构造成含有三个初始值的集合,<String>可省略，Swift 可以推断出 Set<String>
        
        //访问和修改一个集合
        //使用布尔属性 isEmpty 作为一个缩写形式去检查 count 属性是否为 0
        //你可以通过调用集合的 insert(_:) 方法来添加一个新元素：
        //你可以通过调用集合的 remove(_:) 方法去删除一个元素
        //使用 contains(_:) 方法去检查集合中是否包含一个特定的值
        //通过调用集合的 remove(_:) 方法去删除一个元素，如果它是该集合的一个元素则删除它并且返回它的值，若该集合不包含它，则返回 nil。另外，集合可以通过 removeAll() 方法删除所有元素。
        if let removedGenre = favoriteGenres.remove("Rock") {
            print("\(removedGenre)? I'm over it.")//removedGenre返回的是Rock⚠️
            print(favoriteGenres)//["Classical", "Hip hop"]
        } else {
            print("I never much cared for that.")
        }
        //遍历一个集合
        for gen in favoriteGenres {
            print(gen)
        }
        //Swift 的 Set 类型没有确定的顺序，为了按照特定顺序来遍历一个集合中的值可以使用 sorted() 方法，它将返回一个有序数组，这个数组的元素排列顺序由操作符 < 对元素进行比较的结果来确定
        for gen in favoriteGenres.sorted() {
            print(gen)
        }
        
        //集合操作:把两个集合组合到一起，判断两个集合共有元素，或者判断两个集合是否全包含，部分包含或者不相交
        /**
         使用 intersection(_:) 方法根据两个集合的交集创建一个新的集合。
         使用 symmetricDifference(_:) 方法根据两个集合不相交的值创建一个新的集合。
         使用 union(_:) 方法根据两个集合的所有值创建一个新的集合。
         使用 subtracting(_:) 方法根据不在另一个集合中的值创建一个新的集合(减法)
         */
        let oddDigits: Set = [1, 3, 5, 7, 9]
        let evenDigits: Set = [0, 2, 4, 6, 8]
        let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
        oddDigits.union(evenDigits).sorted()// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        oddDigits.intersection(evenDigits).sorted()//[]
        oddDigits.subtracting(singleDigitPrimeNumbers).sorted()//[1,9]
        oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()//[1,2,9]
        
        //集合成员关系和相等
        /**
         使用“是否相等”运算符（==）来判断两个集合包含的值是否全部相同。
         使用 isSubset(of:) 方法来判断一个集合中的所有值是否也被包含在另外一个集合中。
         使用 isSuperset(of:) 方法来判断一个集合是否包含另一个集合中所有的值。
         使用 isStrictSubset(of:) 或者 isStrictSuperset(of:) 方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。
         使用 isDisjoint(with:) 方法来判断两个集合是否不含有相同的值（是否没有交集）
         */
        let houseAnimals: Set = ["🐶", "🐱"]
        let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
        let cityAnimals: Set = ["🐦", "🐭"]

        houseAnimals.isSubset(of: farmAnimals)
        // true
        farmAnimals.isSuperset(of: houseAnimals)
        // true
        farmAnimals.isDisjoint(with: cityAnimals)
        // true
        
        
        /**
         字典
         */
        //1.创建一个空字典
        var namesOfIntegers = [Int: String]()// namesOfIntegers 是一个空的 [Int: String] 字典
        //这个例子创建了一个 [Int: String] 类型的空字典来储存整数的英语命名。它的键是 Int 型，值是 String 型。
        //如果上下文已经提供了类型信息，你可以使用空字典字面量来创建一个空字典，记作 [:] （一对方括号中放一个冒号）：
        namesOfIntegers[16] = "sixteen"// namesOfIntegers 现在包含一个键值对
        namesOfIntegers = [:]//namesOfIntegers 又成为了一个 [Int: String] 类型的空字典
        
        //2.用字典字面量创建字典
        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        //注意:airports 字典被声明为变量（用 var 关键字）而不是常量（用 let 关键字）因为后面会有更多的机场信息被添加到这个字典中。
        //访问和修改字典
        //使用布尔属性 isEmpty 作为一个缩写形式去检查 count 属性是否为 0
        //updateValue(_:forKey:) 这个方法返回更新值之前的原值。这样使得你可以检查更新是否成功。
        if let oldValue = airports.updateValue("BeiJing", forKey: "DUB") {
            print("The old value for DUB was \(oldValue).")//The old value for DUB was Dublin.
        }
        //使用下标语法通过将某个键的对应值赋值为 nil 来从字典里移除一个键值对
        airports["YYZ"] = nil
        print("移除后\(airports)")
 
        //字典遍历
        for airportCode in airports.keys {
            print("Airport code: \(airportCode)")
        }
        let airportCodes = [String](airports.keys)
        print(airportCodes)
        
        
        
        /**
         元组：把多个值组合成一个复合值。元组内的值可以是任意类型，并不要求是相同类型
         */
        // http404Error 的类型是 (Int, String)，值是 (404, "Not Found")
        let http404Error = (404, "Not Found")
        //你可以将一个元组的内容分解（decompose）成单独的常量和变量，然后你就可以正常使用它们
        let (statusCode, statusMessage) = http404Error
        print("The status code is \(statusCode)")// 输出“The status code is 404”
        print("The status message is \(statusMessage)")// 输出“The status message is Not Found”
        
        //如果你只需要一部分元组值，分解的时候可以把要忽略的部分用下划线（_）标记
        let (justTheStatusCode,_) = http404Error
        print("The status code is \(justTheStatusCode)")//输出The status code is 404
        
        //此外，你还可以通过下标来访问元组中的单个元素，下标从零开始：
        print("The status code is \(http404Error.0)")
        
        //你可以在定义元组的时候给单个元素命名
        let http200Status = (statusCode: 200, description: "OK")
        //给元组中的元素命名后，你可以通过名字来获取这些元素的值：
        print("状态码是 \(http200Status.statusCode)")
        
        
        //使用方括号 [] 来创建数组和字典，并使用下标或者键（key）来访问元素。最后一个元素后面允许有个逗号
        var shoppingList = ["catfish","water","tulips","bule oaint"]
        shoppingList[1] = "nowater"
        
        var occupations = [
            "Malcolm": "Captain",
            "Kaylee": "Mechanic",
        ]
        occupations["Jayne"] = "Public Relations"
        print(shoppingList,occupations)
        
        //数组在添加元素时会自动变大。
        shoppingList.append("blue paint")
        print(shoppingList)
        
        //使用初始化语法来创建一个空数组或者空字典
        let emptyArray = [String]()
        let emptyDic = [String: Float]()
        print(emptyArray,emptyDic)//[] [:]
        
        /**
         可选类型
         */
        
        let possibleNumber = "123"
        let convertedNumber = Int(possibleNumber)
        // convertedNumber 被推测为类型 "Int?"， 或者类型 "optional Int"
        
        /**nil*/
        //nil不能用于非可选的常量和变量。如果你的代码中有常量或者变量需要处理值缺失的情况，请把它们声明成对应的可选类型。
        var serverResponseCode: Int? = 404
        // serverResponseCode 包含一个可选的 Int 值 404
        serverResponseCode = nil
        // serverResponseCode 现在不包含值

        //如果你声明一个可选常量或者变量但是没有赋值，它们会自动被设置为 nil
        var surveyAnswer: String?// surveyAnswer 被自动设置为 nil
        
       //注意:Swift 的 nil 和 Objective-C 中的 nil 并不一样。在 Objective-C 中，nil 是一个指向不存在对象的指针。在 Swift 中，nil 不是指针——它是一个确定的值，用来表示值缺失。任何类型的可选状态都可以被设置为 nil，不只是对象类型
        
        /**if 语句以及强制解析*/
        //你可以使用 if 语句和 nil 比较来判断一个可选值是否包含值。你可以使用“相等”(==)或“不等”(!=)来执行比较
        //如果可选类型有值，它将不等于 nil
        if convertedNumber != nil {
            print("convertedNumber contains some integer value.")
        }// 输出“convertedNumber contains some integer value.”
        //当你确定可选类型确实包含值之后，你可以在可选的名字后面加一个感叹号（!）来获取值。这个惊叹号表示“我知道这个可选有值，请使用它。”这被称为可选值的强制解析
        if convertedNumber != nil {
            print("convertedNumber has an integer value of \(convertedNumber!).")
        }// 输出“convertedNumber has an integer value of 123.”
        //注意：使用 ! 来获取一个不存在的可选值会导致运行时错误。使用 ! 来强制解析值之前，一定要确定可选包含一个非 nil 的值。
        
        /**比较运算符*/
        //如果两个元组的元素相同，且长度相同的话，元组就可以被比较。比较元组大小会按照从左到右、逐值比较的方式，直到发现有两个值不等时停止。如果所有的值都相等，那么这一对元组我们就称它们是相等的
        (1, "zebra") < (2, "apple")   // true，因为 1 小于 2
        (3, "apple") < (3, "bird")    // true，因为 3 等于 3，但是 apple 小于 bird
        (4, "dog") == (4, "dog")      // true，因为 4 等于 4，dog 等于 dog
        ("blue", -1) < ("purple", 1)       // 正常，比较的结果为 true
        //Bool 不能被比较，也意味着存有布尔类型的元组不能被比较。
        //("blue", false) < ("purple", true) // 错误，因为 < 不能比较布尔类型
        
        /**空合运算符*/
        //关于??可以看看https://www.jianshu.com/p/fbbbfa923b19
        //空合运算符（a ?? b）将对可选类型 a 进行空判断，如果 a 包含一个值就进行解包，否则就返回一个默认值 b。表达式 a 必须是 Optional 类型。默认值 b 的类型必须要和 a 存储值的类型保持一致。
       //空合运算符是对以下代码的简短表达方法
       // a != nil ? a! : b//当可选类型 a 的值不为空时，进行强制解封（a!），访问 a 中的值；反之返回默认值 b。无疑空合运算符（??）提供了一种更为优雅的方式去封装条件判断和解封两种行为，显得简洁以及更具可读性。
        let defaultColorName = "red"
        var userDefinedColorName: String?   //默认值为 nil
        var colorNameToUse = userDefinedColorName ?? defaultColorName// userDefinedColorName 的值为空，所以 colorNameToUse 的值为 "red"
        //如果你分配一个非空值（non-nil）给 userDefinedColorName，再次执行空合运算，运算结果为封包在 userDefinedColorName 中的值，而非默认值。
        
        
        /**
         可选绑定
         */
        // if let语法https://zhuanlan.zhihu.com/p/398144919
        //  if let 连用,判断对象的值是否为'nil',if var的用法, 和if let的区别就是可以在{ }内修改变量的值

        if let actualNumber = Int(possibleNumber) {
            print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
        } else {
            print("\'\(possibleNumber)\' could not be converted to an integer")
        }// 输出“'123' has an integer value of 123”
        
        //下面的两个 if 语句是等价的：
        if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }// 输出“4 < 42 < 100”

        if let firstNumber = Int("4") {
            if let secondNumber = Int("42") {
                if firstNumber < secondNumber && secondNumber < 100 {
                    print("\(firstNumber) < \(secondNumber) < 100")
                }
            }
        }// 输出“4 < 42 < 100”
        
        /**隐式解析可选类型*/
        //有时候在程序架构中，第一次被赋值之后，可以确定一个可选类型总会有值。在这种情况下，每次都要判断和解析可选值是非常低效的，因为可以确定它总会有值。
        //这种类型的可选状态被定义为隐式解析可选类型（implicitly unwrapped optionals）。把想要用作可选的类型的后面的问号（String?）改成感叹号（String!）来声明一个隐式解析可选类型
        //一个隐式解析可选类型其实就是一个普通的可选类型，但是可以被当做非可选类型来使用，并不需要每次都使用解析来获取可选值。下面的例子展示了可选类型 String 和隐式解析可选类型 String 之间的区别
        let possibleString: String? = "An optional string."
        let forcedString: String = possibleString! // 需要感叹号来获取值

        let assumedString: String! = "An implicitly unwrapped optional string."
        let implicitString: String = assumedString  // 不需要感叹号
        //注意：如果你在隐式解析可选类型没有值的时候尝试取值，会触发运行时错误。和你在没有值的普通可选类型后面加一个惊叹号一样。
        
        //你仍然可以把隐式解析可选类型当做普通可选类型来判断它是否包含值
        if assumedString != nil {
            print(assumedString!)
        }// 输出“An implicitly unwrapped optional string.”
        //你也可以在可选绑定中使用隐式解析可选类型来检查并解析它的值：
        if let definiteString = assumedString {
            print(definiteString)
        }// 输出“An implicitly unwrapped optional string.”
        //注意：如果一个变量之后可能变成 nil 的话请不要使用隐式解析可选类型。如果你需要在变量的生命周期中判断是否是 nil 的话，请使用普通可选类型。
        
        /**
         使用断言进行调试
         */
        //你可以调用 Swift 标准库的 assert(_:_:file:line:) 函数来写一个断言。向这个函数传入一个结果为 true 或者 false 的表达式以及一条信息，当表达式的结果为 false 的时候这条信息会被显示
        let age = -3
//        assert(age > 0, "年龄不得小于0")// 因为 age < 0，所以断言会触发,终止应用。
//        assert(age >= 0)//如果不需要断言信息，可以就像这样忽略掉：
        
        /**强制执行先决条件*/
        //当一个条件可能为假，但是继续执行代码要求条件必须为真的时候，需要使用先决条件。例如使用先决条件来检查是否下标越界，或者来检查是否将一个正确的参数传给函数
        //你可以使用全局 precondition(_:_:file:line:) 函数来写一个先决条件。向这个函数传入一个结果为 true 或者 false 的表达式以及一条信息，当表达式的结果为 false 的时候这条信息会被显示
         //// 在一个下标的实现里...
        let index2 = 1
        precondition(index2 > 0, "Index must be greater than zero.")
        //你可以调用 preconditionFailure(_:file:line:) 方法来表明出现了一个错误，例如，switch 进入了 default 分支，但是所有的有效值应该被任意一个其他分支（非 default 分支）处理。
        
        //断言Assert仅在调试环境运行，先决条件precondition则在调试环境和生产环境中运行。
        
        
        /**
         控制流
         */
        
        //使用 if 和 switch 来进行条件操作，使用 for-in、while 和 repeat-while 来进行循环。包裹条件和循环变量的括号可以省略，但是语句体的大括号是必须的。
        let individualScores = [75, 43, 103, 87, 12]
        var teamScore = 0
        for score in individualScores {
            if score > 50 {
                teamScore += 3
            } else {
                teamScore += 1
            }
        }
        print(teamScore)
        
        //在 if 语句中，条件必须是一个布尔表达式——这意味着像 if score { ... } 这样的代码将报错，而不会隐形地与 0 做对比。
        //你可以一起使用 if 和 let 一起来处理值缺失的情况。这些值可由可选值来代表。一个可选的值是一个具体的值或者是 nil 以表示值缺失。在类型后面加一个问号（?）来标记这个变量的值是可选的。
        var optionalString: String? = "Hello"
        print(optionalString == nil)
        var optionalName: String? = "John Appleseed" //nil
        var greeting2 = "Hello!"
        if let name = optionalName {
            greeting2 = "Hello, \(name)"
        }
        print(greeting2)
        
        //如果变量的可选值是 nil，条件会判断为 false，大括号中的代码会被跳过。如果不是 nil，会将值解包并赋给 let 后面的常量，这样代码块中就可以使用这个值了。(把上面的改成var optionalName: String? = nil）
        
        //另一种处理可选值的方法是通过使用 ?? 操作符来提供一个默认值。如果可选值缺失的话，可以使用默认值来代替。
        let nickName: String? = nil
        let fullName: String = "John Appleseed"
        let informalGreeting = "Hi \(nickName ?? fullName)"
        print(informalGreeting)
        
        //switch 支持任意类型的数据以及各种比较操作——不仅仅是整数以及测试相等。
        //运行 switch 中匹配到的 case 语句之后，程序会退出 switch 语句，并不会继续向下运行，所以不需要在每个子句结尾写 break。
        let vegetable = "red pepper"
        switch vegetable {
        case "celery":
            print("Add some raisins and make ants on a log.")
        case "cucumber", "watercress":
            print("That would make a good tea sandwich.")
        case let x where x.hasSuffix("pepper"):///❓
            print("Is it a spicy \(x)?")
        default:
            print("Everything tastes good in soup.")
        }
        
        //你可以使用 for-in 来遍历字典，需要一对儿变量来表示每个键值对。字典是一个无序的集合，所以他们的键和值以任意顺序迭代结束。
        let interestingNumbers = [
            "Prime": [2, 3, 5, 7, 11, 13],
            "Fibonacci": [1, 1, 2, 3, 5, 8],
            "Square": [1, 4, 9, 16, 25],
        ]
        var largest = 0
        for (kind, numbers) in interestingNumbers {
            for number in numbers {
                if number > largest {
                    largest = number
                }
            }
        }
        print(largest)
        
        //使用 while 来重复运行一段代码直到条件改变。循环条件也可以在结尾，保证能至少循环一次。
        var n = 2
        while n < 100 {
            n *= 2
        }
        print(n)
        
        var m = 2
        repeat {
            m *= 2
        } while m < 100
        print(m)
        
        //你可以在循环中使用 ..< 来表示下标范围(使用 ..< 创建的范围不包含上界，如果想包含的话需要使用 ...)
        var total = 0
        for i in 0..<4 {
            total += i
        }
        print(total)
        
        greet(person: "Bob", day: "Friday")
        greet2("John", on: "Friday")
        
        let statistics = calculateStatistics(scores: [5,3,100,3,9])
        print(statistics)
        print(statistics.sum)
        print(statistics.2)
        
        let fit = returnFifteen()
        print(fit)
        
        let increment = makeIncrementer()//这里是返回addOne()
        print(increment(7))
        
        let numbers = [20, 19, 7, 13]
        hasAnyMatches(list: numbers, condition: lessThanTen)
        
        //函数实际上是一种特殊的闭包:它是一段能之后被调取的代码。闭包中的代码能访问闭包作用域中的变量和函数，即使闭包是在一个不同的作用域被执行的——你已经在嵌套函数的例子中看过了。你可以使用 {} 来创建一个匿名闭包。使用 in 将参数和返回值类型的声明与闭包函数体进行分离。
        //map:map方法作用是把数组[T]通过闭包函数把每一个数组中的元素变成U类型的值，最后组成数组[U]。定义如下：
        //func map(transform: (T) -> U) -> [U]
        
        let mapNum =  numbers.map({
            (number: Int) -> Int in
            let result = 3 * number
            return result
        })
        print(mapNum)
        
        //有很多种创建更简洁的闭包的方法。如果一个闭包的类型已知，比如作为一个代理的回调，你可以忽略参数，返回值，甚至两个都忽略。单个语句闭包会把它语句的值当做结果返回。
        let mapNum2 = numbers.map({ number in 3 * number})
        print(mapNum2)
        
        //你可以通过参数位置而不是参数名字来引用参数——这个方法在非常短的闭包中非常有用。当一个闭包作为最后一个参数传给一个函数的时候，它可以直接跟在圆括号后面。当一个闭包是传给函数的唯一参数，你可以完全忽略圆括号。
       // $0 来表示闭包的第一个参数，$1 来表示第二个，以此类推
        //https://www.jianshu.com/p/013a1d82cad5
        let sortedNumbers = numbers.sorted { $0 > $1 }//numbers.sorted(by: >)
        print(sortedNumbers)
        
        
        /**
         对象和类
         */
        let shape = Shape()
        shape.numberOfSides = 7
        var shapeDescription = shape.simpleDescription()
        
        let test = Square(sideLength: 5.2, name: "my test square")
//        test.area()
//        test.simpleDescription()
        print(test.area())
        print(test.simpleDescription())
        
        print(test.fatherName())
         
        let triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
        print(triangle.perimeter) //9.3
        triangle.perimeter = 9.9
        print(triangle.sideLength) //3.3000000000000003
        
        let triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
        print(triangleAndSquare.square.sideLength)
        print(triangleAndSquare.triangle.sideLength)
    }
}

/**
 函数和闭包
 */

//使用 func 来声明一个函数，使用名字和参数来调用函数。使用 -> 来指定函数返回值的类型。
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}

//默认情况下，函数使用它们的参数名称作为它们参数的标签，在参数名称前可以自定义参数标签，或者使用 _ 表示不使用参数标签。
func greet2(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}

//使用元组来生成复合值，比如让一个函数返回多个值。该元组的元素可以用名称或数字来获取。
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    return (min, max, sum)
}

//函数可以嵌套。被嵌套的函数可以访问外侧函数的变量，你可以使用嵌套函数来重构一个太长或者太复杂的函数。
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}

//函数是第一等类型，这意味着函数可以作为另一个函数的返回值
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}

//函数也可以当做参数传入另一个函数
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}

/**
 对象和类
 */
//使用 class 和类名来创建一个类。类中属性的声明和常量、变量声明一样，唯一的区别就是它们的上下文是类。同样，方法和函数声明也一样。
class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
    
}

//这个版本的 Shape 类缺少了一些重要的东西：一个构造函数来初始化类实例。使用 init 来创建一个构造器。
class NameShape {
    var numberOfSides: Int = 0
    var name: String
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}
//如果你需要在对象释放之前进行一些清理工作，使用 deinit 创建一个析构函数。

//子类的定义方法是在它们的类名后面加上父类的名字，用冒号分割。创建类的时候并不需要一个标准的根类，所以你可以根据需要添加或者忽略父类。

//子类如果要重写父类的方法的话，需要用 override 标记——如果没有添加 override 就重写父类方法的话编译器会报错。编译器同样会检测 override 标记的方法是否确实在父类中
class Square: NameShape {
    var sideLength: Double
    init(sideLength: Double, name: String) {
        //在调用父类构造函数之前，必须保证本类的属性都已经完成初始化
        self.sideLength = sideLength
        
        //super.init() 必须放在本类属性初始化的后面，保证本类属性全部初始化完成
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    func fatherName() -> String {
        return name
    }
    
    override func simpleDescription() -> String {
        return  "A square with sides of length \(sideLength)."
    }
}

//除了简单的存储属性，还有使用 getter 和 setter 的计算属性
//如果只重写 get 方法,默认为 readOnly
/**
 注意 EquilateralTriangle 类的构造器执行了三步：
 设置子类声明的属性值
 调用父类的构造器
 改变父类定义的属性值。其他的工作比如调用方法、getters 和 setters 也可以在这个阶段完成。
 */
class EquilateralTriangle: NameShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        //在 perimeter 的 setter 中，新值的名字是 newValue。你可以在 set 之后的圆括号中显式地设置一个名字。?
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
          return "An equilateral triangle with sides of length \(sideLength)."
    }
}

//如果你不需要计算属性，但是仍然需要在设置一个新值之前或者之后运行代码，使用 willSet 和 didSet。写入的代码会在属性值发生改变时调用，但不包含构造器中发生值改变的情况。比如，下面的类确保三角形的边长总是和正方形的边长相同。
class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}
