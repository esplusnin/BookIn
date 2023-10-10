import UIKit

final class HotelTableViewCell: UITableViewCell {
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let sideCellInset: CGFloat = 15
        static let topCelInset: CGFloat = 7
        static let leftCellInset: CGFloat = 12
        static let imageSide: CGFloat = 24
        static let insetBetweenLables: CGFloat = 2
    }
    
    // MARK: - UI:
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumTitleFont
        label.textColor = .universalBlackPrimary
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .smallMediumBodyFont
        label.textColor = .universalGray
        
        return label
    }()
    
    private lazy var accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Images.tableViewCellAccesoryType.withTintColor(.universalBlackPrimary, renderingMode: .alwaysOriginal)
        
        return imageView
    }()
    
    private lazy var cellImageView = UIImageView()
    
    // MARK: - Lifecycle:
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellInfo(with title: String, description: String, image: UIImage) {
        titleLabel.text = title
        descriptionLabel.text = description
        cellImageView.image = image
    }
}

// MARK: - Setup Views:
private extension HotelTableViewCell {
    func setupViews() {
        backgroundColor = .universalViewBackground
        isUserInteractionEnabled = false
        
        [cellImageView, titleLabel, descriptionLabel, accessoryImageView].forEach(contentView.setupView)
    }
    
    func setupConstraints() {
        setupCellImageViewConstraints()
        setupTitleLabelConstraints()
        setupDescriptionLabelConstraints()
        setupAccessoryImageView()
    }
    
    func setupCellImageViewConstraints() {
        NSLayoutConstraint.activate([
            cellImageView.heightAnchor.constraint(equalToConstant: LocalUIConstants.imageSide),
            cellImageView.widthAnchor.constraint(equalToConstant: LocalUIConstants.imageSide),
            cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LocalUIConstants.sideCellInset)
        ])
    }
    
    func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LocalUIConstants.sideCellInset),
            titleLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: LocalUIConstants.leftCellInset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(LocalUIConstants.imageSide + LocalUIConstants.sideCellInset))
        ])
    }
    
    func setupDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LocalUIConstants.insetBetweenLables),
            descriptionLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: LocalUIConstants.leftCellInset),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(LocalUIConstants.imageSide + LocalUIConstants.sideCellInset))
        ])
    }
    
    func setupAccessoryImageView() {
        NSLayoutConstraint.activate([
            accessoryImageView.heightAnchor.constraint(equalToConstant: 20),
            accessoryImageView.widthAnchor.constraint(equalToConstant: 12),
            accessoryImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            accessoryImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LocalUIConstants.sideCellInset)
        ])
    }
}
