
import Foundation
import UIKit

protocol CountriesViewModelDelegate: AnyObject {
    func reloadData()
}

class CountriesViewModel {
    
    weak var delegate: CountriesViewModelDelegate?
    var countries: Countries? {
        didSet {
            filterCountries = countries?.sorted { $0.population > $1.population }
        }
    }
    var searchString: String? {
        didSet {
            filterData()
        }
    }
    var numberForSeason: Int? {
        didSet {
            filterData()
        }
    }
    
    var filterCountries: Countries?
    
    func loadData() {
        APIClient.shared.getCharacters { [weak self] result in
            switch result {
            case .success(let response):
                print(response)
                self?.countries = response
                self?.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadDataTest(completion: @escaping(Result<Countries?, Error>) -> Void) {
        APIClient.shared.getCharacters { [weak self] result in
            switch result {
            case .success(let response):
                self?.countries = response
                self?.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
           // completion(result)
        }
    }
    
    func showAllCharacters() {
        numberForSeason = nil
        filterCountries = countries
    }
    
    func filterData() {
        if let searchString = searchString, let season = numberForSeason {
          //  filterCountries = countries?.filter({ ( $0.appearance?.contains(season) ?? false) && ($0.name?.lowercased().contains(searchString) ?? false) })
            delegate?.reloadData()
            return
        }
        
        if let searchString = searchString {
            filterCountries = countries?.filter({ ($0.name.lowercased().contains(searchString) ?? false)})
            delegate?.reloadData()
            return
        }
        
        filterCountries = countries
        delegate?.reloadData()
    }
}

