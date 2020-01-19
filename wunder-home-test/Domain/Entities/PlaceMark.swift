import Foundation

struct PlaceMark {
    let address: String
    let coordinates: Coordinate
    let engineType: EngineType
    let exterior: Status
    let fuel: Int
    let interior: Status
    let name: String
    let vin: String
    
    enum Status: String {
        case GOOD
        case UNACCEPTABLE
    }
    
    enum EngineType: String {
        case CE
    }
}
