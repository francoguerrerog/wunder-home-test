import Foundation
import RxSwift

protocol GetPlaceMarks {
    func execute() -> Single<PlaceMarks>
}

class GetPlaceMarksDefault: GetPlaceMarks {
    private let placeMarksService: PlaceMarksService
    private let placeMarksRepository: PlaceMarksRepository
    
    init(_ placeMarksService: PlaceMarksService, _ placeMarksRepository: PlaceMarksRepository) {
        self.placeMarksService = placeMarksService
        self.placeMarksRepository = placeMarksRepository
    }
    
    func execute() -> Single<PlaceMarks> {
        return placeMarksService.find()
            .do(onSuccess: { (placeMarks) in
                self.placeMarksRepository.put(placeMarks)
            })
    }
}
