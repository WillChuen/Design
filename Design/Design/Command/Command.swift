//
//  Command.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation
import XCTest

/*
 命令模式是一种行为设计模式， 它可将请求转换为一个包含与请求相关的所有信息的独立对象。 该转换让你能根据不同的请求将方法参数化、 延迟请求执行或将其放入队列中， 且能实现可撤销操作。
 命令模式结构
1 发送者 （Sender）——亦称 “触发者 （Invoker）”——类负责对请求进行初始化， 其中必须包含一个成员变量来存储对于命令对象的引用。 发送者触发命令， 而不向接收者直接发送请求。 注意， 发送者并不负责创建命令对象： 它通常会通过构造函数从客户端处获得预先生成的命令。
2 命令 （Command） 接口通常仅声明一个执行命令的方法。
3 具体命令 （Concrete Commands） 会实现各种类型的请求。 具体命令自身并不完成工作， 而是会将调用委派给一个业务逻辑对象。 但为了简化代码， 这些类可以进行合并。接收对象执行方法所需的参数可以声明为具体命令的成员变量。 你可以将命令对象设为不可变， 仅允许通过构造函数对这些成员变量进行初始化。
4 接收者 （Receiver） 类包含部分业务逻辑。 几乎任何对象都可以作为接收者。 绝大部分命令只处理如何将请求传递到接收者的细节， 接收者自己会完成实际的工作。
5 客户端 （Client） 会创建并配置具体命令对象。 客户端必须将包括接收者实体在内的所有请求参数传递给命令的构造函数。 此后， 生成的命令就可以与一个或多个发送者相关联了。
 
 命令模式在 Swift 代码中很常见。 大部分情况下， 它被用于代替包含行为的参数化 UI 元素的回调函数， 此外还被用于对任务进行排序和记录操作历史记录等
 */

///命令 （Command） 接口通常仅声明一个执行命令的方法。
protocol Command {
    func execute()
}

///具体命令 （Concrete Commands） 会实现各种类型的请求。 具体命令自身并不完成工作， 而是会将调用委派给一个业务逻辑对象。 但为了简化代码， 这些类可以进行合并。接收对象执行方法所需的参数可以声明为具体命令的成员变量。你可以将命令对象设为不可变， 仅允许通过构造函数对这些成员变量进行初始化。
class SimpleCommand: Command {

    private var payload: String
    init(_ payload: String) {
        self.payload = payload
    }
    func execute() {
        print("SimpleCommand: See, I can do simple things like printing (" + payload + ")")
    }
}

///具体命令 （Concrete Commands） 会实现各种类型的请求。 具体命令自身并不完成工作， 而是会将调用委派给一个业务逻辑对象。 但为了简化代码， 这些类可以进行合并。接收对象执行方法所需的参数可以声明为具体命令的成员变量。你可以将命令对象设为不可变， 仅允许通过构造函数对这些成员变量进行初始化。
class ComplexCommand: Command {
    
    ///绝大部分命令只处理如何将请求传递到接收者的细节， 接收者自己会完成实际的工作。
    private var receiver: Receiver
    private var a: String
    private var b: String

    init(_ receiver: Receiver, _ a: String, _ b: String) {
        self.receiver = receiver
        self.a = a
        self.b = b
    }

    func execute() {
        print("ComplexCommand: Complex stuff should be done by a receiver object.\n")
        receiver.doSomething(a)
        receiver.doSomethingElse(b)
    }
}

///（Receiver） 类包含部分业务逻辑。 几乎任何对象都可以作为接收者。 绝大部分命令只处理如何将请求传递到接收者的细节， 接收者自己会完成实际的工作。
class Receiver {

    func doSomething(_ a: String) {
        print("Receiver: Working on (" + a + ")\n")
    }
    func doSomethingElse(_ b: String) {
        print("Receiver: Also working on (" + b + ")\n")
    }
}

///发送者 （Sender）——亦称 “触发者 （Invoker）”——类负责对请求进行初始化， 其中必须包含一个成员变量来存储对于命令对象的引用。 发送者触发命令， 而不向接收者直接发送请求。 注意， 发送者并不负责创建命令对象： 它通常会通过构造函数从客户端处获得预先生成的命令。
class Invoker {

    private var onStart: Command?

    private var onFinish: Command?

    /// Initialize commands.
    func setOnStart(_ command: Command) {
        onStart = command
    }

    func setOnFinish(_ command: Command) {
        onFinish = command
    }

    /// The Invoker does not depend on concrete command or receiver classes. The
    /// Invoker passes a request to a receiver indirectly, by executing a
    /// command.
    func doSomethingImportant() {

        print("Invoker: Does anybody want something done before I begin?")

        onStart?.execute()

        print("Invoker: ...doing something really important...")
        print("Invoker: Does anybody want something done after I finish?")

        onFinish?.execute()
    }
}

class CommandConceptual: XCTestCase {

    func test() {
        
        let invoker = Invoker()
        invoker.setOnStart(SimpleCommand("Say Hi!"))

        let receiver = Receiver()
        invoker.setOnFinish(ComplexCommand(receiver, "Send email", "Save report"))
        invoker.doSomethingImportant()
    }
}
