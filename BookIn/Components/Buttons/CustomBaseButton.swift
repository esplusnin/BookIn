import UIKit

final class CustomBaseButton: UIButton {
    
    // MARK: - Constants and Variables:
    private let buttonHeight: CGFloat = 48
    
    // MARK: - Lifecycle:
    init(with text: String) {
        super.init(frame: .zero)
        setTitle(text, for: .normal)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods:
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        alpha = 0.9
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        transform = .identity
        alpha = 1
    }
}

// MARK: - Setup Views:
private extension CustomBaseButton {
    func setupViews() {
        layer.cornerRadius = UIConstants.largeCornerRadius
        backgroundColor = .universalBlue
        titleLabel?.textColor = .universalWhite
        titleLabel?.font = .smallTitleFont
    }
    
    func setupConstraints() {
        heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    }
}