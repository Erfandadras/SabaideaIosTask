//
//  Array+replace.swift
//  BSLA tech task
//
//  Created by Erfan mac mini on 10/1/24.
//

import Foundation

public extension Array {
    mutating func replaceOrAppend<Value>(_ item: Element,
                                         firstMatchingKeyPath keyPath: KeyPath<Element, Value>)
    where Value: Equatable
    {
        let itemValue = item[keyPath: keyPath]
        replaceOrAppend(item, whereFirstIndex: { $0[keyPath: keyPath] == itemValue })
    }
    
    mutating func replaceOrAppend(_ item: Element, whereFirstIndex predicate: (Element) -> Bool) {
        if let idx = self.firstIndex(where: predicate){
            self[idx] = item
        } else {
            append(item)
        }
    }
}

extension Array where Element: Hashable {
   mutating func removingDuplicates() {
        var seen = Set<Element>()
        self = self.filter { seen.insert($0).inserted }
    }
}