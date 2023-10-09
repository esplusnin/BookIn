import UIKit

final class CustomTotalSumOfTripStackView: UIStackView {
    
    // MARK: - UI:
    private lazy var tourPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumBodyFont
        label.textColor = .universalGray
        label.text = L10n.ReservationScreen.TotalSum.tourPrice
        
        return label
    }()
    
    private lazy var fuelFeeLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumBodyFont
        label.textColor = .universalGray
        label.text = L10n.ReservationScreen.TotalSum.fuelFee
        
        return label
    }()
    
    private lazy var serviceFeeLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumBodyFont
        label.textColor = .universalGray
        label.text = L10n.ReservationScreen.TotalSum.serviceFee
        
        return label
    }()
    
    private lazy var toPayLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumBodyFont
        label.textColor = .universalGray
        label.text = L10n.ReservationScreen.TotalSum.sum
        
        return label
    }()
    
    private lazy var tourPriceValueLabel = UILabel()
    private lazy var fuelFeeValueLabel = UILabel()
    private lazy var serviceFeeValueLabel = UILabel()
    private lazy var toPayValueLabel = UILabel()
    
    private lazy var firstRowStackView = UIStackView()
    private lazy var secondRowStackView = UIStackView()
    private lazy var thirdRowStackView = UIStackView()
    private lazy var fourthRowStackView = UIStackView()
    
    // MARK: - Lifecycle:
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupTripCostInfo(from model: Trip) {
        let currencyFormattedService = CurrencyFormatterService()
        
        let tourPriceString = currencyFormattedService.getCurrencyString(from: model.tourPrice)
        let fuelChargeString = currencyFormattedService.getCurrencyString(from: model.fuelCharge)
        let serviceChargeString = currencyFormattedService.getCurrencyString(from: model.serviceCharge)
        let totalCostString = currencyFormattedService.getCurrencyString(from: model.tourPrice + model.fuelCharge + model.serviceCharge)
        
        tourPriceValueLabel.text = tourPriceString
        fuelFeeValueLabel.text = fuelChargeString
        serviceFeeValueLabel.text = serviceChargeString
        toPayValueLabel.text = totalCostString
    }
}

// MARK: - Setup Views:
extension CustomTotalSumOfTripStackView {
    private func setupViews() {
        axis = .vertical
        spacing = UIConstants.sideInset
        
        [tourPriceLabel, tourPriceValueLabel].forEach(firstRowStackView.addArrangedSubview)
        [fuelFeeLabel, fuelFeeValueLabel].forEach(secondRowStackView.addArrangedSubview)
        [serviceFeeLabel, serviceFeeValueLabel].forEach(thirdRowStackView.addArrangedSubview)
        [toPayLabel, toPayValueLabel].forEach(fourthRowStackView.addArrangedSubview)
        
        [firstRowStackView, secondRowStackView, thirdRowStackView, fourthRowStackView].forEach { stackView in
            addArrangedSubview(stackView)
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
        }
        
        [tourPriceValueLabel, fuelFeeValueLabel, serviceFeeValueLabel, toPayValueLabel].forEach { label in
            label.font = .mediumBodyFont
            label.textColor = .universalBlackPrimary
            label.textAlignment = .right
        }
        
        toPayValueLabel.textColor = .universalBlue
    }
}
