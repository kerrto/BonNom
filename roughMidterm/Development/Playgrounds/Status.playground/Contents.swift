//Status

import UIKit

enum Status {
    case Success (String)
    case Failure (String)
}

let downloadStatus = Status.Failure("Network Connection Unavailable")

switch downloadStatus {
case.Success(let success):
    print(success)
case.Failure(let failure):
    print(failure)
}
