//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

enum Answer {
    case yes
    case no
    case maybe(percent: Float)
}

let survey: [Answer] = [.yes,
                        .no,
                        .maybe(percent: 0.25),
                        .maybe(percent: 0.5),
                        .maybe(percent: 0.80),
                        .maybe(percent: 0.9)]

let pro = survey.filter {
    switch $0 {
    case .yes:
        return true
    case let .maybe(percent) where percent > 0.5:
        return true
    default:
        return false
    }
}

print(" Pro: \(pro.count) / Con: \(survey.count - pro.count)")


print("✅")
