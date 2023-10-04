import UIKit

enum Resources {
    enum Images {
        static let navigationBackButton = UIImage(systemName: "chevron.backward")?.withTintColor(
            .universalBlackPrimary,
            renderingMode: .alwaysOriginal) ?? UIImage()
        static let tableViewCellAccesoryType = UIImage(systemName: "chevron.forward")?.withTintColor(
            .universalBlackPrimary,
            renderingMode: .alwaysOriginal) ?? UIImage()
        
        static let ratingStar = UIImage(named: "Star") ?? UIImage()
        static let tableViewHappyImage = UIImage(named: "emoji-happy") ?? UIImage()
        static let tableViewTickImage = UIImage(named: "tick-square") ?? UIImage()
        static let tableViewCancelImage = UIImage(named: "close-square") ?? UIImage()
    }
    
    enum Identifiers {
        // Collections
        static let hotelCollectionViewCell = "HotelCollectionViewCell"
        static let hotelCollectionViewHeader = "HotelCollectionViewHeader"
        static let hotelCollectionViewFooter = "HotelCollectionViewFooter"
        
        // TableViews
        static let hotelTableViewCell = "HotelTableViewCell"
        static let roomTableViewCell = "RoomTableViewCell"
    }
    
    enum Network {
        static let hotelLink = "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3"
        static let aboutTheHotelLink = "https://run.mocky.io/v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd"
    }
}
