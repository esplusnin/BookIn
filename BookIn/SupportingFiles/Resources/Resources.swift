import UIKit

enum Resources {
    enum Images {
        static let navigationBackButton = UIImage(systemName: "chevron.backward")?.withTintColor(
            .universalBlackPrimary,
            renderingMode: .alwaysOriginal)
        static let ratingStar = UIImage(named: "Star")
    }
    
    enum Identifiers {
        static let hotelCollectionViewCell = "HotelCollectionViewCell"
        static let hotelCollectionViewHeader = "HotelCollectionViewHeader"
        static let hotelCollectionViewFooter = "HotelCollectionViewFooter"
    }
}
