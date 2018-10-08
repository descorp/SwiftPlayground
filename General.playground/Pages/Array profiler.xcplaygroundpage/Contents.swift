//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

enum MeasureType {
    case write, read, enumerate, check
}

protocol Profilable: class, CustomStringConvertible {
    func getAction(_ type: MeasureType) -> () -> Void
}

extension Profilable {
    func measure(_ type: MeasureType) -> TimeInterval {
        let block = self.getAction(type)
        let start = CFAbsoluteTimeGetCurrent()
        block()
        return CFAbsoluteTimeGetCurrent() - start
    }
}

class ProfilableArray: Profilable {
    private var capacity: Int
    private var array: [String]
    private var string = "42"
    
    init(capacity: Int = 0){
        array = [String]()
        self.capacity = capacity
        array.reserveCapacity(capacity)
    }
    
    func getAction(_ type: MeasureType) -> () -> Void {
        let i = Int(arc4random_uniform(UInt32(array.count)))
        
        switch type {
        case .write:
            return { [unowned self] in self.array.append(self.string) }
        case .read:
            return { [unowned self] in let _ = self.array[i] }
        case .enumerate:
            return { [unowned self] in self.array.forEach { _ in } }
        case .check:
            return { [unowned self] in print(self.array.count > 0 ? "Nice" : "Not Nice") }
        }
    }
    
    var description: String {
        return "    Array   \(capacity > 0 ? "R " : "NR")   "
    }
}

class SomeClass {}

class ProfilableObjectArray: Profilable {
    private var capacity: Int
    private var array: [SomeClass]
    private let object = SomeClass()
    
    init(capacity: Int = 0){
        array = [SomeClass]()
        self.capacity = capacity
        array.reserveCapacity(capacity)
    }
    
    func getAction(_ type: MeasureType) -> () -> Void {
        let i = Int(arc4random_uniform(UInt32(array.count)))
        
        switch type {
        case .write:
            return { [unowned self] in self.array.append(self.object) }
        case .read:
            return { [unowned self] in let _ = self.array[i] }
        case .enumerate:
            return { [unowned self] in self.array.forEach { _ in } }
        case .check:
            return { [unowned self] in print(self.array.count > 0 ? "Nice" : "Not Nice") }
        }
    }
    
    var description: String {
        return " ArrayClass \(capacity > 0 ? "R " : "NR")   "
    }
}

class ProfilableContiguousArray: Profilable {
    private var capacity: Int
    private var array: ContiguousArray<String>
    
    init(capacity: Int = 0){
        array = ContiguousArray<String>()
        self.capacity = capacity
        array.reserveCapacity(capacity)
    }
    
    func getAction(_ type: MeasureType) -> () -> Void {
        let i = Int(arc4random_uniform(UInt32(array.count)))
        
        switch type {
        case .write:
            return { [unowned self] in self.array.append("42") }
        case .read:
            return { [unowned self] in let _ = self.array[i] }
        case .enumerate:
            return { [unowned self] in self.array.forEach { _ in } }
        case .check:
            return { [unowned self] in print(self.array.count > 0 ? "Nice" : "Not Nice") }
        }
    }
    
    var description: String {
        return " Contiguous \(capacity > 0 ? "R " : "NR")   "
    }
}

class ProfilableNSMutableArray : Profilable {
    var capacity: Int
    var array: NSMutableArray
    
    init(capacity: Int = 0){
        array = NSMutableArray(capacity: capacity)
        self.capacity = capacity
    }
    
    func getAction(_ type: MeasureType) -> () -> Void {
        let i = Int(arc4random_uniform(UInt32(array.count)))
        
        switch type {
        case .write:
            return { [unowned self] in self.array.add("42") }
        case .read:
            return { [unowned self] in let _ = self.array[i] }
        case .enumerate:
            return { [unowned self] in self.array.forEach { _ in } }
        case .check:
            return { [unowned self] in print(self.array.count > 0 ? "Nice" : "Not Nice") }
        }
    }
    
