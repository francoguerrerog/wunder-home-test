import Foundation
import UIKit

protocol Coordinator {
    func goToCarList()
    func goToCarListMap()
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
        let placeMarksService = ApiPlaceMarksService()
        let placeMarksRepository = InMemoryPlaceMarksRepository()
        let findPlacesMarks = FindPlaceMarksStatusDefault(placeMarksService, placeMarksRepository)
        let viewModel = CarListViewModel(findPlacesMarks)
        return CarListViewController(viewModel: viewModel)
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
    
    func goToCarListMap() {
        
    }
}
