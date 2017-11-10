//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

extension Array {
    static func +=(left: inout Array, right: Element) {
        left.append(right)
    }
}

class MyArray<T> {
    var array = Array<T>()

    static func +=(left: MyArray, right: T) {
        left.array.append(right)
    }
}

var array = [Int]()
array += 1


// - - - - - Dictionary - - - - -

enum ProductType {
    case fruit, vegetable, stationery, grocery, dairy, other
}

var products: [(name: String, type: ProductType)] = [("🍎", .fruit),
                                                     ("🍑", .fruit),
                                                     ("🥒", .vegetable),
                                                     ("🥚", .grocery), ("🥛", .dairy)]
var grouped = Dictionary(grouping: products) { item in item.type } .mapValues { items in items.map { item in item.name } }
print(grouped.values.count)
grouped[.other, default: []] += ("🍪")
print(grouped.values.count)
// - - - - - Dictionary - - - - -


print("✅")
