import UIKit

final class RoomTableViewProvider: NSObject {
    
    // MARK: - Constants and Variables:
    private var accomodation: Accomodation?
    
    private let cellHeight: CGFloat = 539
    
    // MARK: - Public Methods:
    func setupAccomodation(model: Accomodation) {
        accomodation = model
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
