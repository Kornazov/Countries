
import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol APIRequest {
    var baseURL: URL { get }
    
    var endpoint: String? { get }
    var method: HTTPMethod { get }
    
    var urlParameters: [URLQueryItem] { get }
    var bodyParameters: [String: Any]? { get }
    var httpHeaders: [String: String]? { get }
    
    var httpBody: Data? { get }
}
