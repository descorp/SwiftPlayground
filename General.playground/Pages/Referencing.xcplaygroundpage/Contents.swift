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

// MARK: references

var globalStrong : ReferrenceProtocol!

func BidirectionalStoredScope(_ left: ReferrenceProtocol, _ right: ReferrenceProtocol) {
    left.reference = right
    right.reference = left
}

func MonodirectionalStoredScope(_ left: ReferrenceProtocol, _ right: ReferrenceProtocol) {
    left.reference = right
}

// MARK: weak references

weak var globalWeak : ReferrenceProtocol?

func StoredViaTemporaryScope(_ left: ReferrenceProtocol, _ right: @autoclosure () -> ReferrenceProtocol) {
    globalWeak = right()
    left.reference = globalWeak
    globalWeak?.reference = left
}

// MARK: experiments

func checkingStrongReferencedStoredInWeakReferenced() {
    print("\n -- Testing StrongReferenced Stored in WeakReferenced :")
    globalStrong = StrongReferenced(value: "StrongReferenced")
    BidirectionalStoredScope(globalStrong!, WeakReferenced(value: "WeakReferenced"))
    
    print("If kill \(globalStrong!.value):")
    globalStrong = nil
}

func checkingStrongReferencedNotStoredInWeakReferenced() {
    print("\n -- Testing StrongReferenced NOT Stored in WeakReferenced :")
    globalStrong = StrongReferenced(value: "StrongReferenced")
    MonodirectionalStoredScope(globalStrong!, WeakReferenced(value: "WeakReferenced"))
    
    print("If kill \(globalStrong!.value):")
    globalStrong = nil
}

func checkingWeakReferencedStoredInStrongReferenced() {
    print("\n -- Testing WeakReferenced Stored in StrongReferenced :")
    globalStrong = WeakReferenced(value: "WeakReferenced")
    BidirectionalStoredScope(StrongReferenced(value: "StrongReferenced"), globalStrong!)
    
    print("If kill \(globalStrong!.value):")
    globalStrong = nil
}

func checkingWeakReferencedNotStoredInStrongReferenced() {
    print("\n -- Testing StrongReferenced NOT Stored in WeakReferenced :")
    globalStrong = WeakReferenced(value: "WeakReferenced")
    MonodirectionalStoredScope(StrongReferenced(value: "StrongReferenced"), globalStrong!)
    
    print("If kill \(globalStrong!.value):")
    globalStrong = nil
}

func checkingStrongReferencedStoredInStrongReferenced() {
    print("\n -- Testing StrongReferenced Stored in StrongReferenced :")
    globalStrong = StrongReferenced(value: "StrongReferenced")
    BidirectionalStoredScope(StrongReferenced(value: "Second StrongReferenced"), globalStrong!)
    
    print("If kill \(globalStrong!.value):")
    globalStrong = nil
}

func checkingStrongReferencedNotStoredInStrongReferenced() {
    print("\n -- Testing StrongReferenced NOT Stored in StrongReferenced :")
    globalStrong = StrongReferenced(value: "StrongReferenced")
    MonodirectionalStoredScope(StrongReferenced(value: "Second StrongReferenced"), globalStrong)
    
    print("If kill \(globalStrong.value):")
    globalStrong = nil
}

func checkingStrongReferencedStoredViaTempInStrongReferenced() {
    print("\n -- Testing StrongReferenced via temp reference stored in StrongReferenced :")
    globalStrong = StrongReferenced(value: "StrongReferenced")
    StoredViaTemporaryScope(StrongReferenced(value: "Second StrongReferenced"), globalStrong)
    
    print("If kill \(globalStrong.value):")
    globalStrong = nil
}

func checkingStrongReferencedStoredViaTempInWeakReferenced() {
    print("\n -- Testing WeakReferenced via temp reference stored in StrongReferenced :")
    globalStrong = StrongReferenced(value: "StrongReferenced")
    StoredViaTemporaryScope(WeakReferenced(value: "WeakReferenced"), globalStrong)
    
    print("If kill \(globalStrong.value):")
    globalStrong = nil
}

func checkingWeakReferencedStoredViaTempInStrongReferenced() {
    print("\n -- Testing StrongReferenced via temp reference stored in StrongReferenced :")
    globalStrong = StrongReferenced(value: "StrongReferenced")
    StoredViaTemporaryScope(globalStrong, StrongReferenced(value: "Second StrongReferenced"))
    
    print("If kill \(globalStrong.value):")
    globalStrong = nil
}

func checkingWeakReferencedStoredViaTempInWeakReferenced() {
    print("\n -- Testing WeakReferenced via temp reference stored in StrongReferenced :")
    globalStrong = WeakReferenced(value: "WeakReferenced")
    StoredViaTemporaryScope(globalStrong, WeakReferenced(value: "WeakReferenced"))
    
    print("If kill \(globalStrong.value):")
    globalStrong = nil
}

//: [Next](@next)

print("✅")

checkingStrongReferencedStoredInWeakReferenced()
checkingStrongReferencedNotStoredInWeakReferenced()
checkingWeakReferencedStoredInStrongReferenced()
checkingWeakReferencedNotStoredInStrongReferenced()
checkingStrongReferencedStoredInStrongReferenced()
checkingStrongReferencedNotStoredInStrongReferenced()
checkingStrongReferencedStoredViaTempInStrongReferenced()
checkingStrongReferencedStoredViaTempInWeakReferenced()
