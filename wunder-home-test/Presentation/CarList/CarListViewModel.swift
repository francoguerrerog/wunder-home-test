import Foundation
import RxSwift

class CarListViewModel {
    
    struct Output {
        let placeMarks: Observable<PlaceMarks>
    }
    
    public lazy var output = Output(placeMarks: placeMarksSubject.asObservable())
    
    private let placeMarksSubject = PublishSubject<PlaceMarks>()
    
    private let findPlaceMarks: FindPlaceMarksStatus
    
    private let disposeBag = DisposeBag()
    
    init(_ findPlaceMarks: FindPlaceMarksStatus) {
        self.findPlaceMarks = findPlaceMarks
    }
}

extension CarListViewModel {
    func viewDidLoad() {
        findPlaceMarks.execute()
            .subscribe(onSuccess: { [weak self] (placeMarks) in
                self?.placeMarksSubject.onNext(placeMarks)
            }).disposed(by: disposeBag)
    }
}
