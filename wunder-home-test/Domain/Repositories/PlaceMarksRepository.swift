import Foundation

protocol PlaceMarksRepository {
    func put(_ placeMarks: PlaceMarks)
    func find() -> PlaceMarks?
}
