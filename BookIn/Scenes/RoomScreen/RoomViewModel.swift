import Combine
import Foundation

final class RoomViewModel: RoomViewModelProtocol {
    
    // MARK: - Dependencies:
    private let networkClient: NetworkClientProtocol
    
    // MARK: - Publishers:
    var accomodationPublisher: Published<Accomodation?>.Publisher {
        $accomodation
    }
    
    @Published
    private(set) var accomodation: Accomodation?
    
    // MARK: - Lifecycle:
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    // MARK: - Public Methods:
    func getAccomodationModel() {
        networkClient.fetchData(with: Resources.Network.roomsLink,
                                model: Accomodation.self) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let accomodation):
                self.accomodation = accomodation
            case .failure(let error):
                print("error")
            }
        }
    }
}
