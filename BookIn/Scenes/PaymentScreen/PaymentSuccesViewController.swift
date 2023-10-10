import UIKit

final class PaymentSuccesViewController: UIViewController {
    
    // MARK: - Dependencies:
    private let coordinator: CoordinatorProtocol?
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let imageSide: CGFloat = 94
        static let labelSide: CGFloat = 42
        static let imageTopInset: CGFloat = 122
        static let orderLabelTopInset: CGFloat = 32
        static let descriptionInset: CGFloat = 20
        static let backgroundViewHeight: CGFloat = 88
        static let buttonTopAnchor: CGFloat = 12
    }
    
    // MARK: - UI:
    private lazy var succesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = LocalUIConstants.imageSide / 2
        imageView.backgroundColor = .universalViewBackground
        
        return imageView
    }()
    
    private lazy var orderInProcessLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .largeTitleFont
        label.textColor = .universalBlackPrimary
        label.text = L10n.PaymentSuccesScreen.orderApprove
        
        return label
    }()
    
    private lazy var orderDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .regularBodyFont
        label.textColor = .universalGray
        label.text = L10n.PaymentSuccesScreen.orderConfirm + generateRandomNumber() + L10n.PaymentSuccesScreen.orderText
        
        return label
    }()
    
    private lazy var succesEmojiLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: LocalUIConstants.labelSide, height: LocalUIConstants.labelSide))
        label.text = "🎉"
        label.font = .systemFont(ofSize: 42)
        
        return label
    }()
        
        private lazy var customNavigationBar = CustomNavigationBar(coordinator: coordinator, title: L10n.PaymentSuccesScreen.title, isBackButton: true)
        private lazy var completeButtonBackgroundView = CustomBackgroundView(isRounded: false)
        private lazy var completeButton = CustomBaseButton(with: L10n.PaymentSuccesScreen.completeButton)
        
        // MARK: - Lifecycle:
        init(coordinator: CoordinatorProtocol?) {
            self.coordinator = coordinator
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupViews()
            setupConstraints()
            setupTargets()
        }
        
        // MARK: - Private Methods:
        private func generateRandomNumber() -> String {
            let number = Int.random(in: 0...9999)
            return "№" + String(number)
        }
        
        // MARK: - Objc Methods:
        @objc private func startFromTheHotelScreen() {
            coordinator?.goToRootViewController()
        }
    }
    
    // MARK: - Setup Views:
    private extension PaymentSuccesViewController {
        func setupViews() {
            view.backgroundColor = .universalWhite
            
            [customNavigationBar, succesImageView, succesEmojiLabel, orderInProcessLabel, orderDescriptionLabel,
             completeButtonBackgroundView, completeButton].forEach(view.setupView)
            
            customNavigationBar.setupNavigationBar()
        }
        
        func setupConstraints() {
            setupSuccesImageViewConstraints()
            setupSuccesEmojiLabelConstraints()
            setupOrderInProcessLabelConstraints()
            setupOrderDescriptionLabelConstraints()
            setupCompleteButtonBackgroundView()
            setupCompleteButtonConstraints()
        }
        
        func setupSuccesImageViewConstraints() {
            NSLayoutConstraint.activate([
                succesImageView.heightAnchor.constraint(equalToConstant: LocalUIConstants.imageSide),
                succesImageView.widthAnchor.constraint(equalToConstant: LocalUIConstants.imageSide),
                succesImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                succesImageView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor, constant: LocalUIConstants.imageTopInset)
            ])
        }
        
        func setupSuccesEmojiLabelConstraints() {
            succesEmojiLabel.centerXAnchor.constraint(equalTo: succesImageView.centerXAnchor).isActive = true
            succesEmojiLabel.centerYAnchor.constraint(equalTo: succesImageView.centerYAnchor).isActive = true
        }
        
        func setupOrderInProcessLabelConstraints() {
            NSLayoutConstraint.activate([
                orderInProcessLabel.topAnchor.constraint(equalTo: succesImageView.bottomAnchor, constant: LocalUIConstants.orderLabelTopInset),
                orderInProcessLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
                orderInProcessLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset)
            ])
        }
        
        func setupOrderDescriptionLabelConstraints() {
            NSLayoutConstraint.activate([
                orderDescriptionLabel.topAnchor.constraint(equalTo: orderInProcessLabel.bottomAnchor, constant: LocalUIConstants.descriptionInset),
                orderDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LocalUIConstants.descriptionInset),
                orderDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LocalUIConstants.descriptionInset)
            ])
        }
        
        func setupCompleteButtonBackgroundView() {
            NSLayoutConstraint.activate([
                completeButtonBackgroundView.heightAnchor.constraint(equalToConstant: LocalUIConstants.backgroundViewHeight),
                completeButtonBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                completeButtonBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                completeButtonBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
        
        func setupCompleteButtonConstraints() {
            NSLayoutConstraint.activate([
                completeButton.topAnchor.constraint(equalTo: completeButtonBackgroundView.topAnchor, constant: LocalUIConstants.buttonTopAnchor),
                completeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
                completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset)
            ])
        }
    }
    
    // MARK: - Setup Targets:
    extension PaymentSuccesViewController {
        private func setupTargets() {
            completeButton.addTarget(self, action: #selector(startFromTheHotelScreen), for: .touchUpInside)
        }
    }
