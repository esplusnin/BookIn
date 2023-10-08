import UIKit

final class ReservationViewController: UIViewController {
    
    // MARK: - Dependencies:
    private let coordinator: CoordinatorProtocol?
    
    // MARK: - Constants and Variables:
    private let aboutCustomerInset: CGFloat = 20
    
    // MARK: - UI:
    private lazy var mainScreenScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private lazy var hotelInfoStackView: UIStackView = {
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
    
    private lazy var tripInfoStackView: CustomTripInfoStackView = {
       let stackView = CustomTripInfoStackView()
        stackView.axis = .vertical
        stackView.spacing = UIConstants.sideInset
        
        return stackView
    }()
    
    private lazy var aboutCustomerLabel: UILabel = {
       let label = UILabel()
        label.font = .largeTitleFont
        label.textColor = .universalBlackPrimary
        label.text = L10n.ReservationScreen.customerInfo
        
        return label
    }()
    
    private lazy var privacyLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .smallBodyFont
        label.textColor = .universalGray
        label.text = L10n.ReservationScreen.Customer.privacy
        
        return label
    }()
    
    private lazy var aboutCustomerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = UIConstants.mediumInset
        
        return stackView
    }()
    
    private lazy var customNavigationBar = CustomNavigationBar(coordinator: coordinator, title: L10n.ReservationScreen.reservation, isBackButton: true)
    private lazy var hotelInfoBackgroundView = CustomBackgroundView(isRounded: true)
    private lazy var tripInfoBackgroundView = CustomBackgroundView(isRounded: true)
    private lazy var customerInfoBackgroundView = CustomBackgroundView(isRounded: true)
    private lazy var customHotelRateView = CustomHotelRateView()
    private lazy var customerPhoneNumberView = CustomInputFormView(state: .number, with: L10n.ReservationScreen.Customer.phoneNumber)
    private lazy var customerEmailView = CustomInputFormView(state: .email, with: L10n.ReservationScreen.Customer.email)
    
    // MARK: - Lifecycle:
    init(coordinator: CoordinatorProtocol?) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customHotelRateView.setupRatingInfo(with: 5, description: "Превосходно")
        hotelNameLabel.text = "Лучший пятизвездочный отель в Хургаде, Египет"
        hotelLocationButton.setTitle("Madinat Makadi, Safaga Road, Makadi Bay, Египет", for: .normal)
        
        tripInfoStackView.setupTrip(with: Trip(id: 1,
                                               hotelName: "Лучший пятизвездочный отель в Хургаде, Египет",
                                               hotelAdress: "Madinat Makadi, Safaga Road, Makadi Bay, Египет",
                                               horating: 1,
                                               ratingName: "5",
                                               departure: "Россия, Москва",
                                               arrivalCountry: "Египет",
                                               tourDateStart: "19.02.2023",
                                               tourDateStop: "25.02.2023",
                                               numberOfNights: 6, room: "Luxe title",
                                               nutrition: "Все включено",
                                               tourPrice: 123123112,
                                               fuelCharge: 12311,
                                               serviceCharge: 123))
    }
}

// MARK: - SetupViews:
private extension ReservationViewController {
    func setupViews() {
        view.backgroundColor = .univarsalViewBackground
        
        [customHotelRateView, hotelNameLabel, hotelLocationButton].forEach(hotelInfoStackView.addArrangedSubview)
        [customerPhoneNumberView, customerEmailView, privacyLabel].forEach(aboutCustomerStackView.addArrangedSubview)
        
        [customNavigationBar, mainScreenScrollView].forEach(view.setupView)
        [hotelInfoBackgroundView, hotelInfoStackView, tripInfoBackgroundView,
         tripInfoStackView, customerInfoBackgroundView, aboutCustomerLabel, aboutCustomerStackView].forEach(mainScreenScrollView.setupView)
        
        customNavigationBar.setupNavigationBar()
    }
    
