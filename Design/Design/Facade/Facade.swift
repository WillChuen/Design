//
//  Facade.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation


class Facade {

    private var subsystem1: Subsystem1
    private var subsystem2: Subsystem2

    init(subsystem1: Subsystem1 = Subsystem1(),
         subsystem2: Subsystem2 = Subsystem2()) {
        self.subsystem1 = subsystem1
        self.subsystem2 = subsystem2
    }
    
    func operation() -> String {

        var result = "Facade initializes subsystems:"
        result += " " + subsystem1.operation1()
        result += " " + subsystem2.operation1()
        result += "\n" + "Facade orders subsystems to perform the action:\n"
        result += " " + subsystem1.operationN()
        result += " " + subsystem2.operationZ()
        return result
    }
}

class Subsystem1 {
    
    func operation1() -> String {
        return "Sybsystem1: Ready!\n"
    }
    func operationN() -> String {
        return "Sybsystem1: Go!\n"
    }
}

class Subsystem2 {

    func operation1() -> String {
        return "Sybsystem2: Get ready!\n"
    }

    // ...

    func operationZ() -> String {
        return "Sybsystem2: Fire!\n"
    }
}

class FacadeClient {
    // ...
    static func clientCode(facade: Facade) {
        print(facade.operation())
    }
    // ...
}
