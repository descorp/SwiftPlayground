//: [Previous](@previous)

import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

var str = "Hello, playground"

//: [Next](@next)

extension Date {
    var asString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS"
        return formatter.string(from: self)
    }
}

protocol ProxyProtocal {
    func call(action: @autoclosure () -> Void)
}

class Proxy: ProxyProtocal {
    private let max: Int
    private let interval: Int
    private var counter = 0
    private var isTimerSet = false
    
    init(max: Int, interval: Int) {
        self.max = max
        self.interval = interval
    }
    
    func call(action: @autoclosure () -> Void) {
        if !isTimerSet {
            self.isTimerSet = true
            Timer.scheduledTimer(withTimeInterval: Double(interval), repeats: false) { [unowned self] _ in
                self.counter = 0
                self.isTimerSet = false
            }
        }
        
        DispatchQueue.global().sync { [unowned self] in
            guard self.counter < self.max else {
                print("\(Date().asString) Denied!")
                return
            }
            
            counter += 1
            action()
        }
    }
}

func test(proxy: ProxyProtocal) {
    for i in 1...30 {
        Timer.scheduledTimer(withTimeInterval: Double(i) * 0.09, repeats: false) { _ in
            proxy.call(action: print("\(Date().asString) \(i) done!"))
        }
    }
}

print("✅")

test(proxy: Proxy(max: 10, interval: 1))
