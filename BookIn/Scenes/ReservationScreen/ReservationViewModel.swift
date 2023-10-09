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
        ExpandableTouristMenu(name: L10n.Numbers._1 + L10n.ReservationScreen.Customer.tourist, status: .unwrapped),
        ExpandableTouristMenu(name: L10n.Numbers._2 + L10n.ReservationScreen.Customer.tourist, status: .wrapped),
        ExpandableTouristMenu(name: L10n.ReservationScreen.Customer.addTourist, status: .created)
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
        let numberString = NumberTransferService().numberToAdjective(tourists.count)
        let indexToInsert = tourists.count - 1
        
        tourists.insert(ExpandableTouristMenu(name: numberString + L10n.ReservationScreen.Customer.tourist,
                                              status: .wrapped), at: indexToInsert)
    }
    
    func getCurrentTouristModel() -> [ExpandableTouristMenu] {
        tourists
    }
}
