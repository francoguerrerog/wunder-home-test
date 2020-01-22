import XCTest
import SwiftyMocky
import RxSwift
import RxTest

@testable import wunder_home_test

class CarMapViewModelTests: XCTestCase {
    
    private var viewModel: CarMapViewModel!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    private let placeMark = PlaceMark(address: "address", coordinates: Coordinate(latitude: 100, longitude: 100, elevation: 0), engineType: .CE, exterior: .GOOD, fuel: 100, interior: .GOOD, name: "name", vin: "vin")
    
    private var placeMarkObserver: TestableObserver<PlaceMark>!
    
    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        placeMarkObserver = scheduler.createObserver(PlaceMark.self)
    }
    
    func test_emitPlaceMarks() {
        givenAViewModel()
        
        viewModel.output.placeMark.subscribe(placeMarkObserver).disposed(by: disposeBag)
        whenViewDidLoad()
        
        thenEmitPlaceMark()
    }

    private func givenAViewModel() {
        viewModel = CarMapViewModel(placeMark)
    }
    
    private func whenViewDidLoad() {
        viewModel.viewDidLoad()
    }
    
    private func thenEmitPlaceMark() {
        let events = placeMarkObserver.events
        XCTAssertEqual(events.count, 1)
    }
}
