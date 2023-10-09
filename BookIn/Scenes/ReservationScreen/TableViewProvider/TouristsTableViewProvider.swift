import UIKit

final class TouristsTableViewProvider: NSObject {
    
    // MARK: - Constants and Variables:
    private let headerViewHeight: CGFloat = 58
    var viewController: ReservationViewController?
    var tourists = [
        ExpandableMenu(name: "Первый турист", status: .wrapped),
        ExpandableMenu(name: "Второй турист", status: .wrapped),
        ExpandableMenu(name: "Добавить туриста", status: .created)
    ]
}

// MARK: - UITableViewDataSource:
extension TouristsTableViewProvider: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        tourists.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Resources.Identifiers.touristsTableViewCell,
            for: indexPath) as? TouristsTableViewCell else { return UITableViewCell() }
        
        cell.isHidden = tourists[indexPath.section].status == .unwrapped ? false : true
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        headerViewHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tourists[indexPath.section].status == .unwrapped {
            return 430
        } else {
            return 0
        }
    }
}

// MARK: - UITableViewDelegate:
extension TouristsTableViewProvider: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: Resources.Identifiers.reservationTableView) as? ExpandableTableViewHeaderFooterView,
              let viewController else { return UIView() }

        headerView.delegate = viewController
        headerView.setupHeaderView(with: tourists[section].name, state: tourists[section].status, from: section)
        
        return headerView
    }
}
