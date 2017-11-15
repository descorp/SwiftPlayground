//: [Previous](@previous)

import Foundation

// - - - - - - - - - - - - -
// - - - - - Array - - - - -
// - - - - - - - - - - - - -

// += operator for array

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


// Agregating array into string

let a = [1,2,3,4,5,6,7,8,9,0]

extension Array where Element: BinaryInteger {
    
    /// Agregates all elements of Integer-based array into one string
    /// - Parameter prefix: string sequence that will be placed before actual content of the array
    /// - Returns: A string that agregates whole array into one string
    func toString(prefix: String = "") -> String {
        return self.reduce(prefix) { (current, next) in current + String(describing: next)}
    }
}

print(a.toString())
print(a.toString(prefix: "-"))

// Looking for Max in array

let someArray = [ 1, 98,  33, -5, 22, 3, 55, 9, 99, 4]

let max = someArray.reduce(Int.min) { (max, next) in (max < next) ? next : max }
print(max)

let twomax = someArray.reduce((Int.min, Int.min)) {
    (maxs, next) in ((maxs.0 < next)                            ? next : maxs.0,
                     (maxs.0 < next) ? maxs.0 : (maxs.1 < next) ? next : maxs.1)
}
print(twomax)

// - - - - - - - - - - - - - - -
// - - - - Dictionary- - - - - -
// - - - - - - - - - - - - - - -

enum ProductType {
    case fruit, vegetable, stationery, grocery, dairy, other
}

var products: [(name: String, type: ProductType)] = [("🍎", .fruit),
                                                     ("🍑", .fruit),
                                                     ("🥒", .vegetable),
                                                     ("🥚", .grocery),
                                                     ("🥛", .dairy)]
var grouped = Dictionary(grouping: products) { item in item.type } .mapValues { items in items.map { item in item.name } }
print(grouped.values.count)
grouped[.other, default: []] += ("🍪")
print(grouped.values.count)

// - - - - - - - - - - - - -
// - - - - - Set - - - - - -
// - - - - - - - - - - - - -

var set = Set<Int>([1, 2, 3, 4, 5, 6, 7])
var fibonacciSet = Set<Int>([1, 2, 3, 5, 8])

if set.insert(8).inserted {
    print("Inserted")
}

if set.remove(9) == nil{
    print("No such element")
}

print(set.isStrictSuperset(of: fibonacciSet))
let difference = set.symmetricDifference(fibonacciSet)

print("✅")
