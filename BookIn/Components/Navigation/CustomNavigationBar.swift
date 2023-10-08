import UIKit

final class CustomNavigationBar: UIView {
    
    // MARK: - Dependencies:
    weak var coordinator: CoordinatorProtocol?
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let barsHeight: CGFloat = 57
        static let navigationBarBackButtonSide: CGFloat = 32
        static let navigationBarBackButtonLeftInset: CGFloat = 10
    }
    
    // MARK: - UI:
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = .mediumTitleFont
        titleLabel.textColor = .universalBlackPrimary
        return titleLabel
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(Resources.Images.navigationBackButton, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle:
    init(coordinator: CoordinatorProtocol?, title: String, isBackButton: Bool) {
        super.init(frame: .zero)
        self.coordinator = coordinator
        self.titleLabel.text = title
        
        if !isBackButton {
            backButton.isHidden = true
        }
        
        setupViews()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupNavigationBar() {
        guard let superview else { return }
                        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: LocalUIConstants.barsHeight),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
        
        setupConstraints()
    }
    
    // MARK: - Objc Methods:
    @objc private func goBack() {
        coordinator?.goBack()
    }
}

// MARK: - Setup Views:
private extension CustomNavigationBar {
    func setupViews() {
        self.backgroundColor = .universalWhite
        [titleLabel, backButton].forEach(setupView)
    }
    
    func setupConstraints() {
        guard let superview else { return }
        
        let isHidden = backButton.isHidden
        
        setupBackButtonConstraints(with: superview)
        setupTitleLabelConstraints(isButtonHidden: isHidden, with: superview)
    }
    
    func setupBackButtonConstraints(with view: UIView) {
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LocalUIConstants.barsHeight / 2),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LocalUIConstants.navigationBarBackButtonLeftInset),
            backButton.heightAnchor.constraint(equalToConstant: LocalUIConstants.navigationBarBackButtonSide),
            backButton.widthAnchor.constraint(equalToConstant: LocalUIConstants.navigationBarBackButtonSide)
        ])
    }
    
    func setupTitleLabelConstraints(isButtonHidden: Bool, with view: UIView) {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LocalUIConstants.barsHeight / 2),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
    
    func setupTargets() {
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
}
