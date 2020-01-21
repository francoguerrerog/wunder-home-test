import XCTest
import SwiftyMocky
import RxSwift
import RxTest

@testable import wunder_home_test

class CarMapViewModelTests: XCTestCase {
    
    private let getPlaceMakrs = GetPlaceMarksMock()
    private var viewModel: CarMapViewModel!
    
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    private var placeMarksObserver: TestableObserver<[PlaceMark]>!
    
    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        placeMarksObserver = scheduler.createObserver([PlaceMark].self)
    }
    
    func test_getPlaceMarksWhenDidLoad() {
        givenAViewModel()
        
        whenViewDidLoad()
        
        thenGetPlaceMarks()
    }
    
    func test_emitPlaceMarks() {
        givenAViewModel()
        
        viewModel.output.placeMarks.subscribe(placeMarksObserver).disposed(by: disposeBag)
        whenViewDidLoad()
        
        thenEmitPlaceMarks()
    }

    private func givenAViewModel() {
        Given(getPlaceMakrs, .execute(willReturn: PlaceMarks(placeMarks: [])))
        viewModel = CarMapViewModel(getPlaceMakrs)
    }
    
    private func whenViewDidLoad() {
        viewModel.viewDidLoad()
    }
    
    private func thenGetPlaceMarks() {
        Verify(getPlaceMakrs, .once, .execute())
    }
    
    private func thenEmitPlaceMarks() {
        let events = placeMarksObserver.events
        XCTAssertEqual(events.count, 1)
    }
}
