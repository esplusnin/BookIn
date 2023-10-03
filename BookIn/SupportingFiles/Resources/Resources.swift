import UIKit

enum Resources {
    enum Images {
        static let navigationBackButton = UIImage(systemName: "chevron.backward")?.withTintColor(
            .universalBlackPrimary,
            renderingMode: .alwaysOriginal) ?? UIImage()
        static let ratingStar = UIImage(named: "Star") ?? UIImage()
        static let tableViewCellAccesoryType = UIImage(systemName: "chevron.forward")?.withTintColor(
            .universalBlackPrimary,
            renderingMode: .alwaysOriginal) ?? UIImage() 
    }
    
    enum Identifiers {
        // Collections
        static let hotelCollectionViewCell = "HotelCollectionViewCell"
        static let hotelCollectionViewHeader = "HotelCollectionViewHeader"
        static let hotelCollectionViewFooter = "HotelCollectionViewFooter"
        
        // TableViews
        static let hotelTableViewCell = "HotelTableViewCell"
    }
}
