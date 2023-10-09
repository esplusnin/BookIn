import Foundation

protocol ReservationViewModelProtocol: AnyObject {
    var tripPublisher: Published<Trip?>.Publisher { get }
    var touristsPublisher: Published<[ExpandableTouristMenu]>.Publisher { get }
    func fetchTripData()
    func changeTouristHeaderViewStatus(from section: Int, to status: ExpandableMenuStatus)
    func appendNewHeaderView()
    func getCurrentTouristModel() -> [ExpandableTouristMenu]
}
