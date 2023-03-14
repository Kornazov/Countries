
import Foundation

class NetworkOperation<T: Decodable>: AsyncOperation {
    typealias NetworkOperationCompletion = (_ result: Result<T?, Error>) -> Void
    
    var completion: NetworkOperationCompletion?
    var networkService: NetworkService = NetworkService<T>()
    
    func complete(with result: Result<T?, Error>) {
        finish()
        
        if !isCancelled {
            completion?(result)
        }
    }
}
