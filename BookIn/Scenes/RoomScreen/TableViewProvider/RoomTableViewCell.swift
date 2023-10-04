import UIKit

final class RoomTableViewCell: UITableViewCell {
    
    // MARK: - Classes:
    private let roomTableViewCellCollectionViewProvider = RoomTableViewCellCollectionViewProvider()
    
    // MARK: - Constants and Variables:
    private let priceLabelsInset: CGFloat = 3
    
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
        label.font = .mediumBodyFont
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
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupRoom(model: Room) {
        self.roomModel = model
    }
    
    // MARK: - Private Methods:
    private func setupRoomInfo() {
        guard let roomModel else { return }
        
        roomTableViewCellCollectionViewProvider.setupRoomModel(with: roomModel)
        customPresenterScrollView.setupImagesURLs(with: roomModel.imageURLs)
    }
}

// MARK: - Setup Views:
private extension RoomTableViewCell {
    func setupViews() {
        backgroundColor = .clear
        
        [customBackgroundView, customPresenterScrollView, roomCollectionView,
         priceLabel, priceDescriptionLabel].forEach(contentView.setupView)
    }
    
    func setupConstraints() {
        setupBackgroundViewConstraints()
        setupCustomPresenterScrollViewConstraints()
        setupRoomCollectionViewConstraints()
        setupPriceLabelConstraints()
        setupPriceDescriptionLabelConstraints()
    }
    
    func setupBackgroundViewConstraints() {
        NSLayoutConstraint.activate([
            customBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: UIConstants.mediumInset),
            customBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setupCustomPresenterScrollViewConstraints() {
        NSLayoutConstraint.activate([
            customPresenterScrollView.heightAnchor.constraint(equalToConstant: UIConstants.viewHeight),
            customPresenterScrollView.topAnchor.constraint(equalTo: customBackgroundView.topAnchor, constant: UIConstants.sideInset),
            customPresenterScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customPresenterScrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setupRoomCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            roomCollectionView.heightAnchor.constraint(equalToConstant: 50),
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
}
