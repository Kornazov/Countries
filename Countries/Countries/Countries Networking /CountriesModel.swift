
import Foundation

struct CountriesResponse: Codable {
    let capitalName: String
    let code: String
    let flag: String
    let latLng: [Double]
    let name: String
    let population: Int
    let region: Region
    let subregion: String
}

enum Region: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case antarctic = "Antarctic"
    case antarcticOcean = "Antarctic Ocean"
    case asia = "Asia"
    case europe = "Europe"
    case oceania = "Oceania"
    case polar = "Polar"
}

typealias Countries = [CountriesResponse]
