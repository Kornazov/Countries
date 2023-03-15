
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
    case Africa = "Africa"
    case Americas = "Americas"
    case Antarctic = "Antarctic"
    case AntarcticOcean = "Antarctic Ocean"
    case Asia = "Asia"
    case Europe = "Europe"
    case Oceania = "Oceania"
    case Polar = "Polar"
}

typealias Countries = [CountriesResponse]
