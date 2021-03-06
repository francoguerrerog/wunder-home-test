import XCTest
import SwiftyMocky
import RxSwift
import RxTest

@testable import wunder_home_test

class CarListViewModelTests: XCTestCase {
    
    private let findPlaceMarks = FindPlaceMarksStatusMock()
    private let coordinator = CoordinatorMock()
    private var viewModel: CarListViewModel!
    
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    private var placeMarksObserver: TestableObserver<[PlaceMark]>!
    
    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        placeMarksObserver = scheduler.createObserver([PlaceMark].self)
    }

    func test_findPlaceMarksWhenDidLoad() {
        givenAViewModel()
        
        whenViewDidLoad()
        
        thenFindPlaceMarks()
    }
    
    func test_emitPlaceMarks() {
        givenAViewModel()
        
        viewModel.output.placeMarks.subscribe(placeMarksObserver).disposed(by: disposeBag)
        whenViewDidLoad()
        
        thenEmitPlaceMarks()
    }
    
    private func givenAViewModel() {
        Given(findPlaceMarks, .execute(willReturn: .just(PlaceMarks(placeMarks: []))))
        viewModel = CarListViewModel(coordinator, findPlaceMarks)
    }
    
    private func whenViewDidLoad() {
        viewModel.viewDidLoad()
    }
    
    private func thenFindPlaceMarks() {
        Verify(findPlaceMarks, .once, .execute())
    }
    
    private func thenEmitPlaceMarks() {
        let events = placeMarksObserver.events
        XCTAssertEqual(events.count, 2)
    }
}
