//: [Previous](@previous)

import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

var str = "Hello, playground"

//: [Next](@next)

class Item: CustomStringConvertible {
    private let value: Int
    init(value: Int) {
        self.value = value
    }
    
    var description: String {
        return String(value)
    }
}

class Test {
    static func calculate(devide by: Int, callback: @escaping (Array<Item>) -> Void ) {
        let queue = OperationQueue()
        var suts = [Array<Item>]()
        
        let start = CFAbsoluteTimeGetCurrent()
        let completionOperation = BlockOperation {
            let end = CFAbsoluteTimeGetCurrent() - start
            let result = Array<Item>(suts.joined())
            print("Division in \(by):\n  Took \(end) seconds\n  Array: \(result.count)")
            callback(result)
        }
        
        let devision = 1000000 / by
        for range in 0...(by-1) {
            let operation = BlockOperation {
                let subrange = range
                var sut = Array<Item>()
                sut.reserveCapacity(devision)
                for a in (subrange)*devision...(subrange + 1)*devision {
                    sut.append(Item(value: a))
                }
                suts.append(sut)
            }
            completionOperation.addDependency(operation)
            queue.addOperation(operation)
        }
        
        OperationQueue.main.addOperation(completionOperation)
    }
}

print("✅")
print("Runing in 100 threads")
DispatchQueue.global().sync {
    Test.calculate(devide: 100) { _ in
    }
}

print("Runing in 10 threads")
DispatchQueue.global().sync {
    Test.calculate(devide: 10) { _ in
    }
}


print("Runing in 1 thread]")
DispatchQueue.global().sync {
    Test.calculate(devide: 1) { _ in
    }
}
