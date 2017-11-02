//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


enum Answer {
    case yes
    case no
    case maybe(percent: Float)
}

let survey: [Answer] = [.yes, .no, .maybe(percent: 0.25), .maybe(percent: 0.5), .maybe(percent: 0.80), .maybe(percent: 0.9)]

let pro = survey.map( x in x == .yes ) //( case .yes || (case let .maybe(percent) where percent > 0.5)).count

print("✅")
