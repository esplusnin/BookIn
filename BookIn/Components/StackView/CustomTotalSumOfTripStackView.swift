import UIKit

final class CustomTotalSumOfTripStackView: UIStackView {
    
    // MARK: - UI:
    private lazy var tourPricaLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var fuelPriceLabel: UILabel = {
       let label = UILabel()
        
        return label
    }()
    
    private lazy var serviceFeeLabel: UILabel = {
       let label = UILabel()
        
        return label
    }()
    
    private lazy var toPayLabel: UILabel = {
       let label = UILabel()
        
        return label
    }()
    
    
    private lazy var firstRowStackView = UIStackView()
    private lazy var secondRowStackView = UIStackView()
    private lazy var thirdRowStackView = UIStackView()
    private lazy var fourthRowStackView = UIStackView()
}

// MARK: - Setup Views:
private extension CustomTotalSumOfTripStackView {
    func setupViews() {
        spacing = UIConstants.sideInset
        
        [firstRowStackView, secondRowStackView, thirdRowStackView, fourthRowStackView].forEach { stackView in
            addArrangedSubview(stackView)
            stackView.axis = .horizontal
        }
    }
    
    func setupConstraints() {
        
    }
}
