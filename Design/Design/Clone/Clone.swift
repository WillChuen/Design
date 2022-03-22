//
//  Clone.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import UIKit
import XCTest

/*

 原型模式是一种创建型设计模式， 使你能够复制已有对象， 而又无需使代码依赖它们所属的类。
 原型模式结构
 1 原型 （Prototype） 接口将对克隆方法进行声明。 在绝大多数情况下， 其中只会有一个名为 clone克隆的方法。
 2 具体原型 （Concrete Prototype） 类将实现克隆方法。 除了将原始对象的数据复制到克隆体中之外， 该方法有时还需处理克隆过程中的极端情况， 例如克隆关联对象和梳理递归依赖等等。
 3 客户端 （Client） 可以复制实现了原型接口的任何对象。
 
 */

//Swift 的 NSCopying  （克隆） 接口就是立即可用的原型模式
class BaseClass: NSCopying, Equatable {

    private var intValue = 1
    private var stringValue = "Value"

    required init(intValue: Int = 1, stringValue: String = "Value") {

        self.intValue = intValue
        self.stringValue = stringValue
    }
    /// MARK: - NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        
        let prototype = type(of: self).init()
        prototype.intValue = intValue
        prototype.stringValue = stringValue
        print("Values defined in BaseClass have been cloned!")
        return prototype
    }
    /// MARK: - Equatable
    static func == (lhs: BaseClass, rhs: BaseClass) -> Bool {
        return lhs.intValue == rhs.intValue && lhs.stringValue == rhs.stringValue
    }
}

class SubClass: BaseClass {

    private var boolValue = true

    func copy() -> Any {
        return copy(with: nil)
    }

    override func copy(with zone: NSZone?) -> Any {
        guard let prototype = super.copy(with: zone) as? SubClass else {
            return SubClass() // oops
        }
        prototype.boolValue = boolValue
        print("Values defined in SubClass have been cloned!")
        return prototype
    }
}


class CloneClient {
    // ...
    static func someClientCode() {
        
        let original = SubClass(intValue: 2, stringValue: "Value2")
        guard let _ = original.copy() as? SubClass else {
            return
        }
        print("The original object is equal to the copied object!")
    }
    // ...
}

class PrototypeConceptual: XCTestCase {

    func testPrototype_NSCopying() {
        CloneClient.someClientCode()
    }
}




