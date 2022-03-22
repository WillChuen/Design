//
//  DesignTests.swift
//  DesignTests
//
//  Created by 钟维 on 2022/3/21.
//

import XCTest
@testable import Design

class DesignTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        cloneTest()
    }
    
    //一般工厂
    func factoryTest() {
        print("具体创建者1")
        Client.someClientCode(creator: ConcreteCreator1())
        print("\n具体创建者2")
        Client.someClientCode(creator: ConcreteCreator2())
    }
    
    //抽象工厂
    func abstractTest() {
        
        print("Client: Testing client code with the first factory type:")
        AbstractClient.someClientCode(factory: ConcreteFactory1())

        print("Client: Testing the same client code with the second factory type:")
        AbstractClient.someClientCode(factory: ConcreteFactory2())
        
    }
    
    //生成器
    func builderClientTest() {
        let director = Director()
        BuilderClient.someClientCode(director: director)
    }
    
    //原型
    func cloneTest() {
        CloneClient.someClientCode()
    }
    
    //单例
    func SingletonTest() {
        SingletonClient.someClientCode()
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
