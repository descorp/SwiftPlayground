//: [Previous](@previous)

import Foundation

//: [Next](@next)

String(28, radix: 16)
String(28, radix: 2)

var n = ""
for i in 0...36 {
    n += " \(String(i, radix: 36, uppercase: true))"
}
print(n)

let str = "0123456789"

for c in str.unicodeScalars {
    print(c.value)
}
