//Optionals

import UIKit

func sendNoticeTo(aptNumber aptNumber: Int) {
    
}

func findApt (aptNumber : Int ) ->Int? {
    
    let aptNumbers = [101,202,303,404]
    
    for tempAptNumber in aptNumbers {
        if (tempAptNumber == aptNumber) {
            return aptNumber
        }
    }
    return nil
}

if let culprit = findApt(404) {
    sendNoticeTo(aptNumber: aptNumber)
}