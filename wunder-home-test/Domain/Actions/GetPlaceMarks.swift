import Foundation

protocol GetPlaceMarks {
    func execute() throws -> PlaceMarks
}

class GetPlaceMarksDefault: GetPlaceMarks {
    private let placeMarksRepository: PlaceMarksRepository
    
    init(_ placeMarksRepository: PlaceMarksRepository) {
        self.placeMarksRepository = placeMarksRepository
    }
    
    func execute() throws -> PlaceMarks {
        guard let placeMarks = placeMarksRepository.find() else {
            throw DomainError.placeMarksNotFound
        }
        return placeMarks
    }
}

