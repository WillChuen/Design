//
//  Adapter.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation
import XCTest

/*
 适配器模式是一种结构型设计模式， 它能使接口不兼容的对象能够相互合作。
 实现时使用了构成原则： 适配器实现了其中一个对象的接口， 并对另一个对象进行封装
1 客户端 （Client） 是包含当前程序业务逻辑的类。
2 客户端接口 （Client Interface） 描述了其他类与客户端代码合作时必须遵循的协议。
3 服务 （Service） 中有一些功能类 （通常来自第三方或遗留系统）。 客户端与其接口不兼容， 因此无法直接调用其功能。
4 适配器 （Adapter） 是一个可以同时与客户端和服务交互的类： 它在实现客户端接口的同时封装了服务对象。 适配器接受客户端通过适配器接口发起的调用， 并将其转换为适用于被封装服务对象的调用。
5 客户端代码只需通过接口与适配器交互即可， 无需与具体的适配器类耦合。 因此， 你可以向程序中添加新类型的适配器而无需修改已有代码。 这在服务类的接口被更改或替换时很有用： 你无需修改客户端代码就可以创建新的适配器类。
 
 适配器不仅可以转换不同格式的数据， 其还有助于采用不同接口的对象之间的合作
 适配器实现与其中一个现有对象兼容的接口
 现有对象可以使用该接口安全地调用适配器方法
 适配器方法被调用后将以另一个对象兼容的格式和顺序将请求传递给该对象
 
 适配器模式在 Swift 代码中很常见。 基于一些遗留代码的系统常常会使用该模式。 在这种情况下， 适配器让遗留代码与现代的类得以相互合作
 */

//需要被适配的类
class Target {
    func request() -> String {
        return "Target: The default target's behavior."
    }
}

//需要适配的类
class Adaptee {
    public func specificRequest() -> String {
        return ".eetpadA eht fo roivaheb laicepS"
    }
}

/// 适配器实现了其中一个对象的接口， 并对另一个对象进行封装
/// 适配器 （Adapter） 是一个可以同时与客户端和服务交互的类： 它在实现客户端接口的同时封装了服务对象。 适配器接受客户端通过适配器接口发起的调用， 并将其转换为适用于被封装服务对象的调用。
class Adapter: Target {
    
    //被封装的对象
    private var adaptee: Adaptee
    init(_ adaptee: Adaptee) {
        self.adaptee = adaptee
    }
    //需要实现的接口
    override func request() -> String {
        return "Adapter: (TRANSLATED) " + adaptee.specificRequest().reversed()
    }
}

///客户端 （Client） 是包含当前程序业务逻辑的类。
class AdapterClient {
    
    static func someClientCode(target: Target) {
        print(target.request())
    }
}

/// Let's see how it all works together.
class AdapterConceptual: XCTestCase {

    func testAdapterConceptual() {
        print("Client: I can work just fine with the Target objects:")
        AdapterClient.someClientCode(target: Target())

        let adaptee = Adaptee()
        print("Client: The Adaptee class has a weird interface. See, I don't understand it:")
        print("Adaptee: " + adaptee.specificRequest())

        print("Client: But I can work with it via the Adapter:")
        AdapterClient.someClientCode(target: Adapter(adaptee))
    }
}
