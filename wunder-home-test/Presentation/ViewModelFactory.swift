import Foundation

class ViewModelFactory {
    
    private static let placeMarksService = ApiPlaceMarksService()
    private static let placeMarksRepository = InMemoryPlaceMarksRepository()
        
    public static func createCarListViewModel(_ coordinator: Coordinator) -> CarListViewModel {
        let findPlacesMarks = FindPlaceMarksStatusDefault(placeMarksService, placeMarksRepository)
        return CarListViewModel(coordinator, findPlacesMarks)
    }
}
