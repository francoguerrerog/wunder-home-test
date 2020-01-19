import Foundation

class InMemoryPlaceMarksRepository: PlaceMarksRepository {
    
    private var placeMarks: PlaceMarks?
    
    func put(_ placeMarks: PlaceMarks) {
        self.placeMarks = placeMarks
    }
    
    func find() -> PlaceMarks? {
        return placeMarks
    }
}
