import Foundation
import RxSwift

class CarListViewModel {
    
    struct Output {
        let placeMarks: Observable<[PlaceMark]>
        let loading: Observable<Bool>
    }
    
    public lazy var output = Output(placeMarks: placeMarksSubject.asObservable(), loading: loadingSubject.asObservable())
    
    private let placeMarksSubject = BehaviorSubject<[PlaceMark]>(value: [])
    private let loadingSubject = PublishSubject<Bool>()
    
    private let findPlaceMarks: FindPlaceMarksStatus
    private let coordinator: Coordinator
    
    private let disposeBag = DisposeBag()
    
    init(_ coordinator: Coordinator, _ findPlaceMarks: FindPlaceMarksStatus) {
        self.coordinator = coordinator
        self.findPlaceMarks = findPlaceMarks
    }
    
    private func placeMarkAtIndex(_ placeMarks: [PlaceMark], _ index: Int) -> PlaceMark? {
        if index >= 0 && index < placeMarks.count {
            return placeMarks[index]
        }
        return nil
    }
}

extension CarListViewModel {
    func viewDidLoad() {
        loadingSubject.onNext(true)
        findPlaceMarks.execute()
            .subscribe(onSuccess: { [weak self] (placeMarks) in
                self?.loadingSubject.onNext(false)
                self?.placeMarksSubject.onNext(placeMarks.placeMarks)
            }).disposed(by: disposeBag)
    }
    
    func selectCard(index: Int) {
        output.placeMarks
            .take(1)
            .subscribe(onNext: { (placeMarks) in
                guard let placeMark = self.placeMarkAtIndex(placeMarks, index) else { return }
                self.coordinator.goToCarMap(placeMark: placeMark)
            }).disposed(by: disposeBag)
    }
}
