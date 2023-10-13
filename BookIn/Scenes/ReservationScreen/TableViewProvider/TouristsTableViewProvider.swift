import Combine
import UIKit

final class TouristsTableViewProvider: NSObject {
    
    // MARK: - Dependencies:
    private var viewModel: ReservationViewModelProtocol? {
        didSet {
            tourists = viewModel?.getCurrentTouristMenu() ?? []
            bind()
        }
    }
    
    private var viewController: ReservationViewController?
    
    // MARK: - Constants and Variables:
    private(set) var tourists: [ExpandableTouristMenu] = []
    private var cancellable = Set<AnyCancellable>()
    
    private let headerViewHeight: CGFloat = 58
    private let cellHeight: CGFloat = 368
    
    // MARK: - Public Methods:
    func setupViewModel(from model: ReservationViewModelProtocol?) {
        viewModel = model
    }
    
    func setupHeaderViewDelegate(_ viewController: ReservationViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Private Methods:
    private func bind() {
        viewModel?.touristsPublisher
            .sink { [weak self] tourists in
                guard let self else { return }
                self.tourists = tourists
            }
            .store(in: &cancellable)
    }
}

// MARK: - UITableViewDataSource:
extension TouristsTableViewProvider: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tourists.count
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tourists[indexPath.section].status == .unwrapped {
            return cellHeight
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
        headerView.setupHeaderView(with: tourists[section].name,
                                   state: tourists[section].status,
                                   from: section)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        headerViewHeight
    }
}
