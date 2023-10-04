import UIKit

final class HotelCollectionViewProvider: NSObject {
    
    // MARK: - Dependencies:
    private var viewModel: HotelViewModelProtocol?
    
    // MARK: - Public Methods:
    func setViewModel(from viewModel: HotelViewModelProtocol) {
        self.viewModel = viewModel
    }
}
    // MARK: - UICollectionViewDataSource:
extension HotelCollectionViewProvider: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.aboutTheHotel?.peculiarities.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Resources.Identifiers.hotelCollectionViewCell,
            for: indexPath) as? CustomCollectionViewCell,
              let viewModel else { return UICollectionViewCell() }
        
        if let peculiarities = viewModel.aboutTheHotel?.peculiarities {
            cell.setupTitleLabel(with: peculiarities[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var text: String?
        var id: String
        var isTitle = true
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            text = L10n.HotelScreen.aboutHotel
            id = Resources.Identifiers.hotelCollectionViewHeader
        case UICollectionView.elementKindSectionFooter:
            text = viewModel?.aboutTheHotel?.description
            id = Resources.Identifiers.hotelCollectionViewFooter
            isTitle = false
        default:
            id = ""
        }
        
        guard let reusableView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: id,
            for: indexPath) as? CustomCollectionViewReusableView else { return UICollectionReusableView() }
        reusableView.setupLabel(with: text ?? "", isTitle: isTitle)
        
        return reusableView
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HotelCollectionViewProvider: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView,
                                             viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
                                             at: indexPath)
        
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let footerView = self.collectionView(collectionView,
                                             viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionFooter,
                                             at: indexPath)
        
        return footerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
}
