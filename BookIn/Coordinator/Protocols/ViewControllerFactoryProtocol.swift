import Foundation

protocol ViewControllerFactoryProtocol: AnyObject {
    func getHotelViewController() -> HotelViewController
    func getRoomViewController(with hotelName: String) -> RoomViewController
    func getReservationViewController() -> ReservationViewController
    func getPaymentSuccesViewController() -> PaymentSuccesViewController
}
