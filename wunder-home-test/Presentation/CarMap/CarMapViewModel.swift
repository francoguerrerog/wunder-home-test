import Foundation
import RxSwift

class CarMapViewModel {
    
    struct Output {
        let placeMark: Observable<PlaceMark>
    }
    
    public lazy var output = Output(placeMark: placeMarkSubject.asObservable())
    
    private let placeMarkSubject = PublishSubject<PlaceMark>()
    
    private let placeMark: PlaceMark
    
    init(_ placeMark: PlaceMark) {
        self.placeMark = placeMark
    }
    
    private func emitPlaceMark(_ placemark: PlaceMark) {
        placeMarkSubject.onNext(placemark)
    }
}

extension CarMapViewModel {
    func viewDidLoad() {
        emitPlaceMark(placeMark)
    }
}
