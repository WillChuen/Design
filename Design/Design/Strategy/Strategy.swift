//
//  Strategy.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation
import XCTest

/*
 策略模式是一种行为设计模式， 它能让你定义一系列算法， 并将每种算法分别放入独立的类中， 以使算法的对象能够相互替换。
 策略模式结构
1 上下文 （Context） 维护指向具体策略的引用， 且仅通过策略接口与该对象进行交流。
2 策略 （Strategy） 接口是所有具体策略的通用接口， 它声明了一个上下文用于执行策略的方法。
3 具体策略 （Concrete Strategies） 实现了上下文所用算法的各种不同变体。
4 当上下文需要运行算法时， 它会在其已连接的策略对象上调用执行方法。 上下文不清楚其所涉及的策略类型与算法的执行方式。
5 客户端 （Client） 会创建一个特定策略对象并将其传递给上下文。 上下文则会提供一个设置器以便客户端在运行时替换相关联的策略。
 
 你可以在运行时切换对象内的算法
 你可以将算法的实现和使用算法的代码隔离开来
 你可以使用组合来代替继承
 开闭原则。 你无需对上下文进行修改就能够引入新的策略
 
 策略模式在 Swift 代码中很常见。 它经常在各种框架中使用， 能在不扩展类的情况下向用户提供改变其行为的方式
 */

///上下文 （Context） 维护指向具体策略的引用， 且仅通过策略接口与该对象进行交流。
class ContextStrategy {
    
    private var strategy: Strategy
    init(strategy: Strategy) {
        self.strategy = strategy
    }
    func update(strategy: Strategy) {
        self.strategy = strategy
    }
    func doSomeBusinessLogic() {
        print("Context: Sorting data using the strategy (not sure how it'll do it)\n")
        let result = strategy.doAlgorithm(["a", "b", "c", "d", "e"])
        print(result.joined(separator: ","))
    }
}

///策略 （Strategy） 接口是所有具体策略的通用接口， 它声明了一个上下文用于执行策略的方法。
protocol Strategy {
    func doAlgorithm<T: Comparable>(_ data: [T]) -> [T]
}

///具体策略 （Concrete Strategies） 实现了上下文所用算法的各种不同变体。
class ConcreteStrategyA: Strategy {
    
    func doAlgorithm<T: Comparable>(_ data: [T]) -> [T] {
        return data.sorted()
    }
}

///具体策略 （Concrete Strategies） 实现了上下文所用算法的各种不同变体。
class ConcreteStrategyB: Strategy {
    
    func doAlgorithm<T: Comparable>(_ data: [T]) -> [T] {
        return data.sorted(by: >)
    }
}

class StrategyConceptual: XCTestCase {
    
    func test() {
        
        let context = ContextStrategy(strategy: ConcreteStrategyA())
        print("Client: Strategy is set to normal sorting.\n")
        context.doSomeBusinessLogic()
        
        print("\nClient: Strategy is set to reverse sorting.\n")
        context.update(strategy: ConcreteStrategyB())
        context.doSomeBusinessLogic()
    }
}
