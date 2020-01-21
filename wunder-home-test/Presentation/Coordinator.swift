import Foundation
import UIKit

protocol Coordinator {
    func goToCarList()
    func goToCarMap()
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
    
    private func createCarMapViewController() -> CarMapViewController {
        let viewModel = ViewModelFactory.createCarMapViewModel()
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
    
    func goToCarMap() {
        let viewController = createCarMapViewController()
        
        pushViewController(viewController: viewController)
    }
}

class ViewModelFactory {
    
    private static let placeMarksService = ApiPlaceMarksService()
    private static let placeMarksRepository = InMemoryPlaceMarksRepository()
        
    public static func createCarListViewModel(_ coordinator: Coordinator) -> CarListViewModel {
        let findPlacesMarks = FindPlaceMarksStatusDefault(placeMarksService, placeMarksRepository)
        return CarListViewModel(coordinator, findPlacesMarks)
    }
    
    public static func createCarMapViewModel() -> CarMapViewModel {
        let getPlaceMarks = GetPlaceMarksDefault(placeMarksRepository)
        return CarMapViewModel(getPlaceMarks)
    }
}
