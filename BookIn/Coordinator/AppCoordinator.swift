import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    // MARK: - Dependencies:
    private let viewControllerFactory: ViewControllerFactoryProtocol
    private let navigationController: UINavigationController
    
    // MARK: - LifeCycle:
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllerFactoryProtocol) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    // MARK: - Public Methods:
    func start() {
        let hotelViewController = viewControllerFactory.getHotelViewController()
        navigationController.pushViewController(hotelViewController, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
   
    func goToRoomViewController(with hotelName: String) {
        let roomViewController = viewControllerFactory.getRoomViewController(with: hotelName)
        navigationController.pushViewController(roomViewController, animated: true)
    }
}
