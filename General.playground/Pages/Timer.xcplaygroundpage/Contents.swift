//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

private let lock = NSRecursiveLock()
func synchronize(closure: ()->()){
    lock.lock()
    defer {
        closure()
        lock.unlock()
    }
}

var n = 0.0
let loop = RunLoop.current
let interval = 0.000005

var timer = Timer(timeInterval: interval, repeats: true) { _ in
    synchronize() {
        n = 1
    }
}
var timer2 = Timer(timeInterval: interval, repeats: true) { _ in
    synchronize() {
        n = 0
    }
}
var timer4 = Timer(timeInterval: interval, repeats: true) { _ in
    synchronize() {
        n = -1
    }
}
var timer3 = Timer(timeInterval: 1, repeats: true) { _ in
    synchronize() {
        if abs(n) > 0.01 {
            print("Incorrect! \(n)")
        }
    }
}

loop.add(timer2, forMode: .defaultRunLoopMode)
loop.add(timer, forMode: .defaultRunLoopMode)
loop.add(timer3, forMode: .defaultRunLoopMode)
loop.add(timer4, forMode: .defaultRunLoopMode)

//loop.run()

