import UIKit

final class CustomBaseButton: UIButton {
    
    // MARK: - Lifecycle:
    init(with text: String) {
        super.init(frame: .zero)
        setTitle(text, for: .normal)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views:
extension CustomBaseButton {
    private func setupViews() {
        layer.cornerRadius = UIConstants.largeCornerRadius
        backgroundColor = .universalBlue
        titleLabel?.textColor = .universalWhite
        titleLabel?.font = .smallTitleFont
    }
}
