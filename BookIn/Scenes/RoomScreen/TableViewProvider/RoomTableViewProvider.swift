import UIKit

final class RoomTableViewProvider: NSObject {
    
    // MARK: - Dependencies:
    private var coordinator: CoordinatorProtocol?
    
    // MARK: - Constants and Variables:
    private var accomodation: Accomodation?
    
    private let cellHeight: CGFloat = 560
    
    // MARK: - Public Methods:
    func setupAccomodation(model: Accomodation) {
        accomodation = model
    }
    
    func setupCoordinator(from coordinator: CoordinatorProtocol?) {
        self.coordinator = coordinator
    }
}

// MARK: - UITableViewDataSource:
extension RoomTableViewProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        accomodation?.rooms.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Resources.Identifiers.roomTableViewCell,
            for: indexPath) as? RoomTableViewCell else { return UITableViewCell() }
        
        if let accomodation {
            cell.setupCoordinator(from: coordinator)
            cell.setupRoom(model: accomodation.rooms[indexPath.row])
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate:
extension RoomTableViewProvider: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight
    }
}
