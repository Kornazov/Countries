import Foundation

class CountriesOperation: NetworkOperation<Countries> {
    var request: CountriesRequest
    
    override init() {
        request = CountriesRequest()
    }
    
    override func main() {
        networkService.requestData(with: request) { [weak self] result in
            self?.complete(with: result)
        }
    }
}
