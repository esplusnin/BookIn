import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: CoordinatorProtocol?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let navigationController = UINavigationController()
        let networkClient = NetworkClient()
        let viewControllerFactory = ViewControllerFactory(networkClient: networkClient)
        
        coordinator = AppCoordinator(navigationController: navigationController, viewControllerFactory: viewControllerFactory)
        viewControllerFactory.coordinator = coordinator
       
        coordinator?.start()

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()        
    }
}
