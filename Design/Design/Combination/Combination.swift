//
//  Combination.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation

/*
 
 组合模式是一种结构型设计模式， 你可以使用它将对象组合成树状结构， 并且能像使用独立对象一样使用它们。
 组合模式结构
1 组件 （Component） 接口描述了树中简单项目和复杂项目所共有的操作。
2 叶节点 （Leaf） 是树的基本结构， 它不包含子项目。一般情况下， 叶节点最终会完成大部分的实际工作， 因为它们无法将工作指派给其他部分。
3 容器 （Container）——又名 “组合 （Composite）”——是包含叶节点或其他容器等子项目的单位。 容器不知道其子项目所属的具体类， 它只通过通用的组件接口与其子项目交互。容器接收到请求后会将工作分配给自己的子项目， 处理中间结果， 然后将最终结果返回给客户端。
4 客户端 （Client） 通过组件接口与所有项目交互。 因此， 客户端能以相同方式与树状结构中的简单或复杂项目交互。
 */

protocol Component {
    
    var parent: Component? { get set }
    func add(component: Component)
    func remove(component: Component)
    func isComposite() -> Bool
    func operation() -> String
}

extension Component {

    func add(component: Component) {}
    func remove(component: Component) {}
    func isComposite() -> Bool {
        return false
    }
}

class Leaf: Component {

    var parent: Component?

    func operation() -> String {
        return "Leaf"
    }
}

class Composite: Component {

    var parent: Component?
    private var children = [Component]()
    func add(component: Component) {
        var item = component
        item.parent = self
        children.append(item)
    }

    func remove(component: Component) {
        // ...
    }

    func isComposite() -> Bool {
        return true
    }
    func operation() -> String {
        let result = children.map({ $0.operation() })
        return "Branch(" + result.joined(separator: " ") + ")"
    }
}

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
