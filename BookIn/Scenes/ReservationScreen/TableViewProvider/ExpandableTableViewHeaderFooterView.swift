import UIKit

final class ExpandableTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    // MARK: - Dependencies:
    weak var delegate: ExpandableTableViewHeaderFooterViewDelegate?
    
    // MARK: - Constants and Variables:
    private (set) var headerViewStatus: ExpandableMenuStatus? {
        didSet {
            changeButtonState()
        }
    }
    
    private enum LocalUIConstants {
        static let buttonSide: CGFloat = 32
        static let sideInset: CGFloat = 13
        static let largCornerRadius: CGFloat = 12
        static let smallCornerRadius: CGFloat = 6
    }
    
    private var section: Int?
    
    // MARK: - UI:
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .largeTitleFont
        label.textColor = .universalBlackPrimary
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var actionButton = UIButton()
    
    // MARK: - Lifecycle:
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupHeaderView(with title: String, state: ExpandableMenuStatus, from section: Int) {
        titleLabel.text = title
        headerViewStatus = state
        self.section = section
        
        contentView.backgroundColor = .universalWhite
        contentView.layer.cornerRadius = LocalUIConstants.largCornerRadius
    }
    
    // MARK: - Private Methods:
    private func changeButtonState() {
        switch headerViewStatus {
        case .wrapped:
            actionButton.backgroundColor = .universalLightBlue
            actionButton.setImage(Resources.Images.wrappedHeaderViewImage, for: .normal)
        case .unwrapped:
            actionButton.backgroundColor = .universalLightBlue
            actionButton.setImage(Resources.Images.unwrappedHeaderViewImage, for: .normal)
        case .created:
            actionButton.backgroundColor = .universalBlue
            actionButton.setImage(Resources.Images.createdHeaderViewImage, for: .normal)
        default:
            return
        }
    }
    
    // MARK: - Objc Methods:
    @objc private func headerViewDidClicked() {
        guard let section else { return }
        delegate?.toggleHeaderView(from: section)
    }
}

// MARK: - Setup Views:
private extension ExpandableTableViewHeaderFooterView {
    func setupViews() {
        [titleLabel, actionButton].forEach(setupView)
        
        actionButton.layer.cornerRadius = LocalUIConstants.smallCornerRadius
    }
    
    func setupConstraints() {
        setupTitleLabelConstraints()
        setupActionButtonConstraints()
    }
    
    func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LocalUIConstants.sideInset),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.sideInset),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LocalUIConstants.sideInset),
            titleLabel.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -LocalUIConstants.sideInset)
        ])
    }
    
    func setupActionButtonConstraints() {
        NSLayoutConstraint.activate([
            actionButton.heightAnchor.constraint(equalToConstant: LocalUIConstants.buttonSide),
            actionButton.widthAnchor.constraint(equalToConstant: LocalUIConstants.buttonSide),
            actionButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
}

// MARK: - Setup Targets:
extension ExpandableTableViewHeaderFooterView {
    private func setupTargets() {
        actionButton.addTarget(self, action: #selector(headerViewDidClicked), for: .touchUpInside)
    }
}
