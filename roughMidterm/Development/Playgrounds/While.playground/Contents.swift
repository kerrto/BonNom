//: Playground - noun: a place where people can play

import UIKit

var todo : [String] = ["Return Calls","Write Blogpost","Cook Dinner","Pickup Laundry", "Buy Bulbs"]

var index = 0

while index < todo.count {
    print (todo[index])
    index++
}

repeat {
    print(todo[index])
    index++
    
} while index < todo.count