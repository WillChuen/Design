//
//  Memento.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation
import XCTest

/*
备忘录模式是一种行为设计模式， 允许在不暴露对象实现细节的情况下保存和恢复对象之前的状态。
备忘录模式结构
1 原发器 （Originator） 类可以生成自身状态的快照， 也可以在需要时通过快照恢复自身状态。
2 备忘录 （Memento） 是原发器状态快照的值对象 （value object）。 通常做法是将备忘录设为不可变的， 并通过构造函数一次性传递数据。
3 负责人 （Caretaker） 仅知道 “何时” 和 “为何” 捕捉原发器的状态， 以及何时恢复状态。负责人通过保存备忘录栈来记录原发器的历史状态。 当原发器需要回溯历史状态时， 负责人将从栈中获取最顶部的备忘录， 并将其传递给原发器的恢复 （restoration） 方法。
4 在该实现方法中， 备忘录类将被嵌套在原发器中。 这样原发器就可访问备忘录的成员变量和方法， 即使这些方法被声明为私有。 另一方面， 负责人对于备忘录的成员变量和方法的访问权限非常有限： 它们只能在栈中保存备忘录， 而不能修改其状态。
 
 备忘录的基本功能可用序列化来实现， 这在 Swift 语言中很常见。 尽管备忘录不是生成对象状态快照的唯一或最有效的方法， 但它能在保护原始对象的结构不暴露给其他对象的情况下保存对象状态的备份。
 */

/// 原发器 （Originator） 类可以生成自身状态的快照， 也可以在需要时通过快照恢复自身状态。
class Originator {
    
    private var state: String
    
    init(state: String) {
        self.state = state
        print("Originator: My initial state is: \(state)")
    }
    
    func doSomething() {
        print("Originator: I'm doing something important.")
        state = generateRandomString()
        print("Originator: and my state has changed to: \(state)")
    }

    private func generateRandomString() -> String {
        return String(UUID().uuidString.suffix(4))
    }

    func save() -> Memento {
        return ConcreteMemento(state: state)
    }

    func restore(memento: Memento) {
        guard let memento = memento as? ConcreteMemento else { return }
        self.state = memento.state
        print("Originator: My state has changed to: \(state)")
    }
}

///备忘录 （Memento） 是原发器状态快照的值对象 （value object）。 通常做法是将备忘录设为不可变的， 并通过构造函数一次性传递数据。
protocol Memento {

    var name: String { get }
    var date: Date { get }
}

///确定的备忘录 （Memento） 是原发器状态快照的值对象 （value object）。 通常做法是将备忘录设为不可变的， 并通过构造函数一次性传递数据。
class ConcreteMemento: Memento {

    private(set) var state: String
    private(set) var date: Date

    init(state: String) {
        self.state = state
        self.date = Date()
    }
    /// The rest of the methods are used by the Caretaker to display metadata.
    var name: String { return state + " " + date.description.suffix(14).prefix(8) }
}

/// 负责人 （Caretaker） 仅知道 “何时” 和 “为何” 捕捉原发器的状态， 以及何时恢复状态。负责人通过保存备忘录栈来记录原发器的历史状态。 当原发器需要回溯历史状态时， 负责人将从栈中获取最顶部的备忘录， 并将其传递给原发器的恢复 （restoration） 方法。
class Caretaker {
    
    //备忘录
    private lazy var mementos = [Memento]()
    //原发器
    private var originator: Originator
    //愿发器
    init(originator: Originator) {
        self.originator = originator
    }
    
    //捕获原发器状态
    func backup() {
        print("\nCaretaker: Saving Originator's state...\n")
        mementos.append(originator.save())
    }
    //恢复状态
    func undo() {
        guard !mementos.isEmpty else { return }
        let removedMemento = mementos.removeLast()
        print("Caretaker: Restoring state to: " + removedMemento.name)
        originator.restore(memento: removedMemento)
    }
    //原发器历史
    func showHistory() {
        print("Caretaker: Here's the list of mementos:\n")
        mementos.forEach({ print($0.name) })
    }
}

class MementoConceptual: XCTestCase {

    func testMementoConceptual() {

        //原发器
        let originator = Originator(state: "Super-duper-super-puper-super.")
        //备忘负责
        let caretaker = Caretaker(originator: originator)
        
        //备份
        caretaker.backup()
        originator.doSomething()

        //备份
        caretaker.backup()
        originator.doSomething()
        
        //备份
        caretaker.backup()
        originator.doSomething()

        print("\n")
        caretaker.showHistory()
        
        print("\nClient: Now, let's rollback!\n\n")
        //恢复备忘
        caretaker.undo()
        
        print("\nClient: Once more!\n\n")
        //恢复备忘
        caretaker.undo()
    }
}
