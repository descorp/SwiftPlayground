//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

let array = [("A", 1), ("B", 2), ("C", 3), ("А", 1), ("Б", 2), ("В", 3)]

print(" --- With condition ---\n")
for case (let letter, 2) in array {
    print(letter)
}

print(" --- As parametric value ---\n")
for case let (letter, number) in array {
    print("\(letter) : \(number)")
}

print(" --- As parametric value with post-condition ---\n")
for case let (letter, number) in array where 0...2 ~= number {
    print("\(letter) : \(number)")
}

print(" --- As parametric value ---\n")
func check(_ a: String?, _ b: String?) {
    switch (a, b) {
    case let (.some(a), .none):
        print ("\(a) - no b")
    case (_, "B"?):
        print ("second is B !")
    case (let value?, _) where value == "A":
        print ("first is A !")
    case let (.some(a), .some(b)):
        print ("\(a) - \(b)")
    case (.none , .none):
         print("empty")
    default:
        print("something else")
    }
}

check(nil, nil)
check("A", "B")
check("a", nil)
check("A", "b")


// Simple fizzbuzz on Swift
func fizzbuzz(number: Int) -> String {
    switch (number % 3 == 0, number % 5 == 0) {
    case (true, false):
        return "Fizz"
    case (false, true):
        return "Buzz"
    case (true, true):
        return "FizzBuzz"
    case (false, false):
        return String(number)
    }
}

print("✅")
