//
//  Listener.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation
import XCTest

/*
 观察者模式是一种行为设计模式， 允许你定义一种订阅机制， 可在对象事件发生时通知多个 “观察” 该对象的其他对象。
 观察者模式结构
1 发布者 （Publisher） 会向其他对象发送值得关注的事件。 事件会在发布者自身状态改变或执行特定行为后发生。 发布者中包含一个允许新订阅者加入和当前订阅者离开列表的订阅构架。
2 当新事件发生时， 发送者会遍历订阅列表并调用每个订阅者对象的通知方法。 该方法是在订阅者接口中声明的。
3 订阅者 （Subscriber） 接口声明了通知接口。 在绝大多数情况下， 该接口仅包含一个 update更新方法。 该方法可以拥有多个参数， 使发布者能在更新时传递事件的详细信息。
4 具体订阅者 （Concrete Subscribers） 可以执行一些操作来回应发布者的通知。 所有具体订阅者类都实现了同样的接口， 因此发布者不需要与具体类相耦合。
5 订阅者通常需要一些上下文信息来正确地处理更新。 因此， 发布者通常会将一些上下文数据作为通知方法的参数进行传递。 发布者也可将自身作为参数进行传递， 使订阅者直接获取所需的数据。
6 客户端 （Client） 会分别创建发布者和订阅者对象， 然后为订阅者注册发布者更新。
 
 订阅者的通知顺序是随机的。
 观察者模式在 Swift 代码中很常见， 特别是在 GUI 组件中。 它提供了在不与其他对象所属类耦合的情况下对其事件做出反应的方式。
 */

///发布者 （Publisher） 会向其他对象发送值得关注的事件。 事件会在发布者自身状态改变或执行特定行为后发生。 发布者中包含一个允许新订阅者加入和当前订阅者离开列表的订阅构架。
class Publisher {
    
    var state: Int = {
        return Int(arc4random_uniform(10))
    }()
    
    private lazy var observers = [Observer]()
    func attach(_ observer: Observer) {
        print("Subject: Attached an observer.\n")
        observers.append(observer)
    }
    func detach(_ observer: Observer) {
        if let idx = observers.firstIndex(where: { $0 === observer }) {
            observers.remove(at: idx)
            print("Subject: Detached an observer.\n")
        }
    }
    
    func notify() {
        print("Subject: Notifying observers...\n")
        observers.forEach({ $0.update(subject: self)})
    }
    func someBusinessLogic() {
        print("\nSubject: I'm doing something important.\n")
        state = Int(arc4random_uniform(10))
        print("Subject: My state has just changed to: \(state)\n")
        notify()
    }
}

/// 订阅者 （Subscriber） 接口声明了通知接口。 在绝大多数情况下， 该接口仅包含一个 update更新方法。 该方法可以拥有多个参数， 使发布者能在更新时传递事件的详细信息。
protocol Observer: AnyObject {
    func update(subject: Publisher)
}

///具体订阅者 （Concrete Subscribers） 可以执行一些操作来回应发布者的通知。 所有具体订阅者类都实现了同样的接口， 因此发布者不需要与具体类相耦合。
class ConcreteObserverA: Observer {
    
    func update(subject: Publisher) {
        if subject.state < 3 {
            print("ConcreteObserverA: Reacted to the event.\n")
        }
    }
}

/// 具体订阅者 （Concrete Subscribers） 可以执行一些操作来回应发布者的通知。 所有具体订阅者类都实现了同样的接口， 因此发布者不需要与具体类相耦合。
class ConcreteObserverB: Observer {
    
    func update(subject: Publisher) {
        if subject.state >= 3 {
            print("ConcreteObserverB: Reacted to the event.\n")
        }
    }
}

/// Let's see how it all works together.
class ObserverConceptual: XCTestCase {

    func testObserverConceptual() {

        ///发布者
        let subject = Publisher()
        
        ///具体订阅者
        let observer1 = ConcreteObserverA()
        let observer2 = ConcreteObserverB()
        
        ///添加订阅
        subject.attach(observer1)
        subject.attach(observer2)

        subject.someBusinessLogic()
        subject.someBusinessLogic()
        
        subject.detach(observer2)
        subject.someBusinessLogic()
    }
}





