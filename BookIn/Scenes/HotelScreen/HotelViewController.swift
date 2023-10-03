import UIKit

class HotelViewController: UIViewController {
    
    // MARK: - Classes:
    private let hotelCollectionViewProvider = HotelCollectionViewProvider()
    private let hotelTableViewProvider = HotelTableViewProvider()
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let priceLabelsInset: CGFloat = 3
        static let collectionHeight: CGFloat = 250
        static let tableHeight: CGFloat = 180
        static let buttonBackgroundViewTopInset: CGFloat = 12
        static let buttonBackgroundViewHeight: CGFloat = 500
        static let buttonBackgroundViewOutInset: CGFloat = 88
        static let chooseButtonHeight: CGFloat = 48
    }
    
    // MARK: - UI:
    private lazy var mainScreenScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.refreshControl = refreshControl
        
        return scrollView
    }()
    
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
    
    private lazy var hotelDescriptionCollectionView: UICollectionView = {
        let layout = CustomSelfSizeCollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    private lazy var hotelTableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.register(HotelTableViewCell.self, forCellReuseIdentifier: Resources.Identifiers.hotelTableViewCell)
        tableView.dataSource = hotelTableViewProvider
        tableView.delegate = hotelTableViewProvider
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: UIConstants.sideInset, bottom: 0, right: UIConstants.sideInset)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        tableView.backgroundColor = .universalLightGray
        tableView.layer.cornerRadius = UIConstants.largeCornerRadius
        
        return tableView
    }()
    
    private lazy var customNavigationBar = CustomNavigationBar(title: L10n.HotelScreen.title, isBackButton: false)
    private lazy var hotelBackgroundView = CustomBackgroundView(isRounded: true)
    private lazy var hotelDescriptionBackgroundView = CustomBackgroundView(isRounded: true)
    private lazy var buttonBackgroundView = CustomBackgroundView(isRounded: false)
    private lazy var customPresenterScrollView = CustomPresenterScrollView()
    private lazy var customHotelRateView = CustomHotelRateView()
    private lazy var chooseRoomButton = CustomBaseButton(with: L10n.HotelScreen.chooseRoomButton)
    private lazy var refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupCollectionView()
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
    
    // MARK: - Private Methods:
    private func setupCollectionView() {
        hotelDescriptionCollectionView.register(HotelCollectionViewCell.self,
                                                forCellWithReuseIdentifier: Resources.Identifiers.hotelCollectionViewCell)
        hotelDescriptionCollectionView.register(HotelCollectionViewReusableView.self,
                                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                                withReuseIdentifier: Resources.Identifiers.hotelCollectionViewHeader)
        hotelDescriptionCollectionView.register(HotelCollectionViewReusableView.self,
                                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                                withReuseIdentifier: Resources.Identifiers.hotelCollectionViewFooter)
        
        hotelDescriptionCollectionView.dataSource = hotelCollectionViewProvider
        hotelDescriptionCollectionView.delegate = hotelCollectionViewProvider
    }
    
    // MARK: - Objc Methods:
    @objc private func updateHotelInfo() {

    }
}

// MARK: - Setup Views:
private extension HotelViewController {
    func setupViews() {
        view.backgroundColor = .universalLightGray
        
        [customNavigationBar, mainScreenScrollView].forEach(view.setupView)
        [customHotelRateView, hotelNameLabel, hotelLocationButton].forEach(mainHotelInfoStackView.addArrangedSubview)
        [hotelBackgroundView, customPresenterScrollView,mainHotelInfoStackView, priceLabel, priceDescriptionLabel,
         hotelDescriptionBackgroundView, hotelDescriptionCollectionView, hotelTableView,
         buttonBackgroundView, chooseRoomButton].forEach(mainScreenScrollView.setupView)
        
        customNavigationBar.setupNavigationBar()
    }
    
    func setupConstraints() {
        setupMainScreenScrollView()
        setupHotelBackgroundViewConstraints()
        setupPhotosPresenterConstraints()
        setupMainHotelStackViewConstraints()
        setupPriceLabelConstraints()
        setupPriceDescriptionLabelConstraints()
        setupHotelDescriptionViewConstraints()
        setupHotelCollectionViewConstraints()
        setupHotelTableViewConstraints()
        setupButtonBackgroundViewConstraints()
        setupChooseRoomButtonConstraints()
    }
    
