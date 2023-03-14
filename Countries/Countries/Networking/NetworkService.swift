
import Foundation

enum NetworkServiceError: Error, LocalizedError {
    case badUrl
    case badResponse
    case requestFailed(statusCode: Int)
    case requestFailure(message: String)
    case internalStatusCodeMissing
    case parsingFailed
    
    var errorDescription: String? {
        switch self {
        case .badUrl:
            return "Could not produce request url."
        case .badResponse:
            return "Bad response."
        case .internalStatusCodeMissing:
            return "Request failed"
        case .requestFailed(statusCode: let statusCode):
            return "Request failed \(statusCode)"
        case .requestFailure(message: let message):
            return "\(message)"
        case .parsingFailed:
            return "Could not parse JSON into expected type."
        }
    }
}

class NetworkService<T: Decodable> {
    var session: URLSession = .shared
    
    func requestData(with request: APIRequest,
                     completion: @escaping (Result<T?, Error>) -> ()) {
        
        guard let urlRequest = URLRequest(apiRequest: request) else {
            completion(.failure(NetworkServiceError.badUrl))
            return
        }
        scheduleTask(with: urlRequest) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            case .success(let data):
                if let unwrappedData = data,
                   let parsedData = try? JSONDecoder().decode(T.self, from: unwrappedData) {
                    DispatchQueue.main.async {
                        completion(.success(parsedData))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkServiceError.parsingFailed))
                    }
                }
            }
        }
    }
}

private extension NetworkService {
    func scheduleTask(with request: URLRequest,
                      completion: @escaping(Result<Data?, Error>) -> ()) {
        session.dataTask(with: request,completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkServiceError.badResponse))
                return
            }
            
            if self.isRequestFailure(statusCode: response.statusCode) {
                completion(.failure(NetworkServiceError.requestFailed(statusCode: response.statusCode)))
            } else if self.isRequestSuccess(statusCode: response.statusCode) {
                completion(.success(data))
            }
        }).resume()
    }
}

private extension NetworkService {
    func isInternalStatusSuccess(statusCode: Int) -> Bool {
        return statusCode == 200
    }
    
    func isRequestSuccess(statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode <= 299
    }
    
    func isRequestFailure(statusCode: Int) -> Bool {
        return statusCode >= 400 && statusCode <= 599
    }
}
