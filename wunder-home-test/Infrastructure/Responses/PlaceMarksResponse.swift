import Foundation

struct PlaceMarksResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case placeMarks = "placemarks"
    }
    
    let placeMarks: [PlaceMarkResponse]
    
    func toPlaceMarks() -> PlaceMarks {
        return PlaceMarks(placeMarks: placeMarks.compactMap{ $0.toPlaceMark() })
    }
}
