//
//  Template.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation
import XCTest

/*
模板方法模式是一种行为设计模式， 它在超类中定义了一个算法的框架， 允许子类在不修改结构的情况下重写算法的特定步骤。
模板方法模式结构
1 抽象类 （Abstract­Class） 会声明作为算法步骤的方法， 以及依次调用它们的实际模板方法。 算法步骤可以被声明为 抽象类型， 也可以提供一些默认实现。
2 具体类 （Concrete­Class） 可以重写所有步骤， 但不能重写模板方法自身。
 
当你只希望客户端扩展某个特定算法步骤， 而不是整个算法或其结构时， 可使用模板方法模式
当多个类的算法除一些细微不同之外几乎完全一样时， 你可使用该模式。 但其后果就是， 只要算法发生变化， 你就可能需要修改所有的类
 
 模版方法模式在 Swift 框架中很常见。 开发者通常使用它来向框架用户提供通过继承实现的、 对标准功能进行扩展的简单方式
 */

///抽象类 （Abstract­Class） 会声明作为算法步骤的方法， 以及依次调用它们的实际模板方法。 算法步骤可以被声明为 抽象类型， 也可以提供一些默认实现。
protocol AbstractProtocol {

    func templateMethod()
    func baseOperation1()
    func baseOperation2()
    func baseOperation3()
    func requiredOperations1()
    func requiredOperation2()
    func hook1()
    func hook2()
}

extension AbstractProtocol {

    func templateMethod() {
        baseOperation1()
        requiredOperations1()
        baseOperation2()
        hook1()
        requiredOperation2()
        baseOperation3()
        hook2()
    }
    
    func baseOperation1() {
        print("AbstractProtocol says: I am doing the bulk of the work\n")
    }
    func baseOperation2() {
        print("AbstractProtocol says: But I let subclasses override some operations\n")
    }
    func baseOperation3() {
        print("AbstractProtocol says: But I am doing the bulk of the work anyway\n")
    }
    func hook1() {}
    func hook2() {}
}

///具体类 （Concrete­Class） 可以重写所有步骤， 但不能重写模板方法自身。
class ConcreteClass1: AbstractProtocol {
    
    func requiredOperations1() {
        print("ConcreteClass1 says: Implemented Operation1\n")
    }
    func requiredOperation2() {
        print("ConcreteClass1 says: Implemented Operation2\n")
    }
    func hook2() {
        print("ConcreteClass1 says: Overridden Hook2\n")
    }
}

///具体类 （Concrete­Class） 可以重写所有步骤， 但不能重写模板方法自身。
class ConcreteClass2: AbstractProtocol {

    func requiredOperations1() {
        print("ConcreteClass2 says: Implemented Operation1\n")
    }
    func requiredOperation2() {
        print("ConcreteClass2 says: Implemented Operation2\n")
    }
    func hook1() {
        print("ConcreteClass2 says: Overridden Hook1\n")
    }
}

class TemplateClient {
    
    static func clientCode(use object: AbstractProtocol) {
        object.templateMethod()
    }
}

class TemplateMethodConceptual: XCTestCase {

    func test() {

        print("Same client code can work with different subclasses:\n")
        TemplateClient.clientCode(use: ConcreteClass1())

        print("\nSame client code can work with different subclasses:\n")
        TemplateClient.clientCode(use: ConcreteClass2())
    }
}
