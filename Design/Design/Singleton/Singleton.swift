//
//  Singleton.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import UIKit

/*
 单例模式是一种创建型设计模式， 让你能够保证一个类只有一个实例， 并提供一个访问该实例的全局节点。
 单例模式结构
 1 单例 （Singleton） 类声明了一个名为 get­Instance获取实例的静态方法来返回其所属类的一个相同实例。单例的构造函数必须对客户端 （Client） 代码隐藏。 调用 获取实例方法必须是获取单例对象的唯一方式。
 */

/*
 将默认构造函数设为私有， 防止其他对象使用单例类的 new运算符。
 新建一个静态构建方法作为构造函数。 该函数会 “偷偷” 调用私有构造函数来创建对象， 并将其保存在一个静态成员变量中。 此后所有对于该函数的调用都将返回这一缓存对象
 
 */
class Singleton {
    
    static var shared: Singleton = {
        let instance = Singleton()
        return instance
    }()
    private init() {}
    func someBusinessLogic() -> String {
        return "Result of the 'someBusinessLogic' call"
    }
}

extension Singleton: NSCopying, NSMutableCopying {
    
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
    func mutableCopy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

class SingletonClient {
    // ...
    static func someClientCode() {
        
        let instance1 = Singleton.shared
        let instance2 = Singleton.shared
        if (instance1 === instance2) {
            print("Singleton works, both variables contain the same instance.")
        } else {
            print("Singleton failed, variables contain different instances.")
        }
    }
    // ...
}
