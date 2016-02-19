//Comparison

import UIKit

1 == 1

2 != 1

2 > 1

1 < 2

1 >= 1

2 <= 1


var distance = 120

if distance < 5 {
    
    print ("\(distance) miles is near")
}
    
else if distance >= 5 && distance <= 20 {
    print("\(distance) miles is close")
}


else {
    
    print("\(distance) miles is far")
}


// && is the AND operator

//|| is the OR operator

//! is the NOT operator

if distance < 5 || distance < 20 {
    
    print ("OR")
}