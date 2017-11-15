//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

func generateClosure() -> ()->Void {
    var counter = 0
    
    return {
        counter += 1
        print(counter)
    }
}

let increment = generateClosure()
increment()
increment()

let increment2 = increment
increment2()
