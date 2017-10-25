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
    let localStrong = StrongReferenced(value: "StrongReferenced")
    BidirectionalStoredScope(localStrong, WeakReferenced(value: "WeakReferenced"))
    
    print("If \(localStrong.value) leave the scope:")
}

func checkingStrongReferencedNotStoredInWeakReferenced() {
    print("\n -- Testing StrongReferenced NOT Stored in WeakReferenced :")
    let localStrong = StrongReferenced(value: "StrongReferenced")
    MonodirectionalStoredScope(localStrong, WeakReferenced(value: "WeakReferenced"))
    
    print("If \(localStrong.value) leave the scope:")
}

func checkingWeakReferencedStoredInStrongReferenced() {
    print("\n -- Testing WeakReferenced Stored in StrongReferenced :")
    let localStrong = WeakReferenced(value: "WeakReferenced")
    BidirectionalStoredScope(StrongReferenced(value: "StrongReferenced"), localStrong)
    
    print("If \(localStrong.value) leave the scope:")
}

func checkingWeakReferencedNotStoredInStrongReferenced() {
    print("\n -- Testing StrongReferenced NOT Stored in WeakReferenced :")
    let localStrong = WeakReferenced(value: "WeakReferenced")
    MonodirectionalStoredScope(StrongReferenced(value: "StrongReferenced"), localStrong)
    
    print("If \(localStrong.value) leave the scope:")
}

func checkingStrongReferencedStoredInStrongReferenced() {
    print("\n -- Testing StrongReferenced Stored in StrongReferenced :")
    let localStrong = StrongReferenced(value: "StrongReferenced")
    BidirectionalStoredScope(StrongReferenced(value: "Second StrongReferenced"), localStrong)
    
    print("If \(localStrong.value) leave the scope:")
}

func checkingStrongReferencedNotStoredInStrongReferenced() {
    print("\n -- Testing StrongReferenced NOT Stored in StrongReferenced :")
    let localStrong = StrongReferenced(value: "StrongReferenced")
    MonodirectionalStoredScope(StrongReferenced(value: "Second StrongReferenced"), localStrong)
    
    print("If \(localStrong.value) leave the scope:")
}

func checkingStrongReferencedStoredViaTempInStrongReferenced() {
    print("\n -- Testing StrongReferenced via temp reference stored in WeakReferenced :")
    let localStrong = WeakReferenced(value: "Local WeakReferenced")
    StoredViaTemporaryScope(localStrong, StrongReferenced(value: "StrongReferenced"))
    
    print("If \(localStrong.value) leave the scope:")
}

func checkingStrongReferencedStoredViaTempInWeakReferenced() {
    print("\n -- Testing WeakReferenced via temp reference stored in StrongReferenced :")
    let localStrong = StrongReferenced(value: "Local StrongReferenced")
    StoredViaTemporaryScope(localStrong, WeakReferenced(value: "WeakReferenced"))
    
    print("If \(localStrong.value) leave the scope:")
}

func checkingWeakReferencedStoredViaTempInStrongReferenced() {
    print("\n -- Testing StrongReferenced via temp reference stored in Local StrongReferenced :")
    let localStrong = StrongReferenced(value: "Local StrongReferenced")
    StoredViaTemporaryScope(localStrong, StrongReferenced(value: "Second StrongReferenced"))
    
    print("If \(localStrong.value) leave the scope:")
}

func checkingWeakReferencedStoredViaTempInWeakReferenced() {
    print("\n -- Testing WeakReferenced via temp reference stored in WeakReferenced :")
    let localStrong = WeakReferenced(value: "Local WeakReferenced")
    StoredViaTemporaryScope(localStrong, WeakReferenced(value: "Second WeakReferenced"))
    
    print("If \(localStrong.value) leave the scope:")
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
checkingWeakReferencedStoredViaTempInStrongReferenced()
checkingWeakReferencedStoredViaTempInWeakReferenced()
