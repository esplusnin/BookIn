import Combine
import Foundation

final class ReservationViewModel: ReservationViewModelProtocol {
    
    // MARK: - Dependencies:
    private let networkClient: NetworkClientProtocol?
    
    // MARK: - Constants and Variables:
    private var touristInformation: TouristInformation? {
        didSet {
            isTouristInfoCompleted()
        }
    }
    
    // MARK: - Publishers:
    var tripPublisher: Published<Trip?>.Publisher {
        $trip
    }
    
    var touristsPublisher: Published<[ExpandableTouristMenu]>.Publisher {
        $touristsMenu
    }
    
    var isReadyToPayPublisher: Published<Bool?>.Publisher {
        $isReadyToPay
    }
    
    var errorStringPublisher: Published<String?>.Publisher {
        $errorString
    }
    
    @Published
    private var trip: Trip?
    
    @Published
    private var touristsMenu: [ExpandableTouristMenu] = [
        ExpandableTouristMenu(name: L10n.Numbers._1 + L10n.ReservationScreen.Customer.tourist, status: .unwrapped),
        ExpandableTouristMenu(name: L10n.Numbers._2 + L10n.ReservationScreen.Customer.tourist, status: .wrapped),
        ExpandableTouristMenu(name: L10n.ReservationScreen.Customer.addTourist, status: .created)
    ]
    
    @Published
    private var isReadyToPay: Bool?
    
    @Published
    private var errorString: String?
    
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
                let errorString = HandlingErrorService().handlingHTTPStatusCodeError(error: error)
                self.errorString = errorString
            }
        }
    }
    
    // Header views:
    func changeTouristHeaderViewStatus(from section: Int, to status: ExpandableMenuStatus) {
        touristsMenu[section].changeStatus(to: status)
    }
    
    func appendNewHeaderView() {
        let numberString = NumberTransferService().numberToAdjective(touristsMenu.count)
        let indexToInsert = touristsMenu.count - 1
        
        touristsMenu.insert(ExpandableTouristMenu(name: numberString + L10n.ReservationScreen.Customer.tourist,
                                                  status: .wrapped), at: indexToInsert)
    }
    
    func getCurrentTouristMenu() -> [ExpandableTouristMenu] {
        touristsMenu
    }
    
    // CRUD Tourist information:
    func setCustomerPhoneNumber(with numberString: String?) {
        let newTouristInformation = TouristInformation(customerPhoneNumber: numberString,
                                                       customerEmail: touristInformation?.customerEmail,
                                                       tourists: touristInformation?.tourists)
        touristInformation = newTouristInformation
    }
    
    func setCustomerEmail(with emailString: String?) {
        let newTouristInformation = TouristInformation(customerPhoneNumber: touristInformation?.customerPhoneNumber,
                                                       customerEmail: emailString,
                                                       tourists: touristInformation?.tourists)
        touristInformation = newTouristInformation
    }
    
    func setTouristInformation(with model: Tourist?) {
        if model == nil {
            touristInformation = TouristInformation(customerPhoneNumber: touristInformation?.customerPhoneNumber,
                                                    customerEmail: touristInformation?.customerEmail,
                                                    tourists: nil)
        } else if let tourist = touristInformation?.tourists,
                  let model {
            var newTourists = tourist
            newTourists.append(model)
            
            touristInformation = TouristInformation(customerPhoneNumber: touristInformation?.customerPhoneNumber,
                                                    customerEmail: touristInformation?.customerEmail,
                                                    tourists: newTourists)
        } else if let model {
            touristInformation = TouristInformation(customerPhoneNumber: touristInformation?.customerPhoneNumber,
                                                    customerEmail: touristInformation?.customerEmail,
                                                    tourists: [model])
        }
    }
    
    // MARK: - Private Methods:
    private func isTouristInfoCompleted() {
        if touristInformation?.customerPhoneNumber != nil &&
            touristInformation?.customerEmail != nil &&
            touristInformation?.tourists != nil {
            isReadyToPay = true
        } else {
            isReadyToPay = false
        }
    }
}
