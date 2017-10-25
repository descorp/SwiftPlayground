//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


let myCompany = [
    "employees": [
        "employee 1": ["attribute": "value"],
        "employee 2": ["attribute": "value"],
        "employee 3": ["attribute": "value"],
        "employee 4": ["attribute": "value"],
        "employee 5": ["attribute": "value"],
        "employee 6": ["attribute": "value"],
        "employee 7": ["attribute": "value"],
        "employee 8": ["attribute": "value"],
        "employee 9": ["attribute": "value"],
        "employee 10": ["attribute": "value"],
        "employee 11": ["attribute": "value"],
        "employee 12": ["attribute": "value"],
        "employee 13": ["attribute": "value"],
        "employee 14": ["attribute": "value"],
        "employee 15": ["attribute": "value"],
        "employee 16": ["attribute": "value"],
        "employee 17": ["attribute": "value"],
        "employee 18": ["attribute": "value"],
        "employee 19": ["attribute": "value19"],
        "employee 20": ["attribute": "value"],
    ]
]

print("✅")
print(myCompany)
let n = myCompany["employees"]?["employee 19"]?["attribute"] ?? "Neh"
