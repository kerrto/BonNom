//: Playground - noun: a place where people can play

import UIKit

let cards = 1...13

for card in cards {
    
    switch card  {
        
    case 1,11...13:
        print("Trump cards")
    
        default:
            print(card)
        }
}
