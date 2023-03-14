
import Foundation

extension URLRequest {
    init?(apiRequest: APIRequest) {
        guard let finalUrl = URLComponents(baseUrl: apiRequest.baseURL,
                                           path: apiRequest.endpoint,
                                           parameters: apiRequest.urlParameters)?.url else {
            return nil
        }
        self.init(url: finalUrl, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        self.httpMethod = apiRequest.method.rawValue
        self.allHTTPHeaderFields = apiRequest.httpHeaders
    }
}
