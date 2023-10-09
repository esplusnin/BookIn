import Foundation

protocol RoomViewModelProtocol: AnyObject {
    var accomodationPublisher: Published<Accomodation?>.Publisher { get }
    func getAccomodationData()
}
