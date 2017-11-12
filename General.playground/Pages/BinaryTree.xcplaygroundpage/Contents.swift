//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

class Node: Comparable {
    var left: Node?
    var right: Node?
    var value: Int = 0
    
    init(_ value: Int) {
        self.value = value
    }
    
    static func <(lhs: Node, rhs: Node) -> Bool {
        return lhs.value < rhs.value
    }
    
    static func ==(lhs: Node, rhs: Node) -> Bool {
        return lhs.value == rhs.value
    }
}

class Tree {
    private var array = [Node]()
    
    subscript(index: Int) -> Node? {
        get {
            return array[index]
        }
        
        set(value) {
            if let value = value {
                array[index] = value
            } else {
                array.remove(at: index)
            }
        }
    }
    
    static func +=(left: Tree, right: Node) {
        left.addNode(right)
    }
    
    private func addNode(_ node: Node) {
        
    }
}
