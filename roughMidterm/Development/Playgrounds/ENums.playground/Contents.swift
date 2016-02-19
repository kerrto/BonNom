//DaysInWeek

import UIKit

enum Day: Int {
    case Monday = 1,Tuesday = 2,Wednesday = 3,Thursday = 4,Friday = 5,Saturday = 6,Sunday = 7
    
    init() {
        self = .Sunday
    }
    
    
    func daysTillWeekend() -> Int {
        return Day.Saturday.rawValue - self.rawValue

}

func dayString()->String {
    switch self {
    case .Monday:
        return "Monday"
        
    default:
        return "Other Day"
    }
}
}

var today = Day()

today.rawValue
today.dayString()




