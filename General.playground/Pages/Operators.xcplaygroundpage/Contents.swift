//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

struct BigInteger {
    
    private var array: [Int8]
    private var positive: Bool
    
    init(value: Int = 0) {
        positive = value >= 0
        array = BigInteger.splitOnDigits(UInt64(abs(value)))
    }
    
    init(value: Int64) {
        positive = value >= 0
        array = BigInteger.splitOnDigits(UInt64(abs(value)))
    }
    
    init(value: UInt64) {
        positive = value >= 0
        array = BigInteger.splitOnDigits(value)
    }
    
    private static func splitOnDigits(_ value: UInt64) -> [Int8] {
        var result = [Int8]()
        var temp = value
        
        while temp > 0 {
            result.append(Int8(temp % 10))
            temp = temp / 10
        }
        
        return result
    }
}

extension BigInteger {
    private func copy() -> BigInteger {
        var result = BigInteger()
        result.array = self.array
        result.positive = self.positive
        return result
    }
}

extension BigInteger: Equatable {
    static func ==(lhs: BigInteger, rhs: BigInteger) -> Bool {
        if lhs.positive != rhs.positive {
            return false
        }
        
        if lhs.array.count != rhs.array.count {
            return false
        }
        
        return lhs.array.elementsEqual(rhs.array)
    }
}

extension BigInteger: Comparable {
    /// Returns a Boolean value indicating whether the value of the first
    /// argument is less than that of the second argument.
    ///
    /// This function is the only requirement of the `Comparable` protocol. The
    /// remainder of the relational operator functions are implemented by the
    /// standard library for any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    static func <(lhs: BigInteger, rhs: BigInteger) -> Bool {
        return BigInteger.equal(lhs, rhs) < 0
    }
    
    /// Returns a Boolean value indicating whether the value of the first
    /// argument is less than or equal to that of the second argument.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    static func <=(lhs: BigInteger, rhs: BigInteger) -> Bool {
        return BigInteger.equal(lhs, rhs) <= 0
    }
    
    /// Returns a Boolean value indicating whether the value of the first
    /// argument is greater than or equal to that of the second argument.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    static func >=(lhs: BigInteger, rhs: BigInteger) -> Bool {
        return BigInteger.equal(lhs, rhs) >= 0
    }
    
    /// Returns a Boolean value indicating whether the value of the first
    /// argument is greater than that of the second argument.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    static func >(lhs: BigInteger, rhs: BigInteger) -> Bool {
        return BigInteger.equal(lhs, rhs) > 0
    }
    
    static private func equal(_ lhs: BigInteger, _ rhs: BigInteger) -> Int {
        switch (lhs.positive, rhs.positive) {
        case let (a, b) where a == b && !a:
            return -BigInteger.equal(-lhs, -rhs)
        case let (a, b):
            return !a && b ? 1 : -1
        }
        
        if lhs.array.count != rhs.array.count {
            return lhs.array.count < rhs.array.count ? -1 : 1
        }
        
        for var i in (lhs.array.count-1)...0 {
            let lhsv = lhs.array[i]
            let rhsv = rhs.array[i]
            if lhsv != rhsv {
                return lhsv < rhsv ? -1 : 1
            }
        }
        
        return 0
    }
}

extension BigInteger {
    
    // MARK: addition
    static func +(lhs: BigInteger, rhs: BigInteger) -> BigInteger {
        return BigInteger()
    }
    
    static func +(lhs: BigInteger, rhs: Int) -> BigInteger {
        return BigInteger()
    }
    
    static func +(lhs: Int, rhs: BigInteger) -> BigInteger {
        return BigInteger()
    }
    
    static func +=(lhs: inout BigInteger, rhs: BigInteger) {
        
    }
    
    static func +=(lhs: inout BigInteger, rhs: Int) {
        
    }
    
    // MARK: subtraction
    static func -(lhs: BigInteger, rhs: BigInteger) -> BigInteger {
        return BigInteger()
    }
    
    static func -(lhs: BigInteger, rhs: Int) -> BigInteger {
        return BigInteger()
    }
    
    static func -(lhs: Int, rhs: BigInteger) -> BigInteger {
        return BigInteger()
    }
    
    static func -=(lhs: inout BigInteger, rhs: BigInteger) {
        
    }
    
    static func -=(lhs: inout BigInteger, rhs: Int) {
        
    }
    
    // MARK: multiplication
    static func *(lhs: BigInteger, rhs: BigInteger) -> BigInteger {
        return BigInteger()
    }
    
    static func *(lhs: BigInteger, rhs: Int) -> BigInteger {
        return BigInteger()
    }
    
    static func *(lhs: Int, rhs: BigInteger) -> BigInteger {
        return BigInteger()
    }
    
    static func *=(lhs: inout BigInteger, rhs: BigInteger) {
        
    }
    
    static func *=(lhs: inout BigInteger, rhs: Int) {
        
    }
    
    // MARK: division
    static func /(lhs: BigInteger, rhs: BigInteger) -> BigInteger {
        return BigInteger()
    }
    
    static func /(lhs: BigInteger, rhs: Int) -> BigInteger {
        return BigInteger()
    }
    
    static func /(lhs: Int, rhs: BigInteger) -> BigInteger {
        return BigInteger()
    }
    
    static func /=(lhs: inout BigInteger, rhs: BigInteger) {
        
    }
    
    static func /=(lhs: inout BigInteger, rhs: Int) {
        
    }
    
    // MARK: negation
    static prefix func -(item: BigInteger) -> BigInteger {
        var result = item.copy()
        result.positive = !result.positive
        return result
    }
    
    // MARK: power
    static func ^(lhs: BigInteger, rhs: Int) -> BigInteger {
        if(rhs == 0) { return BigInteger(value: 1) }
        if(rhs == 1) { return lhs }
        
        var temp = lhs.copy()
        for i in 1...rhs {
            temp *= lhs
        }
        
        return temp
    }
}

extension BigInteger: CustomPlaygroundQuickLookable  {
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        var str = ""
        array.reversed().forEach { i in str += String(i) }
        return .text(str)
    }
}


var a = BigInteger()
var b = BigInteger(value: 5444)
var c = BigInteger(value: 5445)
print(a > b)
print(b > b)
print(b >= b)
print(b == b)
print(b < c)
print(b < -c)


