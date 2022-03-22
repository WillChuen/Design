//
//  Combination.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation
import XCTest

/*
 组合模式是一种结构型设计模式， 你可以使用它将对象组合成树状结构， 并且能像使用独立对象一样使用它们。
 组合模式结构
1 组件 （Component） 接口描述了树中简单项目和复杂项目所共有的操作。
2 叶节点 （Leaf） 是树的基本结构， 它不包含子项目。一般情况下， 叶节点最终会完成大部分的实际工作， 因为它们无法将工作指派给其他部分。
3 容器 （Container）——又名 “组合 （Composite）”——是包含叶节点或其他容器等子项目的单位。 容器不知道其子项目所属的具体类， 它只通过通用的组件接口与其子项目交互。容器接收到请求后会将工作分配给自己的子项目， 处理中间结果， 然后将最终结果返回给客户端。
4 客户端 （Client） 通过组件接口与所有项目交互。 因此， 客户端能以相同方式与树状结构中的简单或复杂项目交互。
 
 // 应用的核心模型能用树状结构表示， 在应用中使用组合模式才有价值
 // 希望客户端代码以相同方式处理简单和复杂元素， 可以使用该模式
 
 组合模式在 Swift 代码中很常见， 常用于表示与图形打交道的用户界面组件或代码的层次结构
 
 比如渲染树
 */

///组件 （Component） 接口描述了树中简单项目和复杂项目所共有的操作。
protocol Component {
    
    //父组件
    var parent: Component? { get set }
    func add(component: Component)
    func remove(component: Component)
    
    //是否是组合
    func isComposite() -> Bool
    func operation() -> String
}

///组件扩展
extension Component {

    func add(component: Component) {}
    func remove(component: Component) {}
    func isComposite() -> Bool {
        return false
    }
}

/// 叶节点 （Leaf） 是树的基本结构， 它不包含子项目。一般情况下， 叶节点最终会完成大部分的实际工作， 因为它们无法将工作指派给其他部分。
class Leaf: Component {
    
    var parent: Component?
    func operation() -> String {
        return "Leaf"
    }
}

/// 容器 （Container）——又名 “组合 （Composite）”——是包含叶节点或其他容器等子项目的单位。 容器不知道其子项目所属的具体类， 它只通过通用的组件接口与其子项目交互。容器接收到请求后会将工作分配给自己的子项目， 处理中间结果， 然后将最终结果返回给客户端。
class Composite: Component {
    
    var parent: Component?
    //包含其它叶节点 或者其它容器
    private var children = [Component]()
    //添加其它节点
    func add(component: Component) {
        var item = component
        item.parent = self
        children.append(item)
    }
    //移除其它节点
    func remove(component: Component) {
        // ...
    }
    //组合
    func isComposite() -> Bool {
        return true
    }
    //组合操作
    func operation() -> String {
        let result = children.map({ $0.operation() })
        return "Branch(" + result.joined(separator: " ") + ")"
    }
}

//客户端 （Client） 通过组件接口与所有项目交互。 因此， 客户端能以相同方式与树状结构中的简单或复杂项目交互。
class ComponentClient {
    
    static func someClientCode(component: Component) {
        print("Result: " + component.operation())
    }
    
    static func moreComplexClientCode(leftComponent: Component, rightComponent: Component) {
        if leftComponent.isComposite() {
            leftComponent.add(component: rightComponent)
        }
        print("Result: " + leftComponent.operation())
    }
}

/// Let's see how it all comes together.
class CompositeConceptual: XCTestCase {

    func testCompositeConceptual() {

        /// This way the client code can support the simple leaf components...
        print("Client: I've got a simple component:")
        ComponentClient.someClientCode(component: Leaf())

        /// ...as well as the complex composites.
        let tree = Composite()

        let branch1 = Composite()
        branch1.add(component: Leaf())
        branch1.add(component: Leaf())

        let branch2 = Composite()
        branch2.add(component: Leaf())
        branch2.add(component: Leaf())

        tree.add(component: branch1)
        tree.add(component: branch2)

        print("\nClient: Now I've got a composite tree:")
        ComponentClient.someClientCode(component: tree)

        print("\nClient: I don't need to check the components classes even when managing the tree:")
        ComponentClient.moreComplexClientCode(leftComponent: tree, rightComponent: Leaf())
    }
}

