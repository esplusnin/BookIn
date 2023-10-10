import Combine
import UIKit

final class ReservationViewController: UIViewController {
    
    // MARK: - Dependencies:
    private let coordinator: CoordinatorProtocol?
    private let viewModel: ReservationViewModelProtocol?
    
    // MARK: - Classes:
    private let touristsTableViewProvider = TouristsTableViewProvider()
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let aboutCustomerInset: CGFloat = 20
        static let bottomInset: CGFloat = 10
        static let mediumInset: CGFloat = 12
        static let buttonBackgroundViewHeight: CGFloat = 500
        static let buttonBackgroundViewOutInset: CGFloat = 88
    }
    
    private var cancellable = Set<AnyCancellable>()
    
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
        button.titleLabel?.font = .smallRegularBodyFont
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
        label.font = .smallRegularBodyFont
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
    
    private lazy var touristsTableView: ContentSizedTableView = {
        let tableView = ContentSizedTableView()
        tableView.register(TouristsTableViewCell.self, forCellReuseIdentifier: Resources.Identifiers.touristsTableViewCell)
        tableView.register(ExpandableTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: Resources.Identifiers.reservationTableView)
        tableView.dataSource = touristsTableViewProvider
        tableView.delegate = touristsTableViewProvider
        tableView.sectionHeaderTopPadding = UIConstants.mediumInset
        tableView.isScrollEnabled = false
        tableView.contentMode = .top
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private lazy var customNavigationBar = CustomNavigationBar(coordinator: coordinator, title: L10n.ReservationScreen.reservation, isBackButton: true)
    private lazy var hotelInfoBackgroundView = CustomBackgroundView(isRounded: true)
    private lazy var tripInfoBackgroundView = CustomBackgroundView(isRounded: true)
    private lazy var customerInfoBackgroundView = CustomBackgroundView(isRounded: true)
    private lazy var totalSumOfTripBackgroundView = CustomBackgroundView(isRounded: true)
    private lazy var toPayButtonBackgroundView = CustomBackgroundView(isRounded: false)
    private lazy var customHotelRateView = CustomHotelRateView()
    private lazy var customerPhoneNumberView = CustomInputFormView(state: .number, with: L10n.ReservationScreen.Customer.phoneNumber)
    private lazy var customerEmailView = CustomInputFormView(state: .email, with: L10n.ReservationScreen.Customer.email)
    private lazy var customTotalSumOfTripStackView = CustomTotalSumOfTripStackView()
    private lazy var toPayButton = CustomBaseButton(with: L10n.ReservationScreen.TotalSum.pay)
    
    // MARK: - Lifecycle:
    init(coordinator: CoordinatorProtocol?, viewModel: ReservationViewModelProtocol?) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupTargets()
        setupObservers()
        
        touristsTableViewProvider.setupViewModel(from: viewModel)
        touristsTableViewProvider.setupHeaderViewDelegate(self)
        
        blockUI()
        bind()
        viewModel?.fetchTripData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Private Methods:
    private func bind() {
        viewModel?.tripPublisher
            .sink { [weak self] trip in
                guard let self,
                      let trip else { return }
                DispatchQueue.main.async {
                    self.updateTripInfo(with: trip)
                    self.unblockUI()
                }
            }
            .store(in: &cancellable)
    }
    
    private func updateTripInfo(with model: Trip) {
        customHotelRateView.setupRatingInfo(with: model.horating, description: model.ratingName)
        hotelNameLabel.text = model.hotelName
        hotelLocationButton.setTitle(model.hotelAdress, for: .normal)
        tripInfoStackView.setupTrip(with: model)
        customTotalSumOfTripStackView.setupTripCostInfo(from: model)
    }
    
    // MARK: - Objc Methods:
    @objc private func goToPaymentSuccesScreen() {
        coordinator?.goToPaymentSuccesViewController()
    }
}

// MARK: - ExpandableTableViewHeaderFooterViewDelegate:
extension ReservationViewController: ExpandableTableViewHeaderViewDelegate {
    func toggleHeaderView(from section: Int) {
        switch touristsTableViewProvider.tourists[section].status {
        case .created:
            viewModel?.appendNewHeaderView()
            touristsTableView.insertSections([touristsTableViewProvider.tourists.count - 1], with: .automatic)
        case .wrapped:
            viewModel?.changeTouristHeaderViewStatus(from: section, to: .unwrapped)
        case .unwrapped:
            viewModel?.changeTouristHeaderViewStatus(from: section, to: .wrapped)
        }
        
        touristsTableView.performBatchUpdates { [weak self] in
            guard let self,
                  let headerView = self.touristsTableView.headerView(
                    forSection: section) as? ExpandableTableViewHeaderFooterView else { return }
            
            self.touristsTableView.reloadRows(at: [IndexPath(row: 0, section: section)], with: .automatic)
            
            let name = touristsTableViewProvider.tourists[section].name
            let status = touristsTableViewProvider.tourists[section].status
            
            headerView.setupHeaderView(with: name, state: status, from: section)
        }
    }
}

