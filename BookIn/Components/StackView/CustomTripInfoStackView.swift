import UIKit

final class CustomTripInfoStackView: UIStackView {
    
    // MARK: - Constants and Variables:
    private var tripModel: Trip? {
        didSet {
            setupTripInfo()
        }
    }
    
    // MARK: - UI:
    private lazy var departureFromLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.ReservationScreen.departureFrom
        
        return label
    }()
    private lazy var countryCityLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.ReservationScreen.countryCity
        
        return label
    }()
    
    private lazy var datesLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.ReservationScreen.dates
        
        return label
    }()
    
    private lazy var numberOfNightsLabell: UILabel = {
        let label = UILabel()
        label.text = L10n.ReservationScreen.numberOfNights
        
        return label
    }()
    
    private lazy var stackHotelNameLabell: UILabel = {
        let label = UILabel()
        label.text = L10n.ReservationScreen.stackHotelName
        
        return label
    }()
    
    private lazy var roomNameLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.ReservationScreen.roomName
        
        return label
    }()
    
    private lazy var nutritionLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.ReservationScreen.nutrition
        
        return label
    }()
    
    private lazy var departureFromFormLabel = UILabel()
    private lazy var countryCityFormLabel = UILabel()
    private lazy var datesFormLabel = UILabel()
    private lazy var numberOfNightsFormLabell = UILabel()
    private lazy var stackHotelNameFormLabell = UILabel()
    private lazy var roomNameFormLabel = UILabel()
    private lazy var nutritionFormLabel = UILabel()
    
    // MARK: - Lifecycle:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupTrip(with model: Trip) {
        tripModel = model
    }
    
    // MARK: - Private Methods:
    private func setupTripInfo() {
        guard let tripModel else { return }
        
        departureFromFormLabel.text = tripModel.departure
        countryCityFormLabel.text = tripModel.arrivalCountry
        datesFormLabel.text = tripModel.tourDateStart + " – " + tripModel.tourDateStop
        numberOfNightsFormLabell.text = "\(tripModel.numberOfNights)" + L10n.ReservationScreen.numberOfNightsForm
        stackHotelNameFormLabell.text = tripModel.hotelName
        roomNameFormLabel.text = tripModel.room
        nutritionFormLabel.text = tripModel.nutrition
    }
}

// MARK: - Setup Views:
private extension CustomTripInfoStackView {
     func setupViews() {
        let leftSideLabels = [
            departureFromLabel, countryCityLabel, datesLabel, numberOfNightsLabell,
            stackHotelNameLabell, roomNameLabel, nutritionLabel]
        let rightSideLabels = [
            departureFromFormLabel, countryCityFormLabel, datesFormLabel, numberOfNightsFormLabell,
            stackHotelNameFormLabell, roomNameFormLabel, nutritionFormLabel]
         
         for index in 0..<leftSideLabels.count {
             let stackView = UIStackView()
             stackView.axis = .horizontal
             stackView.distribution = .fillEqually
             
             leftSideLabels[index].textColor = .universalGray
             leftSideLabels[index].font = .mediumBodyFont
             
             rightSideLabels[index].textColor = .universalBlackPrimary
             rightSideLabels[index].font = .mediumBodyFont
             rightSideLabels[index].numberOfLines = 0
             
             stackView.addArrangedSubview(leftSideLabels[index])
             stackView.addArrangedSubview(rightSideLabels[index])
             
             addArrangedSubview(stackView)
         }
    }
}
