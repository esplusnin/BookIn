import UIKit

final class HotelCollectionViewProvider: NSObject {
    var arrays = ["Бесплатный Wifi на всей территории отеля", "1 км до пляжа", "Бесплатный фитнес-клуб", "20 км до аэропорта"]
    var footerText = "Отель VIP-класса с собственными гольф полями. Высокий уровнь сервиса. Рекомендуем для респектабельного отдыха. Отель принимает гостей от 18 лет!"
}
    // MARK: - UICollectionViewDataSource:
extension HotelCollectionViewProvider: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Resources.Identifiers.hotelCollectionViewCell,
            for: indexPath) as? HotelCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setupTitleLabel(with: arrays[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var text: String?
        var id: String
        var isTitle = true
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            text = "Об отеле"
            id = Resources.Identifiers.hotelCollectionViewHeader
        case UICollectionView.elementKindSectionFooter:
            text = footerText
            id = Resources.Identifiers.hotelCollectionViewFooter
            isTitle = false
        default:
            id = ""
        }
        
        guard let reusableView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: id,
            for: indexPath) as? HotelCollectionViewReusableView else { return UICollectionReusableView() }
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
