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
        let viewController = viewControllerFactory.getHotelViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
   
    func goToRoomViewController(with hotelName: String) {
        let viewController = viewControllerFactory.getRoomViewController(with: hotelName)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToReservationViewController() {
        let viewController = viewControllerFactory.getReservationViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
