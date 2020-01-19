import Foundation
import RxSwift

class MainViewModel {
    
    private let disposeBag = DisposeBag()

    private let apiService: PlaceMarksService
    init(apiService: PlaceMarksService) {
        self.apiService = apiService
    }
}

extension MainViewModel {
    func viewDidLoad() {
        apiService.find()
            .subscribe(onSuccess: { (placeMarks) in
                print(placeMarks)
            }).disposed(by: disposeBag)
    }
}
