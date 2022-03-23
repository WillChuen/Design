//
//  Visitor.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation
import XCTest

/*
访问者模式是一种行为设计模式， 它能将算法与其所作用的对象隔离开来。
访问者模式结构
1 访问者 （Visitor） 接口声明了一系列以对象结构的具体元素为参数的访问者方法。 如果编程语言支持重载， 这些方法的名称可以是相同的， 但是其参数一定是不同的。
2 具体访问者 （Concrete Visitor） 会为不同的具体元素类实现相同行为的几个不同版本。
3 元素 （Element） 接口声明了一个方法来 “接收” 访问者。 该方法必须有一个参数被声明为访问者接口类型。
4 具体元素 （Concrete Element） 必须实现接收方法。 该方法的目的是根据当前元素类将其调用重定向到相应访问者的方法。 请注意， 即使元素基类实现了该方法， 所有子类都必须对其进行重写并调用访问者对象中的合适方法。
5 客户端 （Client） 通常会作为集合或其他复杂对象 （例如一个组合树） 的代表。 客户端通常不知晓所有的具体元素类， 因为它们会通过抽象接口与集合中的对象进行交互。
 */

///元素 （Element） 接口声明了一个方法来 “接收” 访问者。 该方法必须有一个参数被声明为访问者接口类型。
protocol VisitorComponent {
    func accept(_ visitor: Visitor)
}

///具体元素 （Concrete Element） 必须实现接收方法。 该方法的目的是根据当前元素类将其调用重定向到相应访问者的方法。 请注意， 即使元素基类实现了该方法， 所有子类都必须对其进行重写并调用访问者对象中的合适方法。
class VisitorComponentA: VisitorComponent {
    
    func accept(_ visitor: Visitor) {
        visitor.visitConcreteComponentA(element: self)
    }
    func exclusiveMethodOfConcreteComponentA() -> String {
        return "A"
    }
}

///具体元素 （Concrete Element） 必须实现接收方法。 该方法的目的是根据当前元素类将其调用重定向到相应访问者的方法。 请注意， 即使元素基类实现了该方法， 所有子类都必须对其进行重写并调用访问者对象中的合适方法。
class VisitorComponentB: VisitorComponent {
    
    func accept(_ visitor: Visitor) {
        visitor.visitConcreteComponentB(element: self)
    }

    func specialMethodOfConcreteComponentB() -> String {
        return "B"
    }
}

///访问者 （Visitor） 接口声明了一系列以对象结构的具体元素为参数的访问者方法。 如果编程语言支持重载， 这些方法的名称可以是相同的， 但是其参数一定是不同的。
protocol Visitor {

    func visitConcreteComponentA(element: VisitorComponentA)
    func visitConcreteComponentB(element: VisitorComponentB)
}

///具体访问者 （Concrete Visitor） 会为不同的具体元素类实现相同行为的几个不同版本。
class ConcreteVisitor1: Visitor {
    
    func visitConcreteComponentA(element: VisitorComponentA) {
        print(element.exclusiveMethodOfConcreteComponentA() + " + ConcreteVisitor1\n")
    }
    func visitConcreteComponentB(element: VisitorComponentB) {
        print(element.specialMethodOfConcreteComponentB() + " + ConcreteVisitor1\n")
    }
}

///具体访问者 （Concrete Visitor） 会为不同的具体元素类实现相同行为的几个不同版本。
class ConcreteVisitor2: Visitor {
    
    func visitConcreteComponentA(element: VisitorComponentA) {
        print(element.exclusiveMethodOfConcreteComponentA() + " + ConcreteVisitor2\n")
    }
    func visitConcreteComponentB(element: VisitorComponentB) {
        print(element.specialMethodOfConcreteComponentB() + " + ConcreteVisitor2\n")
    }
}

class VisitorClient {
    
    static func clientCode(components: [VisitorComponent], visitor: Visitor) {
        components.forEach({ $0.accept(visitor) })
    }
}

/// Let's see how it all works together.
class VisitorConceptual: XCTestCase {

    func test() {
        
        let components: [VisitorComponent] = [VisitorComponentA(), VisitorComponentB()]
        print("The client code works with all visitors via the base Visitor interface:\n")
        let visitor1 = ConcreteVisitor1()
        VisitorClient.clientCode(components: components, visitor: visitor1)
        print("\nIt allows the same client code to work with different types of visitors:\n")
        let visitor2 = ConcreteVisitor2()
        VisitorClient.clientCode(components: components, visitor: visitor2)
    }
}
