import Foundation
import RxSwift

protocol PlaceMarksService {
    func find() -> Single<PlaceMarks>
}
