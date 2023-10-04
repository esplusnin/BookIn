import UIKit

final class RoomViewController: UIViewController {
    
    // MARK: - Dependencies:
    private let coordinator: CoordinatorProtocol?
    
    // MARK: - UI:
    private lazy var roomsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RoomTableViewCell.self, forCellReuseIdentifier: Resources.Identifiers.roomTableViewCell)
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    private var customNavigationBar: CustomNavigationBar
    
    // MARK: - Lifecycle:
    init(coordinator: CoordinatorProtocol?, hotelName: String) {
        self.coordinator = coordinator
        self.customNavigationBar = CustomNavigationBar(coordinator: coordinator, title: hotelName, isBackButton: true)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

// MARK: - Setup Views:
private extension RoomViewController {
    func setupViews() {
        view.backgroundColor = .universalLightGray
        
        [customNavigationBar, roomsTableView].forEach(view.setupView)
        
        customNavigationBar.setupNavigationBar()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            roomsTableView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            roomsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            roomsTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            roomsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
