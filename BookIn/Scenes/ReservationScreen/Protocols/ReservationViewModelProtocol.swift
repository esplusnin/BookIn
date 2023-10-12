import Foundation

protocol ReservationViewModelProtocol: AnyObject {
    var tripPublisher: Published<Trip?>.Publisher { get }
    var touristsPublisher: Published<[ExpandableTouristMenu]>.Publisher { get }
    var isReadyToPayPublisher: Published<Bool>.Publisher { get }
    func fetchTripData()
    func changeTouristHeaderViewStatus(from section: Int, to status: ExpandableMenuStatus)
    func appendNewHeaderView()
    func getCurrentTouristMenu() -> [ExpandableTouristMenu]
    func setCustomerPhoneNumber(with numberString: String?)
    func setCustomerEmail(with emailString: String?)
    func setTouristInformation(with model: Tourist?)
    func isTouristInfoCompleted()
}
