import Foundation
import RxSwift

class CarMapViewModel {
    
    struct Output {
        let placeMarks: Observable<[PlaceMark]>
    }
    
    public lazy var output = Output(placeMarks: placeMarksSubject.asObservable())
    
    private let placeMarksSubject = PublishSubject<[PlaceMark]>()
    
    private let getPlaceMarks: GetPlaceMarks
    
    init(_ getPlaceMarks: GetPlaceMarks) {
        self.getPlaceMarks = getPlaceMarks
    }
    
    private func emitPlaceMarks(_ placemarks: PlaceMarks) {
        placeMarksSubject.onNext(placemarks.placeMarks)
    }
}

extension CarMapViewModel {
    func viewDidLoad() {
        do {
            let placeMarks = try getPlaceMarks.execute()
            emitPlaceMarks(placeMarks)
        } catch  {
            //TODO: handle the error
        }
    }
}
