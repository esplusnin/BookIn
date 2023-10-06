import UIKit

final class ReservationViewController: UIViewController {
    
    // MARK: - Dependencies:
    private let coordinator: CoordinatorProtocol?
    
    // MARK: - UI:
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
    
    private lazy var customNavigationBar = CustomNavigationBar(coordinator: coordinator, title: L10n.ReservationScreen.reservation, isBackButton: true)
    private lazy var hotelInfoBackgroundView = CustomBackgroundView(isRounded: true)
    private lazy var tripInfoBackgroundView = CustomBackgroundView(isRounded: true)
    private lazy var customHotelRateView = CustomHotelRateView()
    
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
    }
}

// MARK: - SetupViews:
private extension ReservationViewController {
    func setupViews() {
        view.backgroundColor = .univarsalViewBackground
        
        [customHotelRateView, hotelNameLabel, hotelLocationButton].forEach(hotelInfoStackView.addArrangedSubview)
        [customNavigationBar, hotelInfoBackgroundView, hotelInfoStackView, tripInfoBackgroundView,
         tripInfoStackView].forEach(view.setupView)
        
        customNavigationBar.setupNavigationBar()
    }
    
    func setupConstraints() {
        setupHotelInfoBackgroundView()
        setupHotelInfoStackView()
        setupTripInfoBackgroundInfo()
        setupTripInfoStackView()
    }
    
    func setupHotelInfoBackgroundView() {
        NSLayoutConstraint.activate([
            hotelInfoBackgroundView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor, constant: UIConstants.mediumInset),
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
}
