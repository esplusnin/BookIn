import Combine
import UIKit

final class RoomViewController: UIViewController {
    
    // MARK: - Dependencies:
    private let coordinator: CoordinatorProtocol?
    private let viewModel: RoomViewModelProtocol
    
    // MARK: - Classes:
    private let roomTableViewProvider = RoomTableViewProvider()
    
    // MARK: - Constants and Variables:
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - UI:
    private lazy var roomsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RoomTableViewCell.self, forCellReuseIdentifier: Resources.Identifiers.roomTableViewCell)
        tableView.dataSource = roomTableViewProvider
        tableView.delegate = roomTableViewProvider
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    private var customNavigationBar: CustomNavigationBar
    
    // MARK: - Lifecycle:
    init(coordinator: CoordinatorProtocol?, viewModel: RoomViewModelProtocol, hotelName: String) {
        self.coordinator = coordinator
        self.viewModel = viewModel
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
        
        blockUI()
        bind()
        viewModel.getAccomodationData()
    }
    
    // MARK: - Private Methods:
    private func bind() {
        viewModel.accomodationPublisher
            .sink { [weak self] accomodation in
                guard let self,
                      let accomodation else { return }
                self.updateRoomsInfo(with: accomodation)
            }
            .store(in: &cancellable)
    }
    
    private func updateRoomsInfo(with model: Accomodation) {
        DispatchQueue.main.async {
            self.roomTableViewProvider.setupAccomodation(model: model)
            self.roomTableViewProvider.setupCoordinator(from: self.coordinator)
            self.roomsTableView.reloadData()
            self.unblockUI()
        }
    }
}

// MARK: - Setup Views:
private extension RoomViewController {
    func setupViews() {
        view.backgroundColor = .universalViewBackground
        
        [customNavigationBar, roomsTableView].forEach(view.setupView)
        
        customNavigationBar.setupNavigationBar()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            roomsTableView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            roomsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            roomsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            roomsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
