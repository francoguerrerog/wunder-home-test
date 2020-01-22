import Foundation
import UIKit

protocol Coordinator {
    func goToCarList()
    func goToCarMap(placeMark: PlaceMark)
}

class CoordinatorDefault {
    private let window: UIWindow

    private var viewNavigation: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewController = createCarListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        viewNavigation = navigationController
    }
    
    private func createCarListViewController() -> CarListViewController {
        let viewModel = ViewModelFactory.createCarListViewModel(self)
        return CarListViewController(viewModel: viewModel)
    }
    
    private func createCarMapViewController(_ placeMark: PlaceMark) -> CarMapViewController {
        let viewModel = CarMapViewModel(placeMark)
        return CarMapViewController(viewModel: viewModel)
        
    }
    
    private func pushViewController(viewController: UIViewController) {
        guard let navigation = viewNavigation else { return }
        navigation.pushViewController(viewController, animated: true)
    }
}

extension CoordinatorDefault: Coordinator {
    func goToCarList() {
        let viewController = createCarListViewController()
        
        pushViewController(viewController: viewController)
    }
    
    func goToCarMap(placeMark: PlaceMark) {
        let viewController = createCarMapViewController(placeMark)
        
        pushViewController(viewController: viewController)
    }
}
