import UIKit

final class TouristsTableViewCell: UITableViewCell {
    
    // MARK: - UI:
    private lazy var cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = UIConstants.mediumInset
        
        return stackView
    }()
    
    private lazy var nameInputView = CustomInputFormView(state: .standart, with: L10n.ReservationScreen.Customer.name)
    private lazy var surnameInputView = CustomInputFormView(state: .standart, with: L10n.ReservationScreen.Customer.surname)
    private lazy var birthdayInputView = CustomInputFormView(state: .standart, with: L10n.ReservationScreen.Customer.dateOfBirhtday)
    private lazy var citizenshipInputView = CustomInputFormView(state: .standart, with: L10n.ReservationScreen.Customer.citizenship)
    private lazy var passportNumberInputView = CustomInputFormView(state: .standart, with: L10n.ReservationScreen.Customer.passportNumber)
    private lazy var passportDurationInputView = CustomInputFormView(state: .standart, with: L10n.ReservationScreen.Customer.passportDuration)
    
    // MARK: - Lifecycle:
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views:
private extension TouristsTableViewCell {
    func setupViews() {
        selectionStyle = .none
        backgroundColor = .universalWhite
        
        [nameInputView, surnameInputView, birthdayInputView, citizenshipInputView, passportNumberInputView,
         passportDurationInputView].forEach(cellStackView.addArrangedSubview)
        
        contentView.setupView(cellStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: topAnchor),
            cellStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.sideInset),
            cellStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.sideInset),
            cellStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIConstants.sideInset)
        ])
        
        [nameInputView, surnameInputView, birthdayInputView, citizenshipInputView, passportNumberInputView,
         passportDurationInputView].forEach { viewElement in
            viewElement.heightAnchor.constraint(equalToConstant: 52).isActive = true
        }
    }
}
