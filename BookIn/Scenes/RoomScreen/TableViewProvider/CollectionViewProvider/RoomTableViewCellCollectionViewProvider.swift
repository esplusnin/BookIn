import UIKit

final class RoomTableViewCellCollectionViewProvider: NSObject {
    
    // MARK: - Constants and Variables:
    private var roomModel: Room?
    
    // MARK: - Public methods:
    func setupRoomModel(with model: Room) {
        roomModel = model
    }
}

extension RoomTableViewCellCollectionViewProvider: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        roomModel?.peculiarities.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}
