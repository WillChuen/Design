//
//  Proxy.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation

protocol Subject {
    func request()
}

class RealSubject: Subject {

    func request() {
        print("RealSubject: Handling request.")
    }
}

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

class ProxyClient {
    // ...
    static func clientCode(subject: Subject) {
        // ...
        print(subject.request())
        // ...
    }
    // ...
}
