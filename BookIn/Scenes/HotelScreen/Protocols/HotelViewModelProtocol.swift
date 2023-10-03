import UIKit

protocol HotelViewModelProtocol: AnyObject {
    var hotelModelPublisher: Published<Hotel?>.Publisher { get }
    var aboutTheHotel: AboutTheHotel? { get }
    var tableViewImages: [UIImage] { get }
    var descriptionText: String { get }
    var tableTitles: [String] { get }
    func fetchHotelModel()
}
