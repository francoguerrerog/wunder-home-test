
import UIKit

class CarListViewController: UIViewController {
    
    private let viewModel: CarListViewModel
    private lazy var mainView = CarListView.initFromNib()

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

        bindViewModel()
    }

    private func bindViewModel() {

    }
}
