
import Foundation

class BaseRequest: APIRequest {
    
    var httpBody: Data? {
        return nil
    }
    
    var baseURL: URL {
        guard let url = URL(string: NetworkConfig.baseURL) else {
            fatalError("Check API base url")
        }
        return url
    }
    
    var bodyParameters: [String : Any]? {
        return nil
    }
    
    var httpHeaders: [String : String]? {
        return nil
    }
    
    var urlParameters: [URLQueryItem] {
        //configuration needed
        return []
    }
    
    var endpoint: String? {
        //override in child class, if needed
        return nil
    }
    
    var method: HTTPMethod {
        //override in child class, if needed
        return .get
    }
}