    func setupMainScreenScrollView() {
        NSLayoutConstraint.activate([
            mainScreenScrollView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            mainScreenScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScreenScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainScreenScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupHotelBackgroundViewConstraints() {
        NSLayoutConstraint.activate([
            hotelBackgroundView.topAnchor.constraint(equalTo: mainScreenScrollView.topAnchor, constant: -UIConstants.sideInset),
            hotelBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hotelBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hotelBackgroundView.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: UIConstants.sideInset)
        ])
    }
    
    func setupPhotosPresenterConstraints() {
        NSLayoutConstraint.activate([
            customPresenterScrollView.heightAnchor.constraint(equalToConstant: UIConstants.viewHeight),
            customPresenterScrollView.topAnchor.constraint(equalTo: hotelBackgroundView.topAnchor, constant: UIConstants.sideInset),
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
            priceDescriptionLabel.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: -LocalUIConstants.priceLabelsInset),
            priceDescriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
    
    func setupHotelDescriptionViewConstraints() {
        NSLayoutConstraint.activate([
            hotelDescriptionBackgroundView.topAnchor.constraint(equalTo: hotelBackgroundView.bottomAnchor, constant: UIConstants.mediumInset),
            hotelDescriptionBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hotelDescriptionBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hotelDescriptionBackgroundView.bottomAnchor.constraint(equalTo: hotelTableView.bottomAnchor, constant: UIConstants.sideInset)
        ])
    }
    
    func setupHotelCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            hotelDescriptionCollectionView.heightAnchor.constraint(equalToConstant: LocalUIConstants.collectionHeight),
            hotelDescriptionCollectionView.topAnchor.constraint(equalTo: hotelDescriptionBackgroundView.topAnchor, constant: UIConstants.sideInset),
            hotelDescriptionCollectionView.leadingAnchor.constraint(equalTo: hotelDescriptionBackgroundView.leadingAnchor),
            hotelDescriptionCollectionView.trailingAnchor.constraint(equalTo: hotelDescriptionBackgroundView.trailingAnchor)
        ])
    }
    
    func setupHotelTableViewConstraints() {
        NSLayoutConstraint.activate([
            hotelTableView.heightAnchor.constraint(equalToConstant: LocalUIConstants.tableHeight),
            hotelTableView.topAnchor.constraint(equalTo: hotelDescriptionCollectionView.bottomAnchor, constant: UIConstants.sideInset),
            hotelTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
            hotelTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset),
            hotelTableView.bottomAnchor.constraint(equalTo: mainScreenScrollView.bottomAnchor, constant: -LocalUIConstants.buttonBackgroundViewOutInset)
        ])
    }
    
    func setupButtonBackgroundViewConstraints() {
        NSLayoutConstraint.activate([
            buttonBackgroundView.heightAnchor.constraint(equalToConstant: LocalUIConstants.buttonBackgroundViewHeight),
            buttonBackgroundView.topAnchor.constraint(equalTo: hotelDescriptionBackgroundView.bottomAnchor,
                                                      constant: LocalUIConstants.buttonBackgroundViewTopInset),
            buttonBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupChooseRoomButtonConstraints() {
        NSLayoutConstraint.activate([
            chooseRoomButton.heightAnchor.constraint(equalToConstant: LocalUIConstants.chooseButtonHeight),
            chooseRoomButton.topAnchor.constraint(equalTo: buttonBackgroundView.topAnchor, constant: LocalUIConstants.buttonBackgroundViewTopInset),
            chooseRoomButton.leadingAnchor.constraint(equalTo: buttonBackgroundView.leadingAnchor, constant: UIConstants.sideInset),
            chooseRoomButton.trailingAnchor.constraint(equalTo: buttonBackgroundView.trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
}

// MARK: - Setup Targets:
extension HotelViewController {
    private func setupTargets() {
        refreshControl.addTarget(self, action: #selector(updateHotelInfo), for: .valueChanged)
    }
}