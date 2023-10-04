import Foundation

protocol ViewControllerFactoryProtocol: AnyObject {
    func getHotelViewController() -> HotelViewController
}
