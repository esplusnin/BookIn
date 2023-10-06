import UIKit
import Kingfisher

final class CustomPresenterScrollView: UIScrollView {
    
    // MARK: - Constants and Variables:
    private var imagesURLs: [String]? {
        didSet {
            setupScrollView()
        }
    }
    
    // MARK: - UI:
    private lazy var pageControl = UIPageControl()
    
    // MARK: - Public Methods:
    func setupImagesURLs(with strings: [String]) {
        imagesURLs = strings
    }
    
    // MARK: - Private Methods:
    private func setupScrollView() {
        guard let imagesURLs,
              let superview else { return }
        setupViews()
        
        let viewWidth = Int(superview.frame.width)
        let sidesInsets = Int(UIConstants.sideInset * 2)
        
        contentSize = CGSize(width: CGFloat(viewWidth) * CGFloat(imagesURLs.count), height: bounds.height)

        for number in 0..<imagesURLs.count {
            let photoImageView = UIImageView(frame: CGRect(x: viewWidth * number + Int(UIConstants.sideInset),
                                                           y: 0,
                                                           width: viewWidth - sidesInsets,
                                                           height: Int(UIConstants.viewHeight)))
            addSubview(photoImageView)
            
            downloadPhotoImageView(with: imagesURLs[number], in: photoImageView)
        }
    }
    
    private func downloadPhotoImageView(with urlString: String, in imageView: UIImageView) {
        guard let url = URL(string: urlString) else { return }
        let processor = RoundCornerImageProcessor(cornerRadius: UIConstants.largeCornerRadius)
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, options: [.processor(processor), .transition(.fade(1)), .cacheOriginalImage])
        
        imageView.layer.cornerRadius = UIConstants.largeCornerRadius
        imageView.layer.masksToBounds = true
    }
}

// MARK: - Setup Views:
extension CustomPresenterScrollView {
    private func setupViews() {
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        
        backgroundColor = .universalWhite
    }
}
