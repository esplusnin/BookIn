import UIKit

final class CustomBackgroundView: UIView {
    
    // MARK: - Lifecycle:
    init(isRounded: Bool) {
        super.init(frame: .zero)
        self.setupViews(isRounded: isRounded)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views:
extension CustomBackgroundView {
    private func setupViews(isRounded: Bool) {
        if isRounded {
            layer.cornerRadius = UIConstants.backgroundViewCornerRadius
        } else {
            layer.cornerRadius = UIConstants.backgroundViewCornerRadius
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        
        backgroundColor = .universalWhite
    }
}
