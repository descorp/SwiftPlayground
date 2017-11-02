//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

class HTMLElement {
    
    let name: String
    let text: String?
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
        print("\(type(of: self)) allocated" )
    }
    
    lazy var wrong_asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    lazy var asHTML: () -> String = { [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    deinit {
        print("\(type(of: self)) deallocated" )
    }
}

func someWrongScope() {
    let tag = HTMLElement(name: "p", text: "Some content")
    print(tag.wrong_asHTML())
}

func someScope() {
    let tag = HTMLElement(name: "p", text: "Some content")
    print(tag.asHTML())
}

print("✅")

print("\n --- Reference cicle ---")
someWrongScope()

print("\n --- No Reference cicle ---")
someScope()
