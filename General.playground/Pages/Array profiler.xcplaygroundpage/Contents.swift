//: Playground - noun: a place where people can play

import UIKit

protocol Profilable: CustomStringConvertible {
    mutating func write() -> TimeInterval
    func read() -> TimeInterval
    func enumerate() -> TimeInterval
}

struct ProfilableArray: Profilable {
    private var capacity: Int
    private var array: [String]
    
    init(capacity: Int = 0){
        array = [String]()
        self.capacity = capacity
        array.reserveCapacity(capacity)
    }
    
    mutating func write() -> Double {
        let start = Date()
        array.append("42")
        let finish = Date()
        return finish.timeIntervalSince(start)
    }
    
    func read() -> Double {
        let i = Int(arc4random_uniform(UInt32(array.count)))
        let start = Date()
        let _ = array[i]
        let finish = Date()
        return finish.timeIntervalSince(start)
    }
    
    func enumerate() -> Double {
        let start = Date()
        array.forEach { _ in }
        let finish = Date()
        return finish.timeIntervalSince(start)
    }
    
    var description: String {
        return "\(String(describing:type(of: array))) (\(capacity))"
    }
}



class ProfilableNSMutableArray : Profilable {
    var capacity: Int
    var array: NSMutableArray
    
    init(capacity: Int = 0){
        array = NSMutableArray(capacity: capacity)
        self.capacity = capacity
    }
    
    func write() -> Double {
        let start = Date()
        array.add("42")
        let finish = Date()
        return finish.timeIntervalSince(start)
    }
    
    func read() -> Double {
        let i = Int(arc4random_uniform(UInt32(array.count)))
        let start = Date()
        let _ = array[i]
        let finish = Date()
        return finish.timeIntervalSince(start)
    }
    
     func enumerate() -> Double {
        let start = Date()
        array.forEach { _ in }
        let finish = Date()
        return finish.timeIntervalSince(start)
    }
    
    var description: String {
        return "\(String(describing:type(of: array))) (\(capacity))"
    }
}

class ProfilableCFMutableArray : Profilable {
    
    var capacity: Int
    var array: CFMutableArray!
    
    init(capacity: Int = 0) {
        self.capacity = capacity
        array = CFArrayCreateMutable(nil, capacity, nil)
    }
    
    func write() -> Double {
        var item = "5"
        let start = Date()
        CFArrayAppendValue(array, &item)
        let finish = Date()
        return finish.timeIntervalSince(start)
    }
    
    func read() -> Double {
        let count = CFArrayGetCount(array)
        let i = Int(arc4random_uniform(UInt32(count)))
        let start = Date()
        CFArrayGetValueAtIndex(array, CFIndex(i))
        let finish = Date()
        return finish.timeIntervalSince(start)
    }
    
    func enumerate() -> Double {
        var item = "6"
        let count = CFArrayGetCount(array)
        let start = Date()
        CFArrayGetFirstIndexOfValue(array, CFRange.init(location: CFIndex(), length: count), &item)
        let finish = Date()
        return finish.timeIntervalSince(start)
    }
    
    public var description: String {
        
        return "\(String(describing:type(of: array))) \(capacity)"
    }
}

class Result {
    private var _count: Int = 0
    private var _total: Double = 0
    
    var min: Double
    var max: Double
    
    init() {
        min = Double.infinity
        max = Double.infinity * (-1)
    }
    
    var avarage: Double {
        get {
            return _total / Double(_count)
        }
    }
    
    var total: Double {
        get {
            return _total
        }
        
        set(value) {
            _total = value
            _count += 1
        }
    }
}

extension TimeInterval {
    var toString: String {
        let ti = NSInteger(self)
        let ms = Int((self.truncatingRemainder(dividingBy: 1.0)) * 1000)
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
    }
}

extension Result: CustomStringConvertible {
    var description: String {
        return "\n Min . . \(min.toString)" +
            "\n Avg . . \(avarage.toString)" +
            "\n Max . . \(max.toString)" +
            "\n Total . \(total.toString)"
    }
}

func profile(_ action: @autoclosure () -> TimeInterval, with count: Int) -> Result {
    let result = Result()
    for _ in 1...count {
        let time = action()
        result.total += time
        
        if time > result.max {
            result.max = time
        }
        
        if time < result.min {
            result.min = time
        }
    }
    
    return result
}

func run(_ rounds: Int) {
    print("Runing \(rounds) rounds test")
    let suts : [Profilable] = [ProfilableNSMutableArray(),
                               ProfilableNSMutableArray(capacity: rounds),
                               ProfilableCFMutableArray(),
                               ProfilableCFMutableArray(capacity: rounds),
                               ProfilableArray(),
                               ProfilableArray(capacity: rounds)]
    for var sut in suts {
        print("\(sut) :\n")
        print("Write : \(profile(sut.write(), with: rounds))\n")
        print("Read : \(profile(sut.read(), with: 100))\n")
        print("Enumerate : \(profile(sut.enumerate(), with: 4))\n")
    }
}

print("✅")

run(100)

run(1000)

run(10000)

