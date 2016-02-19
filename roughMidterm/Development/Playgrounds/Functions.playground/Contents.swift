//Functions - named parameters

import UIKit

print("Swift functions")

func calculateArea(height height: Int, width: Int)->Int{

    return height * width
}


print("Area = \(calculateArea(height: 10, width: 12))")

calculateArea(height: 1000, width: 1200)
