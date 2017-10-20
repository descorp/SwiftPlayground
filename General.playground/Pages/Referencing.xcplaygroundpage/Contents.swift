//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

protocol ReferrenceProtocol: class, CustomStringConvertible {
    var reference: ReferrenceProtocol? { get set }
    var value: String { get }
}

extension ReferrenceProtocol  {
    var description: String {
        return "Ref contains \( reference?.value ?? "Nil")"
    }
}

class StrongReferenced: ReferrenceProtocol {
    var reference: ReferrenceProtocol?
    let value: String
    
    init(value: String) {
        self.value = value
        print("\(value) init")
    }
    
    deinit {
        print("\(value) destroyed")
    }
}

class WeakReferenced : ReferrenceProtocol {
    weak var reference: ReferrenceProtocol?
    let value: String
    
    init(value: String) {
        self.value = value
        print("\(value) init")
    }
    
    deinit {
        print("\(value) destroyed")
    }
}

func BidirectionalStoredScope(_ left: ReferrenceProtocol, _ right: ReferrenceProtocol) {
    left.reference = right
    right.reference = left
}

func MonodirectionalStoredScope(_ left: ReferrenceProtocol, _ right: ReferrenceProtocol) {
    left.reference = right
}

var a : StrongReferenced?
var b : WeakReferenced?
var c : StrongReferenced?

func checkingStrongReferencedStoredInWeakReferenced() {
    print("\n -- Testing StrongReferenced Stored in WeakReferenced :")
    a = StrongReferenced(value: "StrongReferenced")
    BidirectionalStoredScope(a!, WeakReferenced(value: "WeakReferenced"))
    
    print("If kill \(a!.value):")
    a = nil
}

func checkingStrongReferencedNotStoredInWeakReferenced() {
    print("\n -- Testing StrongReferenced NOT Stored in WeakReferenced :")
    a = StrongReferenced(value: "StrongReferenced")
    MonodirectionalStoredScope(a!, WeakReferenced(value: "WeakReferenced"))
    
    print("If kill \(a!.value):")
    a = nil
}

func checkingWeakReferencedStoredInStrongReferenced() {
    print("\n -- Testing WeakReferenced Stored in StrongReferenced :")
    b = WeakReferenced(value: "WeakReferenced")
    BidirectionalStoredScope(StrongReferenced(value: "StrongReferenced"), b!)
    
    print("If kill \(b!.value):")
    b = nil
}

func checkingWeakReferencedNotStoredInStrongReferenced() {
    print("\n -- Testing StrongReferenced NOT Stored in WeakReferenced :")
    b = WeakReferenced(value: "WeakReferenced")
    MonodirectionalStoredScope(StrongReferenced(value: "StrongReferenced"), b!)
    
    print("If kill \(b!.value):")
    b = nil
}

func checkingStrongReferencedStoredInStrongReferenced() {
    print("\n -- Testing StrongReferenced Stored in StrongReferenced :")
    c = StrongReferenced(value: "StrongReferenced")
    BidirectionalStoredScope(StrongReferenced(value: "StrongReferenced"), c!)
    
    print("If kill \(c!.value):")
    c = nil
}

func checkingStrongReferencedNotStoredInStrongReferenced() {
    print("\n -- Testing StrongReferenced NOT Stored in StrongReferenced :")
    c = StrongReferenced(value: "Second StrongReferenced")
    MonodirectionalStoredScope(StrongReferenced(value: "StrongReferenced"), c!)
    
    print("If kill \(c!.value):")
    c = nil
}

//: [Next](@next)

print("✅")

checkingStrongReferencedStoredInWeakReferenced()
checkingStrongReferencedNotStoredInWeakReferenced()
checkingWeakReferencedStoredInStrongReferenced()
checkingWeakReferencedNotStoredInStrongReferenced()
checkingStrongReferencedStoredInStrongReferenced()
checkingStrongReferencedNotStoredInStrongReferenced()
