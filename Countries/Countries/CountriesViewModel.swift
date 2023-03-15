
import Foundation
import UIKit

protocol CountriesViewModelDelegate: AnyObject {
    func reloadData()
}

class CountriesViewModel {
    
    weak var delegate: CountriesViewModelDelegate?
    private var shouldSortAndReloadDataAfterProperSearch = false
    var countries: Countries? {
        didSet {
            filterCountries = countries
        }
    }
    var searchString: String? {
        didSet {
            filterData()
        }
    }
    
    var filterCountries: Countries?
    
    func loadData() {
        APIClient.shared.getCharacters { [weak self] result in
            switch result {
            case .success(let response):
                self?.countries = response?.sorted { $0.population > $1.population }
                self?.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func filterData() {
        if let searchString = searchString, searchString.count > 2 {
            let searchedCountries = countries?.filter({ ($0.name.lowercased().contains(searchString))})
            filterCountries = searchedCountries
            delegate?.reloadData()
            return
        }
        filterCountries = countries
        delegate?.reloadData()
    }
}

