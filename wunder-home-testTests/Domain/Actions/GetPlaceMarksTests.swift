import XCTest
import RxSwift
import RxBlocking
import SwiftyMocky

@testable import wunder_home_test

class GetPlaceMarksTests: XCTestCase {
    
    private let placeMarksService = PlaceMarksServiceMock()
    private let placeMarkRepository = PlaceMarksRepositoryMock()
    private var getPlaceMarks: GetPlaceMarksDefault!
    private var result: MaterializedSequenceResult<PlaceMarks>!
    
    func test_getPlaceMarks() {
        givenAnAction()
        
        whenExecute()
        
        thenRetreivePlaceMarks()
    }
    
    func test_savePlaceMarks() {
        givenAnAction()
        
        whenExecute()
        
        thenSavePlaceMarks()
    }
    
    private func givenAnAction() {
        Given(placeMarksService, .find(willReturn: .just(PlaceMarks(placeMarks: []))))
        getPlaceMarks = GetPlaceMarksDefault(placeMarksService, placeMarkRepository)
    }
    
    private func whenExecute() {
        result = getPlaceMarks.execute().toBlocking().materialize()
    }
    
    private func thenRetreivePlaceMarks() {
        switch result {
        case .completed:
            Verify(placeMarksService, .once, .find())
        default:
            XCTFail()
        }
    }
    
    private func thenSavePlaceMarks() {
        switch result {
        case .completed:
            Verify(placeMarkRepository, .once, .put(.any))
        default:
            XCTFail()
        }
    }
}
