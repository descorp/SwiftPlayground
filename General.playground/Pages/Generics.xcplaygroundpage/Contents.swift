//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


func inspect<T>(_ value: T) {
    print("Received \(type(of: value)) with the value \(value)")
}

inspect(42)
inspect("fsdfsdf")
inspect(Array<Character>([]))


