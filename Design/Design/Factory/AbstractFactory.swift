//
//  AbstractFactory.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import UIKit

/*
 抽象工厂模式是一种创建型设计模式， 它能创建一系列相关的对象， 而无需指定其具体类。
 抽象工厂模式结构
 1 抽象产品 （Abstract ˈæbstrækt Product） 为构成系列产品的一组不同但相关的产品声明接口。
 2 具体产品 （Concrete ˈkɑːnkriːt Product） 是抽象产品的多种不同类型实现。
 3 抽象工厂 （Abstract Factory） 接口声明了一组创建各种抽象产品的方法。
 4 具体工厂 （Concrete Factory） 实现抽象工厂的构建方法。 每个具体工厂都对应特定产品变体， 且仅创建此种产品变体。
 5 尽管具体工厂会对具体产品进行初始化， 其构建方法签名必须返回相应的抽象产品。 这样， 使用工厂类的客户端代码就不会与工厂创建的特定产品变体耦合。 客户端 （Client） 只需通过抽象接口调用工厂和产品对象， 就能与任何具体工厂/产品变体交互。
 */

///抽象工厂
protocol AbstractFactory {
    func createProductA() -> AbstractProductA
    func createProductB() -> AbstractProductB
}

/*
 在创建产品时， 客户端代码调用的是工厂对象的构建方法， 而不是直接调用构造函数 （ new操作符）。 由于一个工厂对应一种产品变体， 因此它创建的所有产品都可相互兼容。
 */
class ConcreteFactory1: AbstractFactory {
    
    func createProductA() -> AbstractProductA {
        return ConcreteProductA1()
    }
    func createProductB() -> AbstractProductB {
        return ConcreteProductB1()
    }
}
class ConcreteFactory2: AbstractFactory {
    
    func createProductA() -> AbstractProductA {
        return ConcreteProductA2()
    }
    func createProductB() -> AbstractProductB {
        return ConcreteProductB2()
    }
}

//抽象工厂定义了用于创建不同产品的接口， 但将实际的创建工作留给了具体工厂类。 每个工厂类型都对应一个特定的产品变体。
protocol AbstractProductA {
    func usefulFunctionA() -> String
}

class ConcreteProductA1: AbstractProductA {

    func usefulFunctionA() -> String {
        return "The result of the product A1."
    }
}

class ConcreteProductA2: AbstractProductA {

    func usefulFunctionA() -> String {
        return "The result of the product A2."
    }
}

///抽象产品
protocol AbstractProductB {
    
    func usefulFunctionB() -> String
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String
}

///具体产品
class ConcreteProductB1: AbstractProductB {
    
    func usefulFunctionB() -> String {
        return "The result of the product B1."
    }
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String {
        let result = collaborator.usefulFunctionA()
        return "The result of the B1 collaborating with the (\(result))"
    }
}

///具体产品
class ConcreteProductB2: AbstractProductB {
    
    func usefulFunctionB() -> String {
        return "The result of the product B2."
    }
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String {
        let result = collaborator.usefulFunctionA()
        return "The result of the B2 collaborating with the (\(result))"
    }
}

class AbstractClient {
    
    /// 客户端代码仅通过其抽象接口与工厂和产品进行交互。 该接口允许同一客户端代码与不同产品进行交互。 你只需创建一个具体工厂类并将其传递给客户端代码即可
    static func someClientCode(factory: AbstractFactory) {
        let productA = factory.createProductA()
        let productB = factory.createProductB()
        print(productB.usefulFunctionB())
        print(productB.anotherUsefulFunctionB(collaborator: productA))
    }
}

