import UIKit

final class RoomTableViewCellCollectionViewProvider: NSObject {
    
    // MARK: - Constants and Variables:
    private var roomModel: Room?
    
    // MARK: - Public methods:
    func setupRoomModel(with model: Room) {
        roomModel = model
    }
}

// MARK: - UICollectionViewDataSource:
extension RoomTableViewCellCollectionViewProvider: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let roomModel {
            return roomModel.peculiarities.count + 1
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Resources.Identifiers.roomCollectionViewCell,
            for: indexPath) as? CustomCollectionViewCell,
        let roomModel else { return UICollectionViewCell() }
        let countOfCells = roomModel.peculiarities.count
        
        if indexPath.row == countOfCells {
            cell.setupLastCell()
        } else {
            let title = roomModel.peculiarities[indexPath.row]
            cell.setupTitleLabel(with: title)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let id: String
        let roomName = roomModel?.name ?? ""

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            id = Resources.Identifiers.roomCollectionViewHeader
        default:
            id = ""
        }

        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: id,
            for: indexPath) as? CustomCollectionViewReusableView else { return UICollectionReusableView() }

        headerView.setupLabel(with: roomName, isTitle: true)

        return headerView
    }
}

// MARK: - UICollectionViewDelegateFlowLayout:
extension RoomTableViewCellCollectionViewProvider: UICollectionViewDelegateFlowLayout {
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
}
