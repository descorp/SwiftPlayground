//: Playground - noun: a place where people can play

import UIKit

protocol Profilable: CustomStringConvertible {
    mutating func appendTime() -> Double
}

struct ProfilableArray: Profilable {
    private var expected: Int
    private var array: [Int]
    
    init(){
        expected = 0
        array = [Int]()
    }
    
    init(expected: Int){
        self.init()
        self.expected = expected
        array.reserveCapacity(expected)
    }
    
    mutating func appendTime() -> Double {
        let start = Date()
        array.append(42)
        return abs(start.timeIntervalSinceNow)
    }
    
    var description: String {
        return "\(String(describing:type(of: self))) (\(expected))"
    }
}

extension NSMutableArray : Profilable {
    func appendTime() -> Double {
        let start = Date()
        self.adding(42)
        return abs(start.timeIntervalSinceNow)
    }
    
    open override var description: String {
        return "\(String(describing:type(of: self)))"
    }
}

extension CFMutableArray : Profilable {
    func appendTime() -> Double {
        var number = 5
        let start = Date()
        CFArrayAppendValue(self, &number)
        return abs(start.timeIntervalSinceNow)
    }
    
    public var description: String {
        return "\(String(describing:type(of: self)))"
    }
}

struct Result {
    let max: Double
    let avarage: Double
    let min: Double
    let overallTime: Double
}

extension Result: CustomStringConvertible {
    var description: String {
        return "\n Min: \(min)\n Avg: \(avarage)\n Max: \(max)\n Overall: \(overallTime)"
    }
}

func profileWriting(_ array: inout Profilable, with count: Int) -> Result  {
    var max = -1.0
    var min = 1.0
    var sum = 0.0
    let start = Date()
    
    for _ in 1...count {
        
        let time = array.appendTime()
        sum += time
        if time > max {
            max = time
        }
        if time < min {
            min = time
        }
    }
    
    return Result(max: max,
                  avarage: sum / Double(count),
                  min: min,
                  overallTime: abs(start.timeIntervalSinceNow))
}

func run(_ rounds: Int) {
    print("Runing \(rounds) rounds test")
    let suts : [Profilable] = [NSMutableArray(),
                               CFArrayCreateMutable(nil, 0, nil),
                               ProfilableArray(),
                               ProfilableArray(expected: rounds)]
    for var sut in suts {
        print("\(sut) : \(profileWriting(&sut, with: rounds))\n")
    }
}

run(10)

run(100)

run(1000)

run(10000)
