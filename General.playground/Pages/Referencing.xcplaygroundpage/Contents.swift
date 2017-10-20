//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

protocol AProtocol: class, CustomStringConvertible {
    var value: String {get}
}

protocol BProtocol: class, CustomStringConvertible {
    var value: String {get}
}


class A : AProtocol {
    weak var b: BProtocol?
    let value: String
    
    init(value: String) {
        self.value = value
    }
    
    var description: String {
        return b?.value ?? "Nil"
    }
    
    deinit {
        print("A destroyed")
    }
}

class B : BProtocol {
    weak var a: AProtocol?
    let value: String
    
    init(value: String) {
        self.value = value
    }
    
    var description: String {
        return a?.value ?? "Nil"
    }
    
    deinit {
        print("B destroyed")
    }
}

let a = A(value: "A")

func someScope() {
    a.b = B(value: "B")
}

print(a)

someScope()
print(a)


//: [Next](@next)

print("✅")
