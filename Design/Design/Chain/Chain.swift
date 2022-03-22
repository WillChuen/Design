//
//  Chain.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation
import XCTest

/*
 责任链模式是一种行为设计模式， 允许你将请求沿着处理者链进行发送。 收到请求后， 每个处理者均可对请求进行处理， 或将其传递给链上的下个处理者。
 责任链模式结构
1 处理者 （Handler） 声明了所有具体处理者的通用接口。 该接口通常仅包含单个方法用于请求处理， 但有时其还会包含一个设置链上下个处理者的方法。
2 基础处理者 （Base Handler） 是一个可选的类， 你可以将所有处理者共用的样本代码放置在其中。通常情况下， 该类中定义了一个保存对于下个处理者引用的成员变量。 客户端可通过将处理者传递给上个处理者的构造函数或设定方法来创建链。 该类还可以实现默认的处理行为： 确定下个处理者存在后再将请求传递给它。
3 具体处理者 （Concrete Handlers） 包含处理请求的实际代码。 每个处理者接收到请求后， 都必须决定是否进行处理， 以及是否沿着链传递请求。处理者通常是独立且不可变的， 需要通过构造函数一次性地获得所有必要地数据。
4 客户端 （Client） 可根据程序逻辑一次性或者动态地生成链。 值得注意的是， 请求可发送给链上的任意一个处理者， 而非必须是第一个处理者。
 
 责任链模式在 Swift 程序中并不常见， 因为它仅在代码与对象链打交道时才能发挥作用。
 
 */

// 处理者 （Handler） 声明了所有具体处理者的通用接口。 该接口通常仅包含单个方法用于请求处理， 但有时其还会包含一个设置链上下个处理者的方法。
protocol Handler: AnyObject {
    
    @discardableResult
    func setNext(handler: Handler) -> Handler
    
    func handle(request: String) -> String?
    
    var nextHandler: Handler? { get set }
}

extension Handler {
    
    func setNext(handler: Handler) -> Handler {
        self.nextHandler = handler
        return handler
    }
    func handle(request: String) -> String? {
        return nextHandler?.handle(request: request)
    }
}

///具体处理者 （Concrete Handlers） 包含处理请求的实际代码。 每个处理者接收到请求后， 都必须决定是否进行处理， 以及是否沿着链传递请求。处理者通常是独立且不可变的， 需要通过构造函数一次性地获得所有必要地数据。
class MonkeyHandler: Handler {
    
    var nextHandler: Handler?
    func handle(request: String) -> String? {
        if (request == "Banana") {
            return "Monkey: I'll eat the " + request + ".\n"
        } else {
            return nextHandler?.handle(request: request)
        }
    }
}

///具体处理者 （Concrete Handlers） 包含处理请求的实际代码。 每个处理者接收到请求后， 都必须决定是否进行处理， 以及是否沿着链传递请求。处理者通常是独立且不可变的， 需要通过构造函数一次性地获得所有必要地数据。
class SquirrelHandler: Handler {
    
    var nextHandler: Handler?
    func handle(request: String) -> String? {

        if (request == "Nut") {
            return "Squirrel: I'll eat the " + request + ".\n"
        } else {
            return nextHandler?.handle(request: request)
        }
    }
}

///具体处理者 （Concrete Handlers） 包含处理请求的实际代码。 每个处理者接收到请求后， 都必须决定是否进行处理， 以及是否沿着链传递请求。处理者通常是独立且不可变的， 需要通过构造函数一次性地获得所有必要地数据。
class DogHandler: Handler {

    var nextHandler: Handler?

    func handle(request: String) -> String? {
        if (request == "MeatBall") {
            return "Dog: I'll eat the " + request + ".\n"
        } else {
            return nextHandler?.handle(request: request)
        }
    }
}

/// The client code is usually suited to work with a single handler. In most
/// cases, it is not even aware that the handler is part of a chain.
class ChainClient {
    // ...
    static func someClientCode(handler: Handler) {

        let food = ["Nut", "Banana", "Cup of coffee"]
        for item in food {
            print("Client: Who wants a " + item + "?\n")
            guard let result = handler.handle(request: item) else {
                print("  " + item + " was left untouched.\n")
                return
            }
            print("  " + result)
        }
    }
    // ...
}

/// Let's see how it all works together.
class ChainOfResponsibilityConceptual: XCTestCase {
 
    func test() {

        let monkey = MonkeyHandler()
        let squirrel = SquirrelHandler()
        let dog = DogHandler()
        monkey.setNext(handler: squirrel).setNext(handler: dog)

        print("Chain: Monkey > Squirrel > Dog\n\n")
        ChainClient.someClientCode(handler: monkey)
        print()
        print("Subchain: Squirrel > Dog\n\n")
        ChainClient.someClientCode(handler: squirrel)
    }
}

