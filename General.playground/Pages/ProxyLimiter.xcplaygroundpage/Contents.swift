//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

protocol ProxyProtocal {
    func call(action: @autoclosure () -> Void)
}

class Proxy: ProxyProtocal {
    private let max: Int
    private let interval: Int
    private var isTimerSet = false
    
    private var n = 0
    private let lock = NSRecursiveLock()
    
    private var counter: Int {
        get {
            var temp: Int?
            synchronize {
                temp = n
            }
            return temp!
        }
        set(value) {
            synchronize {
                n = value
            }
        }
    }
    
    init(max: Int, interval: Int) {
        self.max = max
        self.interval = interval
    }
    
    func call(action: @autoclosure () -> Void) {
        if !isTimerSet {
            let deadlineTime = DispatchTime.now() + .seconds(interval)
            DispatchQueue.global().asyncAfter(deadline: deadlineTime) {
                    self.synchronize {
                        self.counter = 0
                        self.isTimerSet = false
                    }
            }
        }
        
        guard counter < max else {
            print("Denied!")
            return
        }
        
        counter += 1
        action()
    }
    
    private func synchronize(closure: ()->()){
        lock.lock()
        defer {
            closure()
            lock.unlock()
        }
    }
}

func test(proxy: ProxyProtocal) {
    
    for _ in 0...12 {
        proxy.call(action: print("done!"))
    }
    
    print("\nwaiting..\n")
    sleep(2)
    
    for _ in 0...12 {
        proxy.call(action: print("done!"))
    }
    
    print("\nwaiting..\n")
    sleep(2)
    
    for _ in 0...12 {
        proxy.call(action: print("done!"))
    }
}

print("✅")

test(proxy: Proxy(max: 10, interval: 1))
