import UIKit

final class HotelTableViewProvider: NSObject {
    
    // MARK: - Dependencies:
    private var viewModel: HotelViewModelProtocol?
    
    // MARK: - Constants and Variables:
    private let cellHeight: CGFloat = 70
    private let viewWidth: CGFloat = 400
    
    // MARK: - Public Methods:
    func setViewModel(from viewModel: HotelViewModelProtocol) {
        self.viewModel = viewModel
    }
}

// MARK: - UITableViewDataSource:
extension HotelTableViewProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.tableTitles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Resources.Identifiers.hotelTableViewCell, for: indexPath) as? HotelTableViewCell,
              let viewModel else { return UITableViewCell() }
        
        cell.setupCellInfo(with: viewModel.tableTitles[indexPath.row],
                           description: viewModel.descriptionText,
                           image: viewModel.tableViewImages[indexPath.row])
    
        if indexPath.row == viewModel.tableTitles.count - 1 {
            cell.separatorInset = UIEdgeInsets.init(
                top: 0, left: viewWidth,
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
