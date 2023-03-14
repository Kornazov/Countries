
import Foundation

class APIClient {
    static let shared = APIClient()
    
    private lazy var concurrentQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "defaultQueue"
        return queue
    }()
    
    private func add(operation: Operation) {
        let queueToRun = concurrentQueue
        queueToRun.addOperation(operation)
    }
    
    func getCharacters(completion: @escaping (Result<Countries?, Error>) -> ()) {
        let operation = CountriesOperation()
        operation.completion = { result in
            completion(result)
        }
        add(operation: operation)
    }
}
