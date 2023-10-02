import UIKit

final class HotelCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI:
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumBodyFont
        label.textColor = .universalGray
        
        return label
    }()
    
    // MARK: - Lifecycle:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupTitleLabel(with name: String) {
        titleLabel.text = name
    }
}

// MARK: - Setup Views:
private extension HotelCollectionViewCell {
    func setupViews() {
        layer.cornerRadius = UIConstants.smallCornerRadius
        backgroundColor = .universalLightGray
        contentView.setupView(titleLabel)
    }
    
    func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: UIConstants.smallInset),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.largeInset),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIConstants.smallInset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.largeInset)
        ])
    }
}
