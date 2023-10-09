import Combine
import Foundation

final class ReservationViewModel: ReservationViewModelProtocol {
    
    // MARK: - Dependencies:
    private let networkClient: NetworkClientProtocol?
    
    // MARK: - Publishers:
    var tripPublisher: Published<Trip?>.Publisher {
        $trip
    }
    
    var touristsPublisher: Published<[ExpandableTouristMenu]>.Publisher {
        $tourists
    }
    
    @Published
    private(set) var trip: Trip?
    
    @Published
    private(set) var tourists: [ExpandableTouristMenu] = [
        ExpandableTouristMenu(name: "Первый турист", status: .unwrapped),
        ExpandableTouristMenu(name: "Второй турист", status: .wrapped),
        ExpandableTouristMenu(name: "Добавить туриста", status: .created)
    ]
    
    // MARK: - Lifecycle:
    init(networkClient: NetworkClientProtocol?) {
        self.networkClient = networkClient
    }
    
    // MARK: - Public Methods:
    func fetchTripData() {
        networkClient?.fetchData(with: Resources.Network.tripLink,
                                 model: Trip.self) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let trip):
                self.trip = trip
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func changeTouristHeaderViewStatus(from section: Int, to status: ExpandableMenuStatus) {
        tourists[section].changeStatus(to: status)
    }
    
    func appendNewHeaderView() {
        tourists.append(ExpandableTouristMenu(name: "Добавить туриста", status: .created))
    }
    
    func getCurrentTouristModel() -> [ExpandableTouristMenu] {
        tourists
    }
}
