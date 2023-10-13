import UIKit

enum Resources {
    enum Images {
        static let navigationBackButton = UIImage(systemName: "chevron.backward")?.withTintColor(
            .universalBlackPrimary,
            renderingMode: .alwaysOriginal) ?? UIImage()
        static let tableViewCellAccesoryType = UIImage(systemName: "chevron.forward") ?? UIImage()
        
        static let ratingStar = UIImage(named: "Star") ?? UIImage()
        static let tableViewHappyImage = UIImage(named: "emoji-happy") ?? UIImage()
        static let tableViewTickImage = UIImage(named: "tick-square") ?? UIImage()
        static let tableViewCancelImage = UIImage(named: "close-square") ?? UIImage()
        static let wrongURL = UIImage(named: "WrongURL") ?? UIImage()
        static let notificationBannerImage = UIImage(systemName: "antenna.radiowaves.left.and.right.slash")
        
        static let wrappedHeaderViewImage = UIImage(systemName: "chevron.down")?.withTintColor(
            .universalBlue,
            renderingMode: .alwaysOriginal) ?? UIImage()
        static let unwrappedHeaderViewImage = UIImage(systemName: "chevron.up")?.withTintColor(
            .universalBlue,
            renderingMode: .alwaysOriginal) ?? UIImage()
        static let createdHeaderViewImage = UIImage(systemName: "plus")?.withTintColor(
            .universalWhite,
            renderingMode: .alwaysOriginal) ?? UIImage()
    }
    
    enum Identifiers {
        // Collections
        static let hotelCollectionViewCell = "HotelCollectionViewCell"
        static let roomCollectionViewCell = "RoomCollectionViewCell"
        
        static let hotelCollectionViewHeader = "HotelCollectionViewHeader"
        static let roomCollectionViewHeader = "RoomCollectionViewHeader"
        static let hotelCollectionViewFooter = "HotelCollectionViewFooter"
        
        // TableViews
        static let hotelTableViewCell = "HotelTableViewCell"
        static let roomTableViewCell = "RoomTableViewCell"
        static let reservationTableView = "ReservationTableView"
        static let touristsTableViewCell = "TouristsTableViewCell"
    }
    
    enum Network {
        static let hotelLink = "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3"
        static let roomsLink = "https://run.mocky.io/v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd"
        static let tripLink = "https://run.mocky.io/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8"
    }
}
