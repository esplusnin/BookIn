import UIKit

final class RoomTableViewCell: UITableViewCell {
    
    // MARK: - Dependencies:
    private var coordinator: CoordinatorProtocol?
    
    // MARK: - Classes:
    private let roomTableViewCellCollectionViewProvider = RoomTableViewCellCollectionViewProvider()
    
    // MARK: - Constants and Variables:
    private let priceLabelsInset: CGFloat = 3
    private let collectionHeight: CGFloat = 120
    
    private var roomModel: Room? {
        didSet {
            setupRoomInfo()
        }
    }
    
    // MARK: - UI:
    private lazy var roomCollectionView: UICollectionView = {
        let layout = CustomSelfSizeCollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewCell.self,
                                forCellWithReuseIdentifier: Resources.Identifiers.roomCollectionViewCell)
        collectionView.register(CustomCollectionViewReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: Resources.Identifiers.roomCollectionViewHeader)
        collectionView.dataSource = roomTableViewCellCollectionViewProvider
        collectionView.delegate = roomTableViewCellCollectionViewProvider
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .extraLargeBodyFont
        label.textColor = .universalBlackPrimary
        
        return label
    }()
    
    private lazy var priceDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .regularBodyFont
        label.textColor = .universalGray
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var customBackgroundView = CustomBackgroundView(isRounded: true)
    private lazy var customPresenterScrollView = CustomPresenterScrollView()
    private lazy var chooseRoomButton = CustomBaseButton(with: L10n.RoomScreen.chooseTheRoom)
    
    // MARK: - Lifecycle:
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        setupTargets()
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        guard let lastCell = roomCollectionView.visibleCells.last else { return }
        priceLabel.topAnchor.constraint(equalTo: lastCell.bottomAnchor, constant: UIConstants.sideInset).isActive = true
    }
    
    // MARK: - Public Methods:
    func setupCoordinator(from coordinator: CoordinatorProtocol?) {
        self.coordinator = coordinator
    }

    func setupRoom(model: Room) {
        self.roomModel = model
    }
    
    // MARK: - Private Methods:
    private func setupRoomInfo() {
        guard let roomModel else { return }
        let formattedCurrencyString = CurrencyFormatterService().getCurrencyString(from: roomModel.price)
        
        roomTableViewCellCollectionViewProvider.setupRoomModel(with: roomModel)
        customPresenterScrollView.setupImagesURLs(with: roomModel.imageURLs)
        
        priceLabel.text = formattedCurrencyString
        priceDescriptionLabel.text = roomModel.pricePer
    }
    
    // MARK: - Objc Methods:
    @objc private func goToReservationViewController() {
        coordinator?.goToReservationViewController()
    }
}

// MARK: - Setup Views:
private extension RoomTableViewCell {
    func setupViews() {
        [customBackgroundView, customPresenterScrollView, roomCollectionView,
         priceLabel, priceDescriptionLabel, chooseRoomButton].forEach(contentView.setupView)
    }
    
    func setupConstraints() {
        setupBackgroundViewConstraints()
        setupCustomPresenterScrollViewConstraints()
        setupRoomCollectionViewConstraints()
        setupPriceLabelConstraints()
        setupPriceDescriptionLabelConstraints()
        setupChooseRoomButtonConstraints()
    }
    
    func setupBackgroundViewConstraints() {
        NSLayoutConstraint.activate([
            customBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: UIConstants.mediumInset),
            customBackgroundView.leadingAnchor.constraint(equalTo:  leadingAnchor),
            customBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customBackgroundView.bottomAnchor.constraint(equalTo: chooseRoomButton.bottomAnchor, constant: UIConstants.sideInset)
        ])
    }
    
    func setupCustomPresenterScrollViewConstraints() {
        NSLayoutConstraint.activate([
            customPresenterScrollView.heightAnchor.constraint(equalToConstant: UIConstants.viewHeight),
            customPresenterScrollView.topAnchor.constraint(equalTo: customBackgroundView.topAnchor, constant: UIConstants.sideInset),
            customPresenterScrollView.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor),
            customPresenterScrollView.trailingAnchor.constraint(equalTo: customBackgroundView.trailingAnchor)
        ])
    }
    
    func setupRoomCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            roomCollectionView.heightAnchor.constraint(equalToConstant: collectionHeight),
            roomCollectionView.topAnchor.constraint(equalTo: customPresenterScrollView.bottomAnchor, constant: UIConstants.mediumInset),
            roomCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            roomCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setupPriceLabelConstraints() {
        priceLabel.topAnchor.constraint(equalTo: roomCollectionView.bottomAnchor, constant: UIConstants.sideInset).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.sideInset).isActive = true
    }
    
    func setupPriceDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            priceDescriptionLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: UIConstants.mediumInset),
            priceDescriptionLabel.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: -priceLabelsInset),
            priceDescriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
    
    func setupChooseRoomButtonConstraints() {
        NSLayoutConstraint.activate([
            chooseRoomButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: UIConstants.sideInset),
            chooseRoomButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.sideInset),
            chooseRoomButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
}

// MARK: - Setup Targets:
extension RoomTableViewCell {
    private func setupTargets() {
        chooseRoomButton.addTarget(self, action: #selector(goToReservationViewController), for: .touchUpInside)
    }
}
