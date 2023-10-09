import Foundation

final class CurrencyFormatterService {
    // MARK: - Classes:
    private let numberFormatter = NumberFormatter()

    // MARK: - Public Methods:
    func getCurrencyString(from value: Int) -> String {
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "ru_RU")
        numberFormatter.maximumFractionDigits = 0
        
        return numberFormatter.string(from: NSNumber(value: value)) ?? ""
    }
}