    func setupConstraints() {
        setupMainScreenScrollView()
        setupHotelInfoBackgroundView()
        setupHotelInfoStackView()
        setupTripInfoBackgroundInfo()
        setupTripInfoStackView()
        setupCustomerInfoBackgroundView()
        setupAboutCustomerLabelConstraints()
        setupAboutCustomerStackViewConstraints()
    }
    
    func setupMainScreenScrollView() {
        NSLayoutConstraint.activate([
            mainScreenScrollView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            mainScreenScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScreenScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainScreenScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupHotelInfoBackgroundView() {
        NSLayoutConstraint.activate([
            hotelInfoBackgroundView.topAnchor.constraint(equalTo: mainScreenScrollView.topAnchor, constant: UIConstants.mediumInset),
            hotelInfoBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hotelInfoBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hotelInfoBackgroundView.bottomAnchor.constraint(equalTo: hotelInfoStackView.bottomAnchor, constant: UIConstants.sideInset)
        ])
    }
    
    func setupHotelInfoStackView() {
        NSLayoutConstraint.activate([
            hotelInfoStackView.topAnchor.constraint(equalTo: hotelInfoBackgroundView.topAnchor, constant: UIConstants.sideInset),
            hotelInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
            hotelInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
    
    func setupTripInfoBackgroundInfo() {
        NSLayoutConstraint.activate([
            tripInfoBackgroundView.topAnchor.constraint(equalTo: hotelInfoBackgroundView.bottomAnchor, constant: UIConstants.mediumInset),
            tripInfoBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tripInfoBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tripInfoBackgroundView.bottomAnchor.constraint(equalTo: tripInfoStackView.bottomAnchor, constant: UIConstants.sideInset)
        ])
    }
    
    func setupTripInfoStackView() {
        NSLayoutConstraint.activate([
            tripInfoStackView.topAnchor.constraint(equalTo: tripInfoBackgroundView.topAnchor, constant: UIConstants.sideInset),
            tripInfoStackView.leadingAnchor.constraint(equalTo: tripInfoBackgroundView.leadingAnchor, constant: UIConstants.sideInset),
            tripInfoStackView.trailingAnchor.constraint(equalTo: tripInfoBackgroundView.trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
    
    func setupCustomerInfoBackgroundView() {
        NSLayoutConstraint.activate([
            customerInfoBackgroundView.topAnchor.constraint(equalTo: tripInfoBackgroundView.bottomAnchor, constant: UIConstants.mediumInset),
            customerInfoBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customerInfoBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customerInfoBackgroundView.bottomAnchor.constraint(equalTo: aboutCustomerStackView.bottomAnchor, constant: -UIConstants.sideInset)
        ])
    }
    
    func setupAboutCustomerLabelConstraints() {
        NSLayoutConstraint.activate([
            aboutCustomerLabel.topAnchor.constraint(equalTo: customerInfoBackgroundView.topAnchor, constant: UIConstants.sideInset),
            aboutCustomerLabel.leadingAnchor.constraint(equalTo: customerInfoBackgroundView.leadingAnchor, constant: UIConstants.sideInset),
            aboutCustomerLabel.trailingAnchor.constraint(equalTo: customerInfoBackgroundView.trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
    
    func setupAboutCustomerStackViewConstraints() {
        NSLayoutConstraint.activate([
            aboutCustomerStackView.topAnchor.constraint(equalTo: aboutCustomerLabel.bottomAnchor, constant: aboutCustomerInset),
            aboutCustomerStackView.leadingAnchor.constraint(equalTo: customerInfoBackgroundView.leadingAnchor, constant: UIConstants.sideInset),
            aboutCustomerStackView.bottomAnchor.constraint(equalTo: mainScreenScrollView.bottomAnchor, constant: -UIConstants.sideInset),
            aboutCustomerStackView.trailingAnchor.constraint(equalTo: customerInfoBackgroundView.trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
}
