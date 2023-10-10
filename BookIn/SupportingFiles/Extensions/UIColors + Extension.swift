import UIKit

extension UIColor {
    static let universalBlackPrimary = UIColor(named: "UniversalBlackPrimary") ?? .black
    static let universalBlue = UIColor(named: "UniversalBlue") ?? .blue
    static let universalLightBlue = UIColor(named: "UniversalBlue")?.withAlphaComponent(0.1) ?? .blue
    static let universalGray = UIColor(named: "UniversalGray") ?? .gray
    static let universalLightGray = UIColor(named: "UniversalLightGray") ?? .lightGray
    static let universalGrayBackground = UIColor(named: "UniversalGrayBackground") ?? .gray
    static let universalViewBackground = UIColor(named: "UniversalViewBackground") ?? .lightGray
    static let universalLightOrange = UIColor(named: "UniversalLightOrange") ?? .orange.withAlphaComponent(0.2)
    static let universalOrange = UIColor(named: "UniversalOrange") ?? .orange
    static let universalWhite = UIColor(named: "UniversalWhite") ?? .white
}
