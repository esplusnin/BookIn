import UIKit

final class CustomHotelRateView: UIView {
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let smallInset: CGFloat = 2
        static let imageSide: CGFloat = 15
        static let viewHeight: CGFloat = 29
    }
    
    // MARK: - UI:
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .smallTitleFont
        label.textColor = .universalOrange
        
        return label
    }()
    
    private lazy var ratingImageView = UIImageView()
    
    // MARK: - Lifecycle:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupRatingInfo(with rate: Int, description: String) {
        ratingImageView.image = Resources.Images.ratingStar
        ratingLabel.text = "\(rate) " + description
    }
}

// MARK: - Setup Views:
private extension CustomHotelRateView {
    func setupViews() {
        layer.cornerRadius = UIConstants.smallCornerRadius
        backgroundColor = .universalLightOrange
        
        [ratingImageView, ratingLabel].forEach(setupView)
    }
    
    func setupConstraints() {
        heightAnchor.constraint(equalToConstant: LocalUIConstants.viewHeight).isActive = true
        
        setupRatingImageViewConstraints()
        setupRatingLabelConstraints()
    }
    
    func setupRatingImageViewConstraints() {
        NSLayoutConstraint.activate([
            ratingImageView.heightAnchor.constraint(equalToConstant: LocalUIConstants.imageSide),
            ratingImageView.widthAnchor.constraint(equalToConstant: LocalUIConstants.imageSide),
            ratingImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.largeInset),
            ratingImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setupRatingLabelConstraints() {
        NSLayoutConstraint.activate([
            ratingLabel.centerYAnchor.constraint(equalTo: ratingImageView.centerYAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: ratingImageView.trailingAnchor, constant: LocalUIConstants.smallInset),
            ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.largeInset)
        ])
    }
}
