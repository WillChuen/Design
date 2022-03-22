//
//  Iterator.swift
//  Design
//
//  Created by 钟维 on 2022/3/22.
//

import Foundation


class WordsCollection {

    fileprivate lazy var items = [String]()
    func append(_ item: String) {
        self.items.append(item)
    }
}

extension WordsCollection: Sequence {

    func makeIterator() -> WordsIterator {
        return WordsIterator(self)
    }
}

class WordsIterator: IteratorProtocol {

    private let collection: WordsCollection
    private var index = 0

    init(_ collection: WordsCollection) {
        self.collection = collection
    }

    func next() -> String? {
        defer { index += 1 }
        return index < collection.items.count ? collection.items[index] : nil
    }
}


class NumbersCollection {
    
    fileprivate lazy var items = [Int]()
    func append(_ item: Int) {
        self.items.append(item)
    }
}

extension NumbersCollection: Sequence {

    func makeIterator() -> AnyIterator<Int> {
        var index = self.items.count - 1
        return AnyIterator {
            defer { index -= 1 }
            return index >= 0 ? self.items[index] : nil
        }
    }
}


class IteratorClient {
    // ...
    static func clientCode<S: Sequence>(sequence: S) {
        for item in sequence {
            print(item)
        }
    }
    // ...
}
