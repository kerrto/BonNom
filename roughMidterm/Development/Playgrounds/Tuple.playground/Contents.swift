//Tuple

import UIKit

func searchNames (name name: String) -> (found : Bool , description : String) {
    let names =
    
    ["Amit","Andrew","Ben","Craig","Dave","Guil","Hampton","Jason","Joy","Kenneth","Nick","Pasan","Zac"]
    
    var found = (false, "\(name) is not a treehouse teacher")
    
    for n in names {
        
        if n==name {
            found = (true, "\(name) is a treehouse teacher)")
        }
        
    }
    
    return found
}

let (found,_) = searchNames(name: "John")

let result = searchNames(name: "Andrew")

result.found

result.description