//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

// ----- Swaping two variables

var a = 10
var b = 20

(b, a) = (a, b)

print(a)
print(b)

// ----- Nice fibonacci

func fibonacci(of num: Int) -> Int {
    if num < 2 {
        return num
    } else {
        return fibonacci(of: num - 1) + fibonacci(of: num - 2)
    }
}

let lazyFibonacciSequence = Array(0...199).lazy.map(fibonacci)
print(lazyFibonacciSequence[19])

// Initing doule array

var board = [[String]](repeating: [String](repeating: "", count: 8), count: 8)

rowLoop: for (rowIndex, cols) in board.enumerated() { // Label
    for (colIndex, col) in cols.enumerated() {
        if col == "x" {
            print("Found the treasure at row \(rowIndex) col \(colIndex)!")
            break rowLoop
        }
    }
}

// Nested functions

struct Test {
    /**
     Place text in `backticks` to mark code; on your keyboard these
     usually share a key with tilde, ~.
     * You can write bullets by starting with an asterisk then a
     space.
     * Indent your asterisks to create sublists
     1. You can write numbered listed by starting with 1.
     1. Subsequent items can also be numbered 1. and Xcode will
     renumber them automatically.
     If you want to write a link, [place your text in brackets](https://github.com/Mobiquity/Mobiquity-Europe-Academy/pull/54/files)
     # Headings start with a # symbol
     ## Subheadings start with ##
     ### Sub-subheadings start with ### and are the most common heading style you'll come across
     Write a *single asterisk* around words to make them italic
     Write **two asterisks** around words to make them bold
     
     - Returns: A string containing a date formatted as RFC-822
     - Parameter pref: The name of a Taylor Swift album
     - Parameter track: The track number to load
     - Throws: LoadError.networkFailed, LoadError.writeFailed
     - Complexity: O(1)
     - Precondition: inputArray.count > 0
     - Authors: Paul Hudson
     */
    func funcA(_ pref: String = "") throws -> String {
        func funcB() -> String {
            return "\(pref)B"
        }
        
        return "\(pref)A " + funcB()
    }
}

let test = Test()
try? test.funcA("_")

print("✅")
