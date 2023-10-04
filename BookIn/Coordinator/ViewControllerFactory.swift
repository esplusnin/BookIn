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
        return HotelViewController(viewModel: viewModel)
    }
}
