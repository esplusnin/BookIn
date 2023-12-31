import Foundation

protocol CoordinatorProtocol: AnyObject {
    func start()
    func goBack()
    func goToRoomViewController(with hotelName: String)
    func goToReservationViewController()
    func goToPaymentSuccesViewController()
    func goToRootViewController()
}
