//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

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
        let start = CFAbsoluteTimeGetCurrent()
        array.append("42")
        return CFAbsoluteTimeGetCurrent() - start
    }
    
    func read() -> Double {
        let i = Int(arc4random_uniform(UInt32(array.count)))
        let start = CFAbsoluteTimeGetCurrent()
        let _ = array[i]
        return CFAbsoluteTimeGetCurrent() - start
    }
    
    func enumerate() -> Double {
        let start = CFAbsoluteTimeGetCurrent()
        array.forEach { _ in }
        return CFAbsoluteTimeGetCurrent() - start
    }
    
    var description: String {
        return "  Array \(capacity > 0 ? "R " : "NR")   "
    }
}

struct ProfilableContiguousArray: Profilable {
    private var capacity: Int
    private var array: ContiguousArray<String>
    
    init(capacity: Int = 0){
        array = ContiguousArray<String>()
        self.capacity = capacity
        array.reserveCapacity(capacity)
    }
    
    mutating func write() -> Double {
        let start = CFAbsoluteTimeGetCurrent()
        array.append("42")
        return CFAbsoluteTimeGetCurrent() - start
    }
    
    func read() -> Double {
        let i = Int(arc4random_uniform(UInt32(array.count)))
        let start = CFAbsoluteTimeGetCurrent()
        let _ = array[i]
        return CFAbsoluteTimeGetCurrent() - start
    }
    
    func enumerate() -> Double {
        let start = CFAbsoluteTimeGetCurrent()
        array.forEach { _ in }
        return CFAbsoluteTimeGetCurrent() - start
    }
    
    var description: String {
        return "ContArray \(capacity > 0 ? "R " : "NR") "
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
        let start = CFAbsoluteTimeGetCurrent()
        array.add("42")
        return CFAbsoluteTimeGetCurrent() - start
    }
    
    func read() -> Double {
        let i = Int(arc4random_uniform(UInt32(array.count)))
        let start = CFAbsoluteTimeGetCurrent()
        let _ = array[i]
        return CFAbsoluteTimeGetCurrent() - start
    }
    
     func enumerate() -> Double {
        let start = CFAbsoluteTimeGetCurrent()
        array.forEach { _ in }
        return CFAbsoluteTimeGetCurrent() - start
    }
    
    var description: String {
        return "  NSArray \(capacity > 0 ? "R " : "NR") "
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
        let start = CFAbsoluteTimeGetCurrent()
        CFArrayAppendValue(array, &item)
        return CFAbsoluteTimeGetCurrent() - start
    }
    
    func read() -> Double {
        let count = CFArrayGetCount(array)
        let i = Int(arc4random_uniform(UInt32(count)))
        let start = CFAbsoluteTimeGetCurrent()
        CFArrayGetValueAtIndex(array, CFIndex(i))
        return CFAbsoluteTimeGetCurrent() - start
    }
    
    func enumerate() -> Double {
        var item = "6"
        let count = CFArrayGetCount(array)
        let start = CFAbsoluteTimeGetCurrent()
        CFArrayGetFirstIndexOfValue(array, CFRange.init(location: CFIndex(), length: count), &item)
        return CFAbsoluteTimeGetCurrent() - start
    }
    
    public var description: String {
        return "  CFArray \(capacity > 0 ? "R " : "NR") "
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
        let ti = Int(self)
        let ms = Int((self.truncatingRemainder(dividingBy: 1) * 100000))
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        
        return String(format: "%0.2d:%0.2d.%0.5d", minutes, seconds, ms)
    }
}

extension Result {
    var toString: String {
        return " \(min.toString) | \(avarage.toString) | \(max.toString) | \(total.toString)"
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
    let suts : [Profilable] = [ProfilableNSMutableArray(),
                               ProfilableNSMutableArray(capacity: rounds),
                               ProfilableContiguousArray(),
                               ProfilableContiguousArray(capacity: rounds),
                               ProfilableCFMutableArray(),
                               ProfilableCFMutableArray(capacity: rounds),
                               ProfilableArray(),
                               ProfilableArray(capacity: rounds)]
    let group = DispatchGroup()
    
    var results = [(type: Profilable, write: Result, read: Result, enumerate: Result)]()
    for var sut in suts {
        group.enter()
        DispatchQueue.global().async {
            results.append((type: sut,
                            write: profile(sut.write(), with: rounds),
                            read: profile(sut.read(), with: 100),
                            enumerate: profile(sut.enumerate(), with: 4)))
            group.leave()
        }
    }
    
    group.notify(queue: .main) {
        print("\n # # # Runing \(rounds) rounds test # # #")
        print("\n-- Write --")
        print("    Type     |     Min     |     Avg     |     Max     |    Total    ")
        results.sorted { $0.type.description > $1.type.description } .forEach { (type, write, _, _) in
            print("\(type)|\(write.toString)")
        }
        
        print("\n-- Read --")
        print("    Type     |     Min     |     Avg     |     Max     |    Total    ")
        results.sorted { $0.type.description > $1.type.description } .forEach { (type, _, read, _) in
            print("\(type)|\(read.toString)")
        }
        
        print("\n-- Enumerate --")
        print("    Type     |     Min     |     Avg     |     Max     |    Total    ")
        results.sorted { $0.type.description > $1.type.description } .forEach { (type, _, _, enumerate) in
            print("\(type)|\(enumerate.toString)")
        }
    }
}

print("✅")

DispatchQueue.global().sync {
    run(100)
}

DispatchQueue.global().sync {
    run(1000)
}

DispatchQueue.global().sync {
    run(10000)
}

