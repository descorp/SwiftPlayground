//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

// MARK: Depencdecny A
protocol HasDependancyA {
    var dependencyA: DependancyA { get }
}
class DependancyA {
}

// MARK: Depencdecny B
protocol HasDependancyB {
    var dependencyB: DependancyB { get }
}
class DependancyB {
}

// MARK: Depencdecny C
protocol HasDependancyC {
    var dependencyC: DependancyC { get }
}
class DependancyC {
}

// MARK: Depencdecny Container
struct AppDependency: HasDependancyA, HasDependancyB, HasDependancyC {
    let dependencyA: DependancyA
    let dependencyB: DependancyB
    let dependencyC: DependancyC
}

class ViewController {
    typealias Dependencies = HasDependancyA & HasDependancyB
    
    var dependencies: Dependencies?
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}
