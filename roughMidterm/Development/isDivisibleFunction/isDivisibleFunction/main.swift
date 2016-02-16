//
//  main.swift
//  isDivisibleFunction
//
//  Created by Kerry Toonen on 2016-02-14.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

import Foundation

func isDivisibleBy(numberOne numberOne:Int , numberTwo:Int) ->Bool? {
    if (numberOne % numberTwo==0) {
        return true
    }
     return nil
}

if let result = isDivisibleBy(numberOne: 15, numberTwo: 3) {
    print("Divisible")
}

else {
    print("Not Divisible")
}

