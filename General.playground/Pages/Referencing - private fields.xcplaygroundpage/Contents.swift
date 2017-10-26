//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

class Item {
    weak var parent: Container?
    
    deinit {
        print("Item destroyed")
    }
}

class Container {
    weak var item: Item?
    
    init() {
        print("Item created")
    }
    
    func initItem() {
        print("At first \(self)")
        item = Item()
        print("When leaving local scope \(self)")
    }
    
    func initItemAsClosure(_ item: @autoclosure () -> Item) {
        print("At first \(self)")
        self.item = item()
        print("When leaving local scope \(self)")
    }
    
    func initItemAsClosureForSure(_ item: @autoclosure () -> Item) {
        print("At first \(self)")
        let temp = item()
        self.item = temp
        print("When leaving local scope \(self)")
    }
    
    func initItemForSure() {
        print("At first \(self)")
        let temp = Item()
        item = temp
        print("When leaving local scope \(self)")
    }
    
    func initItemAndAssignContainer() {
        print("At first \(self)")
        item = Item()
        item?.parent = self
        print("When leaving local scope \(self)")
    }
    
    func initItemForSureAssignContainer() {
        print("At first \(self)")
        let temp = Item()
        item = temp
        item?.parent = self
        print("When leaving local scope \(self)")
    }
    
    deinit {
        print("Container destroyed")
    }
}

extension Optional {
    var isNil: String {
        return self != nil ? "is not Nil" : "is Nil"
    }
}

extension Container: CustomStringConvertible {
    var description: String {
        return "item \(item != nil ? "not Nil and parent \(item?.parent.isNil ?? "** string unwraper **")" : "is Nil" )"
    }
}

print("✅")

func initWeak() {
    let sut = Container()
    sut.initItem()
    print("\nLeaving global scope")
}

func initWeakForSure() {
    let sut = Container()
    sut.initItemForSure()
    print("\nLeaving global scope")
}

func initWeakWithClosure() {
    let sut = Container()
    sut.initItemAsClosure(Item())
    print("\nLeaving global scope")
}

func initWeakWithClosureForSure() {
    let sut = Container()
    sut.initItemAsClosureForSure(Item())
    print("\nLeaving global scope")
}

func initWeakAndAssignContainer() {
    let sut = Container()
    sut.initItemAndAssignContainer()
    print("\nLeaving global scope")
}

func initWeakForSureAndAssignContainer() {
    let sut = Container()
    sut.initItemForSureAssignContainer()
    print("\nLeaving global scope")
}

print("\n--Trying init weak")
initWeak()

print("\n--Trying init weak for sure")
initWeakForSure()

print("\n--Trying init weak with closure")
initWeakWithClosure()

print("\n--Trying init weak with closure for sure")
initWeakWithClosureForSure()

print("\n--Trying init weak and assign container")
initWeakAndAssignContainer()

print("\n--Trying init weak for sure and assign container")
initWeakForSureAndAssignContainer()
