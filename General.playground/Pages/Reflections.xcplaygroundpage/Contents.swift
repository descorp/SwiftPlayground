//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

public protocol OpenAirDTO: class {
    static var datatype: String { get }
}

public extension OpenAirDTO {
    static var datatype: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension Array where Element == String {
    
    var xml: String {
        return self.reduce("\r") { (current, next) in
            return current + next + "\r"
        }
    }
}

func unwrap<T>(_ any: T) -> Any {
    let mirror = Mirror(reflecting: any)
    guard mirror.displayStyle == .optional, let first = mirror.children.first else {
        return any
    }
    return unwrap(first.value)
}

class Book: OpenAirDTO {
    let title: String
    let author: String?
    let published: Date
    let numberOfPages: Int
    let chapterCount: Int?
    let genres: [String]
    let stuff: String? = nil
    
    init(title: String, author: String?, published: Date, numberOfPages: Int, chapterCount: Int?, genres: [String]) {
        self.title = title
        self.author = author
        self.published = published
        self.numberOfPages = numberOfPages
        self.chapterCount = chapterCount
        self.genres = genres
    }
    
    var xml: String {
        let keys = Mirror(reflecting: self).children.flatMap { $0.label }
        let values = Mirror(reflecting: self).children.flatMap { unwrap($0.value) as! AnyObject }
        
        var dict = Dictionary(uniqueKeysWithValues: zip(keys, values))
        
        var keysToRemove = dict.keys.filter{ dict[$0] is NSNull }
        for key in keysToRemove {
            dict.removeValue(forKey: key)
        }
        
        var parameters: [String] = []
        let typename = type(of: self).datatype
        
        for (name, value) in dict {
            parameters.append("<\(name)>\(value)<\\\(name)>")
        }
        
        return "<\(typename)>\(parameters.xml)<\\\(typename)>"
    }
}

class SomeClass {
    var A: String
    var B: Int
    var C: Book
    
    init(a: String, b: Int, c: Book) {
        A = a
        B = b
        C = c
    }
}

let book = Book(title: "Harry Potter", author: "J.K. Rowling", published: Date(), numberOfPages: 450, chapterCount: 19, genres: ["Fantasy", "Best books ever"])
print(book.xml)

print("✅")
