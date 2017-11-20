//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

class SomeRef: CustomDebugStringConvertible {
    var value: Int
    init(value: Int) {
        self.value = value
    }
    
    var debugDescription: String {
        return "Ref(\(value))"
    }
}

struct SomeValue: CustomDebugStringConvertible {
    var value: Int
    
    var debugDescription: String {
        return "Val(\(value))"
    }
}

protocol DataContract: CustomDebugStringConvertible {
    var int: Int {get set}
    var array: [SomeValue] {get set}
    var objectArray: [SomeRef] {get set}
    var object: SomeRef {get set}
    
    mutating func change()
    
    mutating func mutatingTest()
    func nonmutatingTest()
}

extension DataContract {
    mutating func mutatingTest() {
        let otherValue = self
        self.change()
        
        print("\n --After mutating :")
        print(" -Origine:\n\(self)")
        print("\n -Copy:\n\(otherValue)")
    }
    
    func nonmutatingTest() {
        var otherValue = self
        otherValue.change()
        
        print("\n --After nonmutating :")
        print(" -Origine:\n\(self)")
        print("\n -Copy:\n\(otherValue)")
    }
    
    mutating func change() {
        self.int = 7
        self.array.append(SomeValue(value: 6))
        self.array[0].value = -1
        self.array[1] = SomeValue(value: -2)
        self.objectArray.append(SomeRef(value: 8))
        self.objectArray[0].value = -1
        self.objectArray[1] = SomeRef(value: -2)
        self.object.value = 7
    }
}

extension DataContract {
    var debugDescription: String {
        return
        """
        \(type(of: self))
        int: \(int)
        array: \(array)
        objectArray: \(objectArray)
        object: \(object)
        """
    }
}

struct ValueData: DataContract {
    var int: Int
    var array: [SomeValue]
    var objectArray: [SomeRef]
    var object: SomeRef
}

class RefData: DataContract {
    var int: Int
    var array: [SomeValue]
    var objectArray: [SomeRef]
    var object: SomeRef
    
    init(int: Int, array: [SomeValue], objectArray: [SomeRef], object: SomeRef) {
        self.int = int
        self.array = array
        self.objectArray = objectArray
        self.object = object
    }
}


let int = 6
let array = [SomeValue(value: 1), SomeValue(value: 2), SomeValue(value: 3), SomeValue(value: 4), SomeValue(value: 5) ]
let objectArray = [SomeRef(value: 1), SomeRef(value: 2), SomeRef(value: 3), SomeRef(value: 4), SomeRef(value: 5) ]
let object = SomeRef(value: 6)

// Value types
var value = ValueData(int: int, array: array, objectArray: objectArray, object: object)
print("\n -- Before :")
print(value)

value.mutatingTest()
ValueData(int: int, array: array, objectArray: objectArray, object: object).nonmutatingTest()

// Reference types
var ref = RefData(int: int, array: array, objectArray: objectArray, object: object)
print("\n -- Before :")
DispatchQueue.global().sync {
    print(ref)
    DispatchQueue.global().sync {
        ref.mutatingTest()
        RefData(int: int, array: array, objectArray: objectArray, object: object).nonmutatingTest()
    }
}


print("✅")
