import Foundation

final class NumberTransferService {
    func numberToAdjective(_ number: Int) -> String {
        let ones = [
            L10n.Numbers._1,
            L10n.Numbers._2,
            L10n.Numbers._3,
            L10n.Numbers._4,
            L10n.Numbers._5,
            L10n.Numbers._6,
            L10n.Numbers._7,
            L10n.Numbers._8,
            L10n.Numbers._9,
            L10n.Numbers._10
        ]
        
        if number <= 9 {
            return ones[number - 1]
        } else {
            return L10n.Numbers.x
        }
    }
}
