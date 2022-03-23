//
//  Mediator.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation
import XCTest

/*
 中介者模式是一种行为设计模式， 能让你减少对象之间混乱无序的依赖关系。 该模式会限制对象之间的直接交互， 迫使它们通过一个中介者对象进行合作。
 中介者模式结构
1 组件 （Component） 是各种包含业务逻辑的类。 每个组件都有一个指向中介者的引用， 该引用被声明为中介者接口类型。 组件不知道中介者实际所属的类， 因此你可通过将其连接到不同的中介者以使其能在其他程序中复用。
2 中介者 （Mediator） 接口声明了与组件交流的方法， 但通常仅包括一个通知方法。 组件可将任意上下文 （包括自己的对象） 作为该方法的参数， 只有这样接收组件和发送者类之间才不会耦合。
3 具体中介者 （Concrete Mediator） 封装了多种组件间的关系。 具体中介者通常会保存所有组件的引用并对其进行管理， 甚至有时会对其生命周期进行管理。
4 组件并不知道其他组件的情况。 如果组件内发生了重要事件， 它只能通知中介者。 中介者收到通知后能轻易地确定发送者， 这或许已足以判断接下来需要触发的组件了。对于组件来说， 中介者看上去完全就是一个黑箱。 发送者不知道最终会由谁来处理自己的请求， 接收者也不知道最初是谁发出了请求。
 
 中介者模式建议你停止组件之间的直接交流并使其相互独立。 这些组件必须调用特殊的中介者对象， 通过中介者对象重定向调用行为， 以间接的方式进行合作。 最终， 组件仅依赖于一个中介者类， 无需与多个其他组件相耦合。
 
 中介者模式在 Swift 代码中最常用于帮助程序 GUI 组件之间的通信。 在 MVC 模式中， 控制器是中介者的同义词。
 
 一段时间后， 中介者可能会演化成为上帝对象。在面向对象编程领域，一个上帝对象(God object)是一个了解过多或者负责过多的对象
 */

///中介者 （Mediator） 接口声明了与组件交流的方法， 但通常仅包括一个通知方法。 组件可将任意上下文 （包括自己的对象） 作为该方法的参数， 只有这样接收组件和发送者类之间才不会耦合。
protocol Mediator: AnyObject {
    func notify(sender: BaseComponent, event: String)
}

///具体中介者 （Concrete Mediator） 封装了多种组件间的关系。 具体中介者通常会保存所有组件的引用并对其进行管理， 甚至有时会对其生命周期进行管理。
class ConcreteMediator: Mediator {
    
    //保留所有的组件引用并进行管理
    private var component1: Component1
    private var component2: Component2

    init(_ component1: Component1, _ component2: Component2) {
        self.component1 = component1
        self.component2 = component2
        component1.update(mediator: self)
        component2.update(mediator: self)
    }
    
    func notify(sender: BaseComponent, event: String) {
        if event == "A" {
            print("Mediator reacts on A and triggers following operations:")
            self.component2.doC()
        }
        else if (event == "D") {
            print("Mediator reacts on D and triggers following operations:")
            self.component1.doB()
            self.component2.doC()
        }
    }
}

///组件 （Component） 是各种包含业务逻辑的类。 每个组件都有一个指向中介者的引用， 该引用被声明为中介者接口类型。 组件不知道中介者实际所属的类， 因此你可通过将其连接到不同的中介者以使其能在其他程序中复用。
class BaseComponent {
    
    fileprivate weak var mediator: Mediator?
    init(mediator: Mediator? = nil) {
        self.mediator = mediator
    }
    func update(mediator: Mediator) {
        self.mediator = mediator
    }
}

///组件 （Component） 是各种包含业务逻辑的类。 每个组件都有一个指向中介者的引用， 该引用被声明为中介者接口类型。 组件不知道中介者实际所属的类， 因此你可通过将其连接到不同的中介者以使其能在其他程序中复用。
class Component1: BaseComponent {
    
    func doA() {
        print("Component 1 does A.")
        mediator?.notify(sender: self, event: "A")
    }
    func doB() {
        print("Component 1 does B.\n")
        mediator?.notify(sender: self, event: "B")
    }
}

/// 确定的组件 （ Component） 是各种包含业务逻辑的类。 每个组件都有一个指向中介者的引用， 该引用被声明为中介者接口类型。 组件不知道中介者实际所属的类， 因此你可通过将其连接到不同的中介者以使其能在其他程序中复用。
class Component2: BaseComponent {

    func doC() {
        print("Component 2 does C.")
        mediator?.notify(sender: self, event: "C")
    }
    func doD() {
        print("Component 2 does D.")
        mediator?.notify(sender: self, event: "D")
    }
}

class MediatorConceptual: XCTestCase {

    func testMediatorConceptual() {

        let component1 = Component1()
        let component2 = Component2()

        let mediator = ConcreteMediator(component1, component2)
        print("Client triggers operation A.")
        component1.doA()

        print("\nClient triggers operation D.")
        component2.doD()

        print(mediator)
    }
}
