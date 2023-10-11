import UIKit

final class CustomPageControlView: UIView {
    
    // MARK: - Constants and Variables:
    private let stackViewHeight: CGFloat = 7
    
    // MARK: - UI:
    private lazy var pagesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = UIConstants.smallInset
        
        return stackView
    }()
    
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
    func setupStackViewPages(with number: Int) {
        for _ in 0..<number {
            let pageImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: stackViewHeight, height: stackViewHeight))
            pageImageView.layer.cornerRadius = stackViewHeight / 2
            
            pagesStackView.addArrangedSubview(pageImageView)
        }

        selectPage(with: 0)
    }
    
    func selectPage(with number: Int) {
        for (index, pageView) in pagesStackView.arrangedSubviews.enumerated() {
            if index == number {
                pageView.backgroundColor = .universalBlackPrimary
            } else {
                pageView.backgroundColor = index + 1 == number || index - 1 == number ? .universalGray : .universalLightGray
            }
        }
    }
}

// MARK: - Setup Views:
private extension CustomPageControlView {
    func setupViews() {
        layer.cornerRadius = UIConstants.smallCornerRadius
        backgroundColor = .universalWhite

        setupView(pagesStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            pagesStackView.heightAnchor.constraint(equalToConstant: stackViewHeight),
            pagesStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            pagesStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.largeInset),
            pagesStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.largeInset)
        ])
    }
}
