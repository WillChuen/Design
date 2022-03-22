//
//  Proxy.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation
import XCTest

/*
代理模式是一种结构型设计模式， 让你能够提供对象的替代品或其占位符。 代理控制着对于原对象的访问， 并允许在将请求提交给对象前后进行一些处理。
代理模式结构
1 服务接口 （Service Interface） 声明了服务接口。 代理必须遵循该接口才能伪装成服务对象。
2 服务 （Service） 类提供了一些实用的业务逻辑。
3 代理 （Proxy） 类包含一个指向服务对象的引用成员变量。 代理完成其任务 （例如延迟初始化、 记录日志、 访问控制和缓存等） 后会将请求传递给服务对象。 通常情况下， 代理会对其服务对象的整个生命周期进行管理。
4 客户端 （Client） 能通过同一接口与服务或代理进行交互， 所以你可在一切需要服务对象的代码中使用代理。
 */

/// 服务接口 （Service Interface） 声明了服务接口。 代理必须遵循该接口才能伪装成服务对象。
protocol Subject {
    func request()
}

///服务 （Service） 类提供了一些实用的业务逻辑。
class RealSubject: Subject {
    
    func request() {
        print("RealSubject: Handling request.")
    }
}

///代理 （Proxy） 类包含一个指向服务对象的引用成员变量。 代理完成其任务 （例如延迟初始化、 记录日志、 访问控制和缓存等） 后会将请求传递给服务对象。 通常情况下， 代理会对其服务对象的整个生命周期进行管理。
class Proxy: Subject {
    
    private var realSubject: RealSubject
    init(_ realSubject: RealSubject) {
        self.realSubject = realSubject
    }
    func request() {
        if (checkAccess()) {
            realSubject.request()
            logAccess()
        }
    }
    private func checkAccess() -> Bool {
        print("Proxy: Checking access prior to firing a real request.")
        return true
    }
    private func logAccess() {
        print("Proxy: Logging the time of request.")
    }
}

///客户端 （Client） 能通过同一接口与服务或代理进行交互， 所以你可在一切需要服务对象的代码中使用代理。
class ProxyClient {
    // ...
    static func clientCode(subject: Subject) {
        // ...
        print(subject.request())
        // ...
    }
    // ...
}

/// Let's see how it all works together.
class ProxyConceptual: XCTestCase {

    func test() {
        
        print("Client: Executing the client code with a real subject:")
        let realSubject = RealSubject()
        ProxyClient.clientCode(subject: realSubject)
        
        print("\nClient: Executing the same client code with a proxy:")
        let proxy = Proxy(realSubject)
        ProxyClient.clientCode(subject: proxy)
        
    }
}
