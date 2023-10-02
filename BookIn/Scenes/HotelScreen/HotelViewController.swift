import UIKit

class HotelViewController: UIViewController {
    
    // MARK: - Constants and Variables:
    private let priceLabelsInset: CGFloat = 3
    
    // MARK: - UI:
    private lazy var mainHotelInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = UIConstants.mediumInset
        
        return stackView
    }()
    
    private lazy var hotelNameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .largeTitleFont
        label.textColor = .universalBlackPrimary
        
        return label
    }()
    
    private lazy var hotelLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .smallBodyFont
        button.titleLabel?.textColor = .universalBlue
        
        return button
    }()
    
    private lazy var priceLabel: UILabel = {
       let label = UILabel()
        label.font = .extraLargeBodyFont
        label.textColor = .universalBlackPrimary
        
        return label
    }()
    
    private lazy var priceDescriptionLabel: UILabel = {
       let label = UILabel()
        label.font = .mediumBodyFont
        label.textColor = .universalGray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var customNavigationBar = CustomNavigationBar(title: L10n.HotelScreen.title, isBackButton: false)
    private lazy var hotelBackgroundView = CustomBackgroundView(isRounded: false)
    private lazy var customPresenterScrollView = CustomPresenterScrollView()
    private lazy var customHotelRateView = CustomHotelRateView()
    
    // MARK: - Lifecycle:
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
        hotelNameLabel.text = "Лучший пятизвездочный отель в Хургаде, Египет"
        hotelLocationButton.setTitle("Madinat Makadi, Safaga Road, Makadi Bay, Египет", for: .normal)
        priceLabel.text = "от 134 268 ₽"
        priceDescriptionLabel.text = "За тур с перелётом"
    }
}

// MARK: - Setup Views:
private extension HotelViewController {
    func setupViews() {
        view.backgroundColor = .universalGray
        
        [customHotelRateView, hotelNameLabel, hotelLocationButton].forEach(mainHotelInfoStackView.addArrangedSubview)
        [customNavigationBar, hotelBackgroundView, customPresenterScrollView,
         mainHotelInfoStackView, priceLabel, priceDescriptionLabel].forEach(view.setupView)
        
        customNavigationBar.setupNavigationBar()
    }
    
    func setupConstraints() {
        setupHotelBackgroundViewConstraints()
        setupPhotosPresenterConstraints()
        setupMainHotelStackViewConstraints()
        setupPriceLabelConstraints()
        setupPriceDescriptionLabelConstraints()
    }
    
    func setupHotelBackgroundViewConstraints() {
        NSLayoutConstraint.activate([
            hotelBackgroundView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            hotelBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hotelBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hotelBackgroundView.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: UIConstants.sideInset)
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
    
    func setupMainHotelStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainHotelInfoStackView.topAnchor.constraint(equalTo: customPresenterScrollView.bottomAnchor, constant: UIConstants.sideInset),
            mainHotelInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
            mainHotelInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
    
    func setupPriceLabelConstraints() {
        priceLabel.topAnchor.constraint(equalTo: mainHotelInfoStackView.bottomAnchor, constant: UIConstants.sideInset).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset).isActive = true
    }
    
    func setupPriceDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            priceDescriptionLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: UIConstants.mediumInset),
            priceDescriptionLabel.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: -priceLabelsInset),
            priceDescriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
}
