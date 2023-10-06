import Foundation

final class ViewControllerFactory: ViewControllerFactoryProtocol {
    
    // MARK: - Dependencies
    weak var coordinator: CoordinatorProtocol?
    private var networkClient: NetworkClientProtocol
    
    // MARK: - Lifecycle
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func getHotelViewController() -> HotelViewController {
        let viewModel = HotelViewModel(networkClient: networkClient)
        return HotelViewController(coordinator: coordinator, viewModel: viewModel)
    }
    
    func getRoomViewController(with hotelName: String) -> RoomViewController {
        let viewModel = RoomViewModel(networkClient: networkClient)
        return RoomViewController(coordinator: coordinator,viewModel: viewModel, hotelName: hotelName)
    }
    
    func getReservationViewController() -> ReservationViewController {
        ReservationViewController(coordinator: coordinator)
    }
}
