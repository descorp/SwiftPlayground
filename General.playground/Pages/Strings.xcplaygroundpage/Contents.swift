//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

String(28, radix: 16)
String(28, radix: 2)

var n = ""
for i in 0...36 {
    n += " \(String(i, radix: 36, uppercase: true))"
}
print(n)
