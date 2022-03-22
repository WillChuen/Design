//
//  State.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation

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

    /// The Context delegates part of its behavior to the current State object.
    func request1() {
        state.handle1()
    }

    func request2() {
        state.handle2()
    }
}

/// The base State class declares methods that all Concrete State should
/// implement and also provides a backreference to the Context object,
/// associated with the State. This backreference can be used by States to
/// transition the Context to another State.
protocol State: AnyObject {
    
    func update(context: Context)
    func handle1()
    func handle2()
}

class BaseState: State {

    private(set) weak var context: Context?

    func update(context: Context) {
        self.context = context
    }
    func handle1() {}
    func handle2() {}
}

/// Concrete States implement various behaviors, associated with a state of the
/// Context.
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
