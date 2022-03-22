//
//  Decorate.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation


protocol ComponentD {
    func operation() -> String
}


class ConcreteComponent: ComponentD {
    
    func operation() -> String {
        return "ConcreteComponent"
    }
}

class Decorator: ComponentD {
    
    private var component: ComponentD
    init(_ component: ComponentD) {
        self.component = component
    }
    func operation() -> String {
        return component.operation()
    }
}

class ConcreteDecoratorA: Decorator {
    
    override func operation() -> String {
        return "ConcreteDecoratorA(" + super.operation() + ")"
    }
}

class ConcreteDecoratorB: Decorator {
    
    override func operation() -> String {
        return "ConcreteDecoratorB(" + super.operation() + ")"
    }
}

class DecoratorClient {
    // ...
    static func someClientCode(component: ComponentD) {
        print("Result: " + component.operation())
    }
    // ...
}
