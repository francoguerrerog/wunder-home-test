import Foundation

struct PlaceMarkResponse: Codable {
    let address: String
    let coordinates: [Double]
    let engineType: String
    let exterior: String
    let fuel: Int
    let interior: String
    let name: String
    let vin: String
    
    func toPlaceMark() -> PlaceMark? {
        guard let exteriorStatus = PlaceMark.Status(rawValue: exterior) else { return nil }
        guard let interiorStatus = PlaceMark.Status(rawValue: interior) else { return nil }
        guard coordinates.count == 3 else { return nil }
        let coordinate = Coordinate(latitude: coordinates[1], longitude: coordinates[0], elevation: coordinates[2])
        guard let engineTypeStatus = PlaceMark.EngineType(rawValue: engineType) else { return nil }
        
        return PlaceMark(address: address,
                         coordinates: coordinate,
                         engineType: engineTypeStatus,
                         exterior: exteriorStatus,
                         fuel: fuel,
                         interior: interiorStatus,
                         name: name,
                         vin: vin)
    }
}
