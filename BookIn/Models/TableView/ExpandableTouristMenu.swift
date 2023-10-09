import UIKit

enum ExpandableMenuStatus {
    case wrapped
    case unwrapped
    case created
}

struct ExpandableTouristMenu {
    var name: String
    var status: ExpandableMenuStatus
    
    mutating func changeStatus(to status: ExpandableMenuStatus) {
        self.status = status
    }
}
