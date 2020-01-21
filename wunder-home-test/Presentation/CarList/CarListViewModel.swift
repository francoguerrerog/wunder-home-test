import Foundation
import RxSwift

class CarListViewModel {
    
    struct Output {
        let placeMarks: Observable<[PlaceMark]>
    }
    
    public lazy var output = Output(placeMarks: placeMarksSubject.asObservable())
    
    private let placeMarksSubject = PublishSubject<[PlaceMark]>()
    
    private let findPlaceMarks: FindPlaceMarksStatus
    private let coordinator: Coordinator
    
    private let disposeBag = DisposeBag()
    
    init(_ coordinator: Coordinator, _ findPlaceMarks: FindPlaceMarksStatus) {
        self.coordinator = coordinator
        self.findPlaceMarks = findPlaceMarks
    }
}

extension CarListViewModel {
    func viewDidLoad() {
        findPlaceMarks.execute()
            .subscribe(onSuccess: { [weak self] (placeMarks) in
                self?.placeMarksSubject.onNext(placeMarks.placeMarks)
            }).disposed(by: disposeBag)
    }
    
    func mapButtonTapped() {
        coordinator.goToCarMap()
    }
}
