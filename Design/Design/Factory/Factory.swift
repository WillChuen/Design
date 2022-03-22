//
//  Factory.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import UIKit

/*
  工厂方法模式是一种创建型设计模式， 其在父类中提供一个创建对象的方法， 允许子类决定实例化对象的类型。
    工厂模式结构
    1   产品 （Product） 将会对接口进行声明。 对于所有由创建者及其子类构建的对象， 这些接口都是通用的。
    2   具体产品 （Concrete Products） 是产品接口的不同实现。
    3   创建者 （Creator） 类声明返回产品对象的工厂方法。 该方法的返回对象类型必须与产品接口相匹配。
    4   具体创建者 （Concrete Creators） 将会重写基础工厂方法， 使其返回不同类型的产品。
 */

///创建者
protocol Creator {
    //生产产品
    func factoryMethod() -> Product
    //对产品进行操作
    func someOperation() -> String
}

///创建者 扩展
extension Creator {
    
    func someOperation() -> String {
        let product = factoryMethod()
        return "Creator: 对每个产品应用相同的操作 " + product.operation()
    }
}

///具体的创建者
class ConcreteCreator1: Creator {
    
    public func factoryMethod() -> Product {
        return ConcreteProduct1()
    }
}

///具体的创建者
class ConcreteCreator2: Creator {
    
    public func factoryMethod() -> Product {
        return ConcreteProduct2()
    }
}

///产品协
protocol Product {
    func operation() -> String
}

///具体产品
class ConcreteProduct1: Product {
    
    func operation() -> String {
        return "我是具体产品1"
    }
}

///具体产品
class ConcreteProduct2: Product {
    func operation() -> String {
        return "我是具体产品2"
    }
}

///具体使用
class Client {
    static func someClientCode(creator: Creator) {
        print("Client: 我不知道准确的创建者，但代码依然生效\n"
            + creator.someOperation())
    }
}
