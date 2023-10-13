import Foundation

protocol RoomViewModelProtocol: AnyObject {
    var accomodationPublisher: Published<Accomodation?>.Publisher { get }
    var errorStringPublisher: Published<String?>.Publisher { get }
    func getAccomodationData()
}
