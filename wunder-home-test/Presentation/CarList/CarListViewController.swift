import UIKit
import RxCocoa
import RxSwift

class CarListViewController: UIViewController {
    
    private let viewModel: CarListViewModel
    private lazy var mainView = CarListView.initFromNib()
    
    private let disposeBag = DisposeBag()

    init(viewModel: CarListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
            
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNavBar()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    private func setupTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.register(UINib(nibName: ItemCellView.cellIdentifier, bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: ItemCellView.cellIdentifier)
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc private func addTapped(sender: UIButton) {
        viewModel.mapButtonTapped()
    }

    private func bindViewModel() {
        bindTableView()
    }
    
    private func bindTableView() {
        viewModel.output.placeMarks
            .observeOn(MainScheduler.instance)
            .bind(to: mainView.tableView.rx.items(cellIdentifier: ItemCellView.cellIdentifier, cellType: ItemCellView.self)) { [weak self] row, element, cell in
                self?.configureCell(cell, with: element)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureCell(_ cell: ItemCellView, with item: PlaceMark) {
        cell.titleLabel.text = item.name
        cell.subtitleLabel.text = item.address
    }
}

extension CarListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
