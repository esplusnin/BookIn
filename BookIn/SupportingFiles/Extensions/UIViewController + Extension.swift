import UIKit

extension UIViewController {
    
    // MARK: - ActivityIndicatior and Blocking UI:
    private var activityIndicator: UIActivityIndicatorView? {
        view.subviews.first { $0 is UIActivityIndicatorView } as? UIActivityIndicatorView
    }
    
    private var blurVisualView: UIView? {
        view.subviews.first { $0 is UIVisualEffectView }
    }

    func blockUI() {
        view.isUserInteractionEnabled = false
        showActivityIndicator()
    }
    
    func unblockUI() {
        view.isUserInteractionEnabled = true
        hideActivityIndicator()
    }
    
    // Control UI state of loading:
    private func showActivityIndicator() {
        if activityIndicator == nil {
            setupBlur()
            setupActivityIndicator()
        } else {
            activityIndicator?.startAnimating()
        }
    }
    
    private func hideActivityIndicator() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self else { return }
            self.activityIndicator?.stopAnimating()
            self.activityIndicator?.removeFromSuperview()
            self.blurVisualView?.alpha = 0
        } completion: { [weak self] _ in
            guard let self else { return }
            blurVisualView?.removeFromSuperview()
        }
    }
    
    // Setup UI:
    private func setupBlur() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        view.setupView(blurEffectView)
       
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    private func setupActivityIndicator() {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .darkGray
        
        view.setupView(indicator)
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        indicator.startAnimating()
    }
}
