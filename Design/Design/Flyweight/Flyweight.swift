//
//  Flyweight.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation
import XCTest

/*
 
 享元模式是一种结构型设计模式， 它摒弃了在每个对象中保存所有数据的方式， 通过共享多个对象所共有的相同状态， 让你能在有限的内存容量中载入更多对象。
 享元模式结构
1 享元模式只是一种优化。 在应用该模式之前， 你要确定程序中存在与大量类似对象同时占用内存相关的内存消耗问题， 并且确保该问题无法使用其他更好的方式来解决。
2 享元 （Flyweight） 类包含原始对象中部分能在多个对象中共享的状态。 同一享元对象可在许多不同情景中使用。 享元中存储的状态被称为 “内在状态”。 传递给享元方法的状态被称为 “外在状态”。
3 情景 （Context） 类包含原始对象中各不相同的外在状态。 情景与享元对象组合在一起就能表示原始对象的全部状态。
4 通常情况下， 原始对象的行为会保留在享元类中。 因此调用享元方法必须提供部分外在状态作为参数。 但你也可将行为移动到情景类中， 然后将连入的享元作为单纯的数据对象。
5 客户端 （Client） 负责计算或存储享元的外在状态。 在客户端看来， 享元是一种可在运行时进行配置的模板对象， 具体的配置方式为向其方法中传入一些情景数据参数。
6 享元工厂 （Flyweight Factory） 会对已有享元的缓存池进行管理。 有了工厂后， 客户端就无需直接创建享元， 它们只需调用工厂并向其传递目标享元的一些内在状态即可。 工厂会根据参数在之前已创建的享元中进行查找， 如果找到满足条件的享元就将其返回； 如果没有找到就根据参数新建享元。
 
 仅在程序必须支持大量对象且没有足够的内存容量时使用享元模式
 应用该模式所获的收益大小取决于使用它的方式和情景
 程序需要生成数量巨大的相似对象
 这将耗尽目标设备的所有内存
 对象中包含可抽取且能在多个对象间共享的重复状态
 
 享元模式只有一个目的： 将内存消耗最小化。 如果你的程序没有遇到内存容量不足的问题， 则可以暂时忽略该模式。
 */

/// 享元 （Flyweight） 类包含原始对象中部分能在多个对象中共享的状态。 同一享元对象可在许多不同情景中使用。 享元中存储的状态被称为 “内在状态”。 传递给享元方法的状态被称为 “外在状态”。
class Flyweight {
    
    private let sharedState: [String]
    init(sharedState: [String]) {
        self.sharedState = sharedState
    }
    func operation(uniqueState: [String]) {
        print("Flyweight: Displaying shared (\(sharedState)) and unique (\(uniqueState) state.\n")
    }
}

/// 享元工厂 （Flyweight Factory） 会对已有享元的缓存池进行管理。 有了工厂后， 客户端就无需直接创建享元， 它们只需调用工厂并向其传递目标享元的一些内在状态即可。 工厂会根据参数在之前已创建的享元中进行查找， 如果找到满足条件的享元就将其返回； 如果没有找到就根据参数新建享元。
class FlyweightFactory {

    private var flyweights: [String: Flyweight]

    init(states: [[String]]) {

        var flyweights = [String: Flyweight]()
        for state in states {
            flyweights[state.key] = Flyweight(sharedState: state)
        }
        self.flyweights = flyweights
    }
    
    func flyweight(for state: [String]) -> Flyweight {
        
        let key = state.key
        guard let foundFlyweight = flyweights[key] else {

            print("FlyweightFactory: Can't find a flyweight, creating new one.\n")
            let flyweight = Flyweight(sharedState: state)
            flyweights.updateValue(flyweight, forKey: key)
            return flyweight
        }
        print("FlyweightFactory: Reusing existing flyweight.\n")
        return foundFlyweight
    }
    
    func printFlyweights() {
        print("FlyweightFactory: I have \(flyweights.count) flyweights:\n")
        for item in flyweights {
            print(item.key)
        }
    }
}

extension Array where Element == String {
    
    var key: String {
        return self.joined()
    }
}

class FlyweightConceptual: XCTestCase {

    func testFlyweight() {
        
        let factory = FlyweightFactory(states:
        [
            ["Chevrolet", "Camaro2018", "pink"],
            ["Mercedes Benz", "C300", "black"],
            ["Mercedes Benz", "C500", "red"],
            ["BMW", "M5", "red"],
            ["BMW", "X6", "white"]
        ])

        factory.printFlyweights()
        
        addCarToPoliceDatabase(factory,
                "CL234IR",
                "James Doe",
                "BMW",
                "M5",
                "red")

        addCarToPoliceDatabase(factory,
                "CL234IR",
                "James Doe",
                "BMW",
                "X1",
                "red")

        factory.printFlyweights()
    }

    func addCarToPoliceDatabase(
            _ factory: FlyweightFactory,
            _ plates: String,
            _ owner: String,
            _ brand: String,
            _ model: String,
            _ color: String) {
                
        print("Client: Adding a car to database.\n")
        let flyweight = factory.flyweight(for: [brand, model, color])
        flyweight.operation(uniqueState: [plates, owner])
    }
}
