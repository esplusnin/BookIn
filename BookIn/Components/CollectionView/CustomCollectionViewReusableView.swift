import UIKit

final class CustomCollectionViewReusableView: UICollectionReusableView {
    
    // MARK: - UI:
    private lazy var titleLabel = UILabel()
    
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
    func setupLabel(with text: String, isTitle: Bool) {
        titleLabel.text = text
        titleLabel.numberOfLines = 0
        
        if isTitle {
            titleLabel.font = .largeTitleFont
            titleLabel.textColor = .universalBlackPrimary
        } else {
            titleLabel.font = .regularBodyFont
            titleLabel.textColor = .universalBlackPrimary.withAlphaComponent(0.9)
        }
    }
}

private extension CustomCollectionViewReusableView {
    func setupViews() {
        setupView(titleLabel)
    }
    
    func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.sideInset),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
}
