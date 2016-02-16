//
//  main.swift
//  FizzBuzz
//
//  Created by Kerry Toonen on 2016-02-14.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

import Foundation

for var i = 0; i < 100; i++ {
    
    if i % 5 == 0 && i % 3 == 0 {
        print("FizzBuzz")
    }
        
    else if i % 3 == 0 {
        print("Fizz")
    }
        
    else if i % 5 == 0 {
        print("Buzz")
    }
        
    else {
        print(i)
    }
}