    var description: String {
        return "    NSArray \(capacity > 0 ? "R " : "NR")   "
    }
}

class ProfilableCFMutableArray : Profilable {
    
    var capacity: Int
    var array: CFMutableArray!
    
    init(capacity: Int = 0) {
        self.capacity = capacity
        array = CFArrayCreateMutable(nil, capacity, nil)
    }
    
    func getAction(_ type: MeasureType) -> () -> Void {
        var item = "5"
        var other_item = "6"
        let count = CFArrayGetCount(array)
        let i = Int(arc4random_uniform(UInt32(count)))
        
        switch type {
        case .write:
            return { [unowned self] in CFArrayAppendValue(self.array, &item) }
        case .read:
            return { [unowned self] in CFArrayGetValueAtIndex(self.array, CFIndex(i)) }
        case .enumerate:
            return { [unowned self] in CFArrayGetFirstIndexOfValue(self.array, CFRange.init(location: CFIndex(), length: count), &other_item) }
        case .check:
            return { [unowned self] in print( Int(CFArrayGetCount(self.array)) > 0 ? "Nice" : "Not Nice") }
        }
    }
    
    public var description: String {
        return "    CFArray \(capacity > 0 ? "R " : "NR")   "
    }
}

class MeasurementResult {
    private var _count: Int = 0
    private var _total: Double = 0
    
    var type: MeasureType
    var min: Double
    var max: Double
    
    init(type: MeasureType) {
        self.type = type
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

extension MeasurementResult {
    var toString: String {
        return " \(min.toString) | \(avarage.toString) | \(max.toString) | \(total.toString)"
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

class Profiler {
    private init() {}
    
    static func run(_ rounds: Int) {
        var results = [(type: Profilable, results: [MeasurementResult])]()
        let group = DispatchGroup()
        
        let suts : [Profilable] = [ProfilableNSMutableArray(),
                                   ProfilableNSMutableArray(capacity: rounds),
                                   ProfilableContiguousArray(),
                                   ProfilableContiguousArray(capacity: rounds),
                                   ProfilableCFMutableArray(),
                                   ProfilableCFMutableArray(capacity: rounds),
                                   ProfilableArray(),
                                   ProfilableArray(capacity: rounds),
                                   ProfilableObjectArray(),
                                   ProfilableObjectArray(capacity: rounds)]
        for sut in suts {
            group.enter()
            DispatchQueue.global().async {
                results.append((type: sut,
                                results: [profile(.write, sut.measure, with: rounds),
                                          profile(.read, sut.measure, with: 100),
                                          profile(.enumerate, sut.measure, with: 10)]))
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("\n # # # Runing \(rounds) rounds test # # #")
            printOut(results.sorted(by: { $0.type.description > $1.type.description }))
        }
    }
    
    private static func printOut(_ measurements: [(type: Profilable, results: [MeasurementResult])]) {
        var n = 0
        measurements.first?.results.forEach { measurement in
            print("\n-- \(measurement.type) --")
            print("       Type      |     Min     |     Avg     |     Max     |    Total    ")
            measurements.forEach { (type, results) in
                print("\(type)|\(results[n].toString)")
            }
            n += 1
        }
    }
    
    private static func profile(_ type: MeasureType,
                                _ action: (MeasureType) -> TimeInterval,
                                with count: Int) -> MeasurementResult {
        let result = MeasurementResult(type: type)
        for _ in 1...count {
            let time = action(type)
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
}

print("✅")

let runner = DispatchQueue(label: "Runner",
                          qos: DispatchQoS.userInteractive,
                          attributes: DispatchQueue.Attributes.concurrent ,
                          autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit,
                          target: nil)

runner.async {
    Profiler.run(512)
}

runner.async {
    Profiler.run(10000)
}

runner.async {
    Profiler.run(100000)
}


