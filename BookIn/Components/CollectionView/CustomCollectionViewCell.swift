import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants and Variables:
    private let cellInset: CGFloat = 2
    private let titleTrailingInset: CGFloat = 28
    
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
            accessoryImageView.heightAnchor.constraint(equalToConstant: 20),
            accessoryImageView.widthAnchor.constraint(equalToConstant: 12),
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
                                                 constant: isLastCell ? -titleTrailingInset : -UIConstants.largeInset)
        ])
    }
}
