import UIKit
import Kingfisher

final class CustomImagesPresenterView: UIView {
    
    // MARK: - Constants and Variables:
    private enum CustomUIConstants {
        static let scrollViewHeight: CGFloat = 257
        static let segmentControlHeight: CGFloat = 17
        static let segmentControlWidht: CGFloat = 75
    }
    
    private var imagesURLs: [String]? {
        didSet {
            setupPhotos()
        }
    }
    
    // MARK: - UI:
    private lazy var photosScrollView = UIScrollView()
    private lazy var pageControl = UIPageControl()
    
    // MARK: - Lifecycle:
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .universalWhite
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupImagesURLs(with strings: [String]) {
        imagesURLs = strings
    }
    
    // MARK: - Private Methods:
    private func setupPhotos() {
        guard let imagesURLs else { return }
        
        photosScrollView.contentSize = CGSize(width: frame.width * CGFloat(imagesURLs.count), height: CustomUIConstants.scrollViewHeight)
        
        for (index, imageURLString) in imagesURLs.enumerated() {
            let backgroundView = UIView()
            
            setupBackgroundView(backgroundView, in: photosScrollView, photoNumber: index, with: imageURLString)
            pageControl.numberOfPages = imagesURLs.count
        }
    }
    
    private func setupBackgroundView(_ view: UIView, in scrollView: UIScrollView, photoNumber: Int, with urlString: String) {
        scrollView.setupView(view)
        
        view.frame = CGRect(x: Int(bounds.width) * photoNumber,
                            y: 0,
                            width: Int(bounds.width),
                            height: Int(bounds.height))
        view.backgroundColor = .universalWhite
        
        let imageView = UIImageView()
        view.setupView(imageView)
        setupImageView(imageView, with: urlString)
    }
    
    private func setupImageView(_ view: UIImageView, with urlString: String) {
        guard let superview,
              let url = URL(string: urlString) else { return }
        
        view.layer.cornerRadius = UIConstants.largeCornerRadius
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.topAnchor),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: UIConstants.sideInset),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -UIConstants.sideInset)
        ])
        
        view.kf.indicatorType = .activity
        view.kf.setImage(with: url)
    }
}
