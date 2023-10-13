import UIKit

final class CustomInputFormView: UIView {

    // MARK: - Constants and Variables:
    enum ViewState {
        case number
        case email
        case birthday
        case passportNumber
        case passportDuration
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
        setupTextFieldKeyboardType()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func getTextFieldValue() -> String? {
        if enterInfoTextField.hasText {
            return enterInfoTextField.text
        } else {
            changeViewState(isError: true)
            return nil
        }
    }
    
    // MARK: - Private Methods:
    private func setupTextFieldKeyboardType() {
        switch viewState {
        case .number:
            enterInfoTextField.keyboardType = .numberPad
        case .birthday:
            enterInfoTextField.keyboardType = .numberPad
        case .passportNumber:
            enterInfoTextField.keyboardType = .numberPad
        case .passportDuration:
            enterInfoTextField.keyboardType = .numberPad
        default:
            enterInfoTextField.keyboardType = .default
        }
    }
    
    private func changeViewState(isError: Bool) {
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        changeViewState(isError: false)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        
        if viewState == .number {
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = format(with: "X (XXX) XXX-XX-XX", phone: newString)
        } else if viewState == .birthday || viewState == .passportDuration {
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = format(with: "XX.XX.XXXX", phone: newString)
        } else if viewState == .passportNumber {
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = format(with: "XX XXXXXXX", phone: newString)
        } else {
            textField.text = text
            return true
        }
        
        return false
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text?.count != 0 {
            if viewState == .email {
                if isValidEmail(textField.text ?? "") {
                    addTitleToStackView()
                    enterInfoTextField.text = enterInfoTextField.text?.lowercased() ?? ""
                    return true
                } else {
                    return false
                }
            }
        } else {
            titleLabel.removeFromSuperview()
        }
        
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for character in mask where index < numbers.endIndex {
            if character == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(character)
            }
        }
        
        return result
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let popularHosts = ["@mail.ru", "@mail.com", "@gmail.com", "@rambler.com", "@yandex.ru"]
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isFormatValid = emailPredicate.evaluate(with: email)
        let lowercaseEmail = email.lowercased()
        
        for host in popularHosts {
            if isFormatValid && lowercaseEmail.contains(host) {
                changeViewState(isError: false)
                return true
            } else {
                changeViewState(isError: true)
            }
        }
        
        return false
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
