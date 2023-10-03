import Combine
import Foundation

final class HotelViewModel: HotelViewModelProtocol {
    
    // MARK: - Dependencies:
    private let networkClient: NetworkClientProtocol
    
    // MARK: - Publishers:
    var hotelModelPublisher: Published<Hotel?>.Publisher {
        $hotelModel
    }
    
    @Published
    private var hotelModel: Hotel?
    
    // MARK: - Constants and Variables:
    private(set) var aboutTheHotel: AboutTheHotel?
    
    private(set) var descriptionText = L10n.HotelScreen.TableView.mostRequires
    private(set) var tableViewImages = [
        Resources.Images.tableViewHappyImage,
        Resources.Images.tableViewTickImage,
        Resources.Images.tableViewCancelImage
    ]
    private(set) var tableTitles = [
        L10n.HotelScreen.TableView.facilities,
        L10n.HotelScreen.TableView.includes,
        L10n.HotelScreen.TableView.notIncludes
    ]
    
    // MARK: - Lifecycle:
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    // MARK: Public Methods:
    func fetchHotelModel() {
        networkClient.fetchData(with: Resources.Network.hotelLink, model: Hotel.self) { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let model):
                self.hotelModel = model
                self.aboutTheHotel = model.aboutTheHotel
            case .failure(let error):
                print("error")
            }
        }
    }
}
