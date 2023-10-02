import UIKit

class HotelViewController: UIViewController {
    
    // MARK: - UI:
    private lazy var customNavigationBar = CustomNavigationBar(title: L10n.HotelScreen.title, isBackButton: false)
    private lazy var hotelBackgroundView = CustomBackgroundView(isRounded: false)
    private lazy var customPresenterScrollView = CustomPresenterScrollView()
    private lazy var customHotelRateView = CustomHotelRateView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        customPresenterScrollView.setupImagesURLs(with: [
            "https://www.atorus.ru/sites/default/files/upload/image/News/56149/Club_Priv%C3%A9_by_Belek_Club_House.jpg",
            "https://deluxe.voyage/useruploads/articles/The_Makadi_Spa_Hotel_02.jpg",
            "https://deluxe.voyage/useruploads/articles/article_1eb0a64d00.jpg"
        ])
        
        customHotelRateView.setupRatingInfo(with: 5, description: "Превосходно")
    }
}

// MARK: - Setup Views:
private extension HotelViewController {
    func setupViews() {
        view.backgroundColor = .universalGray
        
        [customNavigationBar, hotelBackgroundView, customPresenterScrollView].forEach(view.setupView)
        
        customNavigationBar.setupNavigationBar()
    }
    
    func setupConstraints() {
        setupHotelBackgroundViewConstraints()
        setupPhotosPresenterConstraints()
    }
    
    func setupHotelBackgroundViewConstraints() {
        NSLayoutConstraint.activate([
            hotelBackgroundView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            hotelBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hotelBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupPhotosPresenterConstraints() {
        NSLayoutConstraint.activate([
            customPresenterScrollView.heightAnchor.constraint(equalToConstant: UIConstants.viewHeight),
            customPresenterScrollView.topAnchor.constraint(equalTo: hotelBackgroundView.topAnchor),
            customPresenterScrollView.leadingAnchor.constraint(equalTo: hotelBackgroundView.leadingAnchor),
            customPresenterScrollView.trailingAnchor.constraint(equalTo: hotelBackgroundView.trailingAnchor)
        ])
    }
}
