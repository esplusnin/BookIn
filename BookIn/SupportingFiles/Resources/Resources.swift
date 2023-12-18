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
        static let hotelLink = "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473"
        static let roomsLink = "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195"
        static let tripLink = "https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff"
    }
}
