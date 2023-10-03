import UIKit

final class HotelTableViewProvider: NSObject {
    
    private let cellHeight: CGFloat = 60
    
    var tableTitles = ["Удобства", "Что включено", "Что не включено"]
    var images = [UIImage(named: "emoji-happy"), UIImage(named: "tick-square"), UIImage(named: "close-square")]
    var descriptionText = "Самое необходимое"
}

// MARK: - UITableViewDataSource:
extension HotelTableViewProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Resources.Identifiers.hotelTableViewCell, for: indexPath) as? HotelTableViewCell else { return UITableViewCell() }
        
        cell.setupCellInfo(with: tableTitles[indexPath.row], description: descriptionText, image: images[indexPath.row] ?? UIImage())
    
        if indexPath.row == tableTitles.count - 1 {
            cell.separatorInset = UIEdgeInsets.init(
                top: 0, left: 400,
                bottom: 0, right: 0)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate:
extension HotelTableViewProvider: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight
    }
}
