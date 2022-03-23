//
//  State.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation
import XCTest

/*
状态模式是一种行为设计模式， 让你能在一个对象的内部状态变化时改变其行为， 使其看上去就像改变了自身所属的类一样。
状态模式结构
1 上下文 （Context） 保存了对于一个具体状态对象的引用， 并会将所有与该状态相关的工作委派给它。 上下文通过状态接口与状态对象交互， 且会提供一个设置器用于传递新的状态对象。
2 状态 （State） 接口会声明特定于状态的方法。 这些方法应能被其他所有具体状态所理解， 因为你不希望某些状态所拥有的方法永远不会被调用。
3 具体状态 （Concrete States） 会自行实现特定于状态的方法。 为了避免多个状态中包含相似代码， 你可以提供一个封装有部分通用行为的中间抽象类。状态对象可存储对于上下文对象的反向引用。 状态可以通过该引用从上下文处获取所需信息， 并且能触发状态转移。
4 上下文和具体状态都可以设置上下文的下个状态， 并可通过替换连接到上下文的状态对象来完成实际的状态转换。
 
 在 Swift 语言中， 状态模式通常被用于将基于 switch语句的大型状态机转换为对象。

 如果对象需要根据自身当前状态进行不同行为， 同时状态的数量非常多且与状态相关的代码会频繁变更的话， 可使用状态模式
 如果某个类需要根据成员变量的当前值改变自身行为， 从而需要使用大量的条件语句时， 可使用该模式
 */

/// 上下文 （Context） 保存了对于一个具体状态对象的引用， 并会将所有与该状态相关的工作委派给它。 上下文通过状态接口与状态对象交互， 且会提供一个设置器用于传递新的状态对象。
class Context {
    
    private var state: State
    init(_ state: State) {
        self.state = state
        transitionTo(state: state)
    }
    func transitionTo(state: State) {
        print("Context: Transition to " + String(describing: state))
        self.state = state
        self.state.update(context: self)
    }
    func request1() {
        state.handle1()
    }
    func request2() {
        state.handle2()
    }
}

///状态 （State） 接口会声明特定于状态的方法。 这些方法应能被其他所有具体状态所理解， 因为你不希望某些状态所拥有的方法永远不会被调用。
protocol State: AnyObject {
    
    func update(context: Context)
    func handle1()
    func handle2()
}

///具体状态 （Concrete States） 会自行实现特定于状态的方法。 为了避免多个状态中包含相似代码， 你可以提供一个封装有部分通用行为的中间抽象类。状态对象可存储对于上下文对象的反向引用。 状态可以通过该引用从上下文处获取所需信息， 并且能触发状态转移。
class BaseState: State {
    
    private(set) weak var context: Context?
    func update(context: Context) {
        self.context = context
    }
    func handle1() {}
    func handle2() {}
}

///具体状态 （Concrete States） 会自行实现特定于状态的方法。 为了避免多个状态中包含相似代码， 你可以提供一个封装有部分通用行为的中间抽象类。状态对象可存储对于上下文对象的反向引用。 状态可以通过该引用从上下文处获取所需信息， 并且能触发状态转移。
class ConcreteStateA: BaseState {

    override func handle1() {
        print("ConcreteStateA handles request1.")
        print("ConcreteStateA wants to change the state of the context.\n")
        context?.transitionTo(state: ConcreteStateB())
    }
    override func handle2() {
        print("ConcreteStateA handles request2.\n")
    }
}

///具体状态 （Concrete States） 会自行实现特定于状态的方法。 为了避免多个状态中包含相似代码， 你可以提供一个封装有部分通用行为的中间抽象类。状态对象可存储对于上下文对象的反向引用。 状态可以通过该引用从上下文处获取所需信息， 并且能触发状态转移。
class ConcreteStateB: BaseState {

    override func handle1() {
        print("ConcreteStateB handles request1.\n")
    }
    override func handle2() {
        print("ConcreteStateB handles request2.")
        print("ConcreteStateB wants to change the state of the context.\n")
        context?.transitionTo(state: ConcreteStateA())
    }
}

class StateConceptual: XCTestCase {

    func test() {
        let context = Context(ConcreteStateA())
        context.request1()
        context.request2()
    }
}
