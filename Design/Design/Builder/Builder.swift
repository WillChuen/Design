//
//  Builder.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import UIKit
import XCTest

/*
 当你需要创建一个可能有许多配置选项的对象时
 生成器模式是一种创建型设计模式， 使你能够分步骤创建复杂对象。 该模式允许你使用相同的创建代码生成不同类型和形式的对象。
 生成器模式结构
 1 生成器 （Builder） 接口声明在所有类型生成器中通用的产品构造步骤。
 2 具体生成器 （Concrete Builders） 提供构造过程的不同实现。 具体生成器也可以构造不遵循通用接口的产品。
 3 产品 （Products） 是最终生成的对象。 由不同生成器构造的产品无需属于同一类层次结构或接口。
 4 主管 （Director） 类定义调用构造步骤的顺序， 这样你就可以创建和复用特定的产品配置。
 5 客户端 （Client） 必须将某个生成器对象与主管类关联。 一般情况下， 你只需通过主管类构造函数的参数进行一次性关联即可。 此后主管类就能使用生成器对象完成后续所有的构造任务。 但在客户端将生成器对象传递给主管类制造方法时还有另一种方式。 在这种情况下， 你在使用主管类生产产品时每次都可以使用不同的生成器。
 
 生成器模式可避免 “重叠构造函数 （telescopic constructor）” 的出现
 生成器模式是 Swift 世界中的一个著名模式。 当你需要创建一个可能有许多配置选项的对象时， 该模式会特别有用
 */

/// 生成器 （Builder） 接口声明在所有类型生成器中通用的产品构造步骤。
protocol Builder {
    
    func producePartA()
    func producePartB()
    func producePartC()
}

/// 具体生成器 （Concrete Builders） 提供构造过程的不同实现。 具体生成器也可以构造不遵循通用接口的产品。
class ConcreteBuilder1: Builder {
    
    private var product = Product1()
    func reset() {
        product = Product1()
    }
    
    func producePartA() {
        product.add(part: "PartA1")
    }
    
    func producePartB() {
        product.add(part: "PartB1")
    }

    func producePartC() {
        product.add(part: "PartC1")
    }
    
    func retrieveProduct() -> Product1 {
        let result = self.product
        reset()
        return result
    }
}

///主管 （Director） 类定义调用构造步骤的顺序， 这样你就可以创建和复用特定的产品配置。
class Director {

    private var builder: Builder?
    func update(builder: Builder) {
        self.builder = builder
    }
    func buildMinimalViableProduct() {
        builder?.producePartA()
    }
    func buildFullFeaturedProduct() {
        builder?.producePartA()
        builder?.producePartB()
        builder?.producePartC()
    }
}

///3 产品 （Products） 是最终生成的对象。 由不同生成器构造的产品无需属于同一类层次结构或接口。
class Product1 {
    
    private var parts = [String]()
    func add(part: String) {
        self.parts.append(part)
    }
    func listParts() -> String {
        return "Product parts: " + parts.joined(separator: ", ") + "\n"
    }
}

class BuilderClient {
    // ...
    static func someClientCode(director: Director) {
        let builder = ConcreteBuilder1()
        director.update(builder: builder)
        
        print("Standard basic product:")
        director.buildMinimalViableProduct()
        print(builder.retrieveProduct().listParts())

        print("Standard full featured product:")
        director.buildFullFeaturedProduct()
        print(builder.retrieveProduct().listParts())

        // Remember, the Builder pattern can be used without a Director class.
        print("Custom product:")
        builder.producePartA()
        builder.producePartC()
        print(builder.retrieveProduct().listParts())
    }
}

class BuilderConceptual: XCTestCase {

    func testBuilderConceptual() {
        let director = Director()
        BuilderClient.someClientCode(director: director)
    }
}


