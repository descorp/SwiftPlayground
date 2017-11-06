//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

class A {
    init() {
        print("A created")
    }
}

class B {
    static let a = A()
    
    init() {
        print("B created")
    }
}

class C {
    lazy var someMutableLazyParameter: String = {
        return "Some"
    }()
    
    private(set) lazy var someImutableLazyParameter: String = {
        return "Some"
    }()
}


print("✅")

let b = B()
print("but not an A")

let a = B.a
print("only after been called")


print("\n --- trying lazy value ---")
let c = C()
print(c.someImutableLazyParameter)

c.someMutableLazyParameter = { return "Some other parameter" }()
print(c.someMutableLazyParameter)


// ------ Lazy collection ------
print(" -- Lazy collection --")

func fibonacci(of num: Int) -> Int {
    if num < 2 {
        return num
    } else {
        return fibonacci(of: num - 1) + fibonacci(of: num - 2)
    }
}

let lazyFibonacciSequence = Array(0...199).lazy.map(fibonacci)
print(lazyFibonacciSequence[19])
