//
//  Decorate.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation
import XCTest

/*
 装饰模式是一种结构型设计模式， 允许你通过将对象放入包含行为的特殊封装对象中来为原对象绑定新的行为。
 装饰模式结构
1 部件 （Component） 声明封装器和被封装对象的公用接口。
2 具体部件 （Concrete Component） 类是被封装对象所属的类。 它定义了基础行为， 但装饰类可以改变这些行为。
3 基础装饰 （Base Decorator） 类拥有一个指向被封装对象的引用成员变量。 该变量的类型应当被声明为通用部件接口， 这样它就可以引用具体的部件和装饰。 装饰基类会将所有操作委派给被封装的对象。
4 具体装饰类 （Concrete Decorators） 定义了可动态添加到部件的额外行为。 具体装饰类会重写装饰基类的方法， 并在调用父类方法之前或之后进行额外的行为。
5 客户端 （Client） 可以使用多层装饰来封装部件， 只要它能使用通用接口与所有对象互动即可。
 
 装饰在 Swift 代码中可谓是标准配置， 尤其是在与流式加载相关的代码中。
 */


///部件 （Component） 声明封装器和被封装对象的公用接口。
protocol DecorateComponent {
    func operation() -> String
}

///具体部件 （Concrete Component） 类是被封装对象所属的类。 它定义了基础行为， 但装饰类可以改变这些行为。
class ConcreteComponent: DecorateComponent {
    
    func operation() -> String {
        return "ConcreteComponent"
    }
}

///基础装饰 （Base Decorator） 类拥有一个指向被封装对象的引用成员变量。 该变量的类型应当被声明为通用部件接口， 这样它就可以引用具体的部件和装饰。 装饰基类会将所有操作委派给被封装的对象。
class Decorator: DecorateComponent {
    
    private var component: DecorateComponent
    init(_ component: DecorateComponent) {
        self.component = component
    }
    func operation() -> String {
        return component.operation()
    }
}

///具体装饰类 （Concrete Decorators） 定义了可动态添加到部件的额外行为。 具体装饰类会重写装饰基类的方法， 并在调用父类方法之前或之后进行额外的行为。
class ConcreteDecoratorA: Decorator {
    
    override func operation() -> String {
        return "ConcreteDecoratorA(" + super.operation() + ")"
    }
}

///具体装饰类 （Concrete Decorators） 定义了可动态添加到部件的额外行为。 具体装饰类会重写装饰基类的方法， 并在调用父类方法之前或之后进行额外的行为。
class ConcreteDecoratorB: Decorator {
    
    override func operation() -> String {
        return "ConcreteDecoratorB(" + super.operation() + ")"
    }
}

///客户端 （Client） 可以使用多层装饰来封装部件， 只要它能使用通用接口与所有对象互动即可。
class DecoratorClient {
    // ...
    static func someClientCode(component: DecorateComponent) {
        print("Result: " + component.operation())
    }
    // ...
}

/// Let's see how it all works together.
class DecoratorConceptual: XCTestCase {

    func testDecoratorConceptual() {
        
        //单一装饰
        print("Client: I've got a simple component")
        let simple = ConcreteComponent()
        DecoratorClient.someClientCode(component: simple)
        
        //多级装饰
        let decorator1 = ConcreteDecoratorA(simple)
        let decorator2 = ConcreteDecoratorB(decorator1)
        print("\nClient: Now I've got a decorated component")
        DecoratorClient.someClientCode(component: decorator2)
    }
}
