import UIKit

final class CustomInputFormView: UIView {
    
    // MARK: - Constants and Variables:
    enum ViewState {
        case number
        case email
        case standart
    }
    
    private let viewState: ViewState
    
    private var topStackAnchor: NSLayoutConstraint?
    private var bottomStackAnchor: NSLayoutConstraint?
    
    // MARK: - UI:
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .extraSmallBodyFont
        label.textColor = .universalLightGray
        
        return label
    }()
    
    private lazy var enterInfoTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.universalLightGray.withAlphaComponent(1)])
        textField.clearButtonMode = .whileEditing
        textField.font = .regularBodyFont
        textField.textColor = .universalBlackPrimary
        
        return textField
    }()
    
    // MARK: - Lifecycle:
    init(state: ViewState, with text: String) {
        self.viewState = state
        super.init(frame: .zero)
        setupNewPlaceholder(with: text)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func isViewFilled() -> Bool {
        if enterInfoTextField.hasText {
            return true
        } else {
            
            return false
        }
    }
    
    func changeViewState(isError: Bool) {
        backgroundColor = isError ? .universalErrorColor : .universalViewBackground
    }
    
    // MARK: - Private Methods:
    private func setupNewPlaceholder(with text: String) {
        enterInfoTextField.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.universalLightGray.withAlphaComponent(1)])
    }
    
    private func addTitleToStackView() {
        topStackAnchor?.isActive = false
        bottomStackAnchor?.isActive = false
        
        infoStackView.insertArrangedSubview(titleLabel, at: 0)
        titleLabel.text = enterInfoTextField.placeholder
        
        topStackAnchor = infoStackView.topAnchor.constraint(equalTo: topAnchor, constant: UIConstants.largeInset)
        bottomStackAnchor = infoStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIConstants.largeInset)
        
        topStackAnchor?.isActive = true
        bottomStackAnchor?.isActive = true
    }
}

// MARK: - UITextFieldDelegate:
extension CustomInputFormView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count != 0 {
            addTitleToStackView()
            
            if viewState == .email {
                enterInfoTextField.text = enterInfoTextField.text?.lowercased() ?? ""
            }
        } else {
            titleLabel.removeFromSuperview()
        }
    }
}

// MARK: - Setup Views:
private extension CustomInputFormView {
    func setupViews() {
        backgroundColor = .universalViewBackground
        layer.cornerRadius = UIConstants.mediumCornerRadius
        
        infoStackView.addArrangedSubview(enterInfoTextField)
        [infoStackView].forEach(setupView)
    }
    
    func setupConstraints() {
        setupInfoStackViewConstraints()
    }
    
    func setupInfoStackViewConstraints() {
        topStackAnchor = infoStackView.topAnchor.constraint(equalTo: topAnchor, constant: UIConstants.sideInset)
        bottomStackAnchor = infoStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIConstants.sideInset)
        
        topStackAnchor?.isActive = true
        bottomStackAnchor?.isActive = true
        
        infoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.sideInset).isActive = true
        infoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.sideInset).isActive = true
    }
}
