import XCTest
import SwiftyMocky

@testable import wunder_home_test

class GetPlaceMarksTests: XCTestCase {
    
    private let placeMarksRepository = PlaceMarksRepositoryMock()
    private var getPlaceMarks: GetPlaceMarksDefault!
    private var result: PlaceMarks!
    
    func test_getPlaceMarks() {
        givenPlaceMarks()
        givenAnAction()
        
        whenExecute()
        
        thenRetreivePlaceMarks()
    }
    
    func test_errorWhenNoPlaceMarksAvailable() {
        givenNoPlaceMarks()
        givenAnAction()
        
        do {
            result = try getPlaceMarks.execute()
            XCTFail()
        } catch {
            Verify(placeMarksRepository, .once, .find())
        }
    }
    
    private func givenPlaceMarks() {
        Given(placeMarksRepository, .find(willReturn: PlaceMarks(placeMarks: [])))
    }
    
    private func givenNoPlaceMarks() {
        Given(placeMarksRepository, .find(willReturn: nil))
    }
    
    private func givenAnAction() {
        
        getPlaceMarks = GetPlaceMarksDefault(placeMarksRepository)
    }
    
    private func whenExecute() {
        result = try! getPlaceMarks.execute()
    }
    
    private func thenRetreivePlaceMarks() {
        Verify(placeMarksRepository, .once, .find())
    }
}

