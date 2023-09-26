import UIKit

class HotelViewController: UIViewController {
    
    // MARK: - UI:
    private lazy var customNavigationBar = CustomNavigationBar(title: L10n.HotelScreen.title, isBackButton: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupViews()
    }
}

// MARK: - Setup Views:
private extension HotelViewController {
    func setupViews() {
        view.setupView(customNavigationBar)
        
        customNavigationBar.setupNavigationBar()
    }
}