// MARK: - Setup Views:
private extension ReservationViewController {
    func setupViews() {
        view.backgroundColor = .universalViewBackground
        
        [customHotelRateView, hotelNameLabel, hotelLocationButton].forEach(hotelInfoStackView.addArrangedSubview)
        [customerPhoneNumberView, customerEmailView, privacyLabel].forEach(aboutCustomerStackView.addArrangedSubview)
        
        [customNavigationBar, mainScreenScrollView].forEach(view.setupView)
        [hotelInfoBackgroundView, hotelInfoStackView, tripInfoBackgroundView, tripInfoStackView, customerInfoBackgroundView,
         aboutCustomerLabel, aboutCustomerStackView, touristsTableView, totalSumOfTripBackgroundView,
         customTotalSumOfTripStackView, toPayButtonBackgroundView, toPayButton].forEach(mainScreenScrollView.setupView)
        
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
        setupTouristsTableViewConstraints()
        setupTotalSumOfTripBackgroundViewConstraints()
        setupTotalSumOfTripStackView()
        setupToPayButtonBackgroundViewConstraints()
        setupToPayButtonConstraints()
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
            customerInfoBackgroundView.bottomAnchor.constraint(equalTo: aboutCustomerStackView.bottomAnchor, constant: UIConstants.sideInset)
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
            aboutCustomerStackView.topAnchor.constraint(equalTo: aboutCustomerLabel.bottomAnchor, constant: LocalUIConstants.aboutCustomerInset),
            aboutCustomerStackView.leadingAnchor.constraint(equalTo: customerInfoBackgroundView.leadingAnchor, constant: UIConstants.sideInset),
            aboutCustomerStackView.trailingAnchor.constraint(equalTo: customerInfoBackgroundView.trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
    
    func setupTouristsTableViewConstraints() {
        NSLayoutConstraint.activate([
            touristsTableView.topAnchor.constraint(equalTo: customerInfoBackgroundView.bottomAnchor, constant: UIConstants.mediumInset),
            touristsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            touristsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupTotalSumOfTripBackgroundViewConstraints() {
        NSLayoutConstraint.activate([
            totalSumOfTripBackgroundView.topAnchor.constraint(equalTo: touristsTableView.bottomAnchor, constant: UIConstants.mediumInset),
            totalSumOfTripBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalSumOfTripBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            totalSumOfTripBackgroundView.bottomAnchor.constraint(equalTo: customTotalSumOfTripStackView.bottomAnchor, constant: UIConstants.sideInset),
            totalSumOfTripBackgroundView.bottomAnchor.constraint(equalTo: mainScreenScrollView.bottomAnchor, constant: -LocalUIConstants.buttonBackgroundViewOutInset)
        ])
    }
    
    func setupTotalSumOfTripStackView() {
        NSLayoutConstraint.activate([
            customTotalSumOfTripStackView.topAnchor.constraint(equalTo: totalSumOfTripBackgroundView.topAnchor, constant: UIConstants.sideInset),
            customTotalSumOfTripStackView.leadingAnchor.constraint(equalTo: totalSumOfTripBackgroundView.leadingAnchor, constant: UIConstants.sideInset),
            customTotalSumOfTripStackView.trailingAnchor.constraint(equalTo: totalSumOfTripBackgroundView.trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
    
    func setupToPayButtonBackgroundViewConstraints() {
        NSLayoutConstraint.activate([
            toPayButtonBackgroundView.heightAnchor.constraint(equalToConstant: LocalUIConstants.buttonBackgroundViewHeight),
            toPayButtonBackgroundView.topAnchor.constraint(equalTo: totalSumOfTripBackgroundView.bottomAnchor, constant: LocalUIConstants.bottomInset),
            toPayButtonBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toPayButtonBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupToPayButtonConstraints() {
        NSLayoutConstraint.activate([
            toPayButton.topAnchor.constraint(equalTo: toPayButtonBackgroundView.topAnchor, constant: LocalUIConstants.mediumInset),
            toPayButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
            toPayButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
}

// MARK: - Add Targets:
extension ReservationViewController {
    private func setupTargets() {
        toPayButton.addTarget(self, action: #selector(goToPaymentSuccesScreen), for: .touchUpInside)
    }
}
