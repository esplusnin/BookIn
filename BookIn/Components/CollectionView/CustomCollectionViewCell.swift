import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let cellInset: CGFloat = 2
        static let titleTrailingInset: CGFloat = 28
        static let accessoryHeight: CGFloat = 20
        static let accessoryWidht: CGFloat = 12
    }
    
    // MARK: - UI:
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumBodyFont
        label.textColor = .universalGray
        
        return label
    }()
    
    private lazy var accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Images.tableViewCellAccesoryType.withTintColor(.universalBlue, renderingMode: .alwaysOriginal)
        
        return imageView
    }()
    
    // MARK: - Lifecycle:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupTitleLabel(with name: String) {
        titleLabel.text = name
        setupTitleLabelConstraints(isLastCell: false)
    }
    
    func setupLastCell() {
        backgroundColor = .universalLightBlue
        titleLabel.text = L10n.RoomScreen.aboutTheRoom
        titleLabel.textColor = .universalBlue
        
        setupAccessoryImageView()
        setupTitleLabelConstraints(isLastCell: true)
    }
    
    // MARK: - Private Methods:
    private func setupAccessoryImageView() {
        setupView(accessoryImageView)
        
        accessoryImageView.image?.withTintColor(.universalBlue, renderingMode: .alwaysOriginal)
        
        NSLayoutConstraint.activate([
            accessoryImageView.heightAnchor.constraint(equalToConstant: LocalUIConstants.accessoryHeight),
            accessoryImageView.widthAnchor.constraint(equalToConstant: LocalUIConstants.accessoryWidht),
            accessoryImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            accessoryImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.largeInset)
        ])
        
        layoutIfNeeded()
    }
}

// MARK: - Setup Views:
private extension CustomCollectionViewCell {
    func setupViews() {
        layer.cornerRadius = UIConstants.smallCornerRadius
        backgroundColor = .universalViewBackground
        contentView.setupView(titleLabel)
    }
    
    func setupTitleLabelConstraints(isLastCell: Bool) {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: UIConstants.smallInset),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.largeInset),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIConstants.smallInset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: isLastCell ? -LocalUIConstants.titleTrailingInset : -UIConstants.largeInset)
        ])
    }
}
