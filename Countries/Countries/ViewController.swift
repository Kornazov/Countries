import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var countriesTableView: UITableView!
    
    private var viewModel = CountriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.loadData()
        registerXib()
        setupView()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setupView() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.systemPink.cgColor, UIColor.systemBlue.cgColor]
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    private func setupTableView() {
        countriesTableView.dataSource = self
        countriesTableView.delegate = self
        countriesTableView.layer.cornerRadius = 10.0
        countriesTableView.backgroundColor = UIColor.clear.withAlphaComponent(0)
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: "CountriesTableViewCell", bundle: nil)
        countriesTableView.register(nibName, forCellReuseIdentifier: "countryCell")
    }
}

extension ViewController: CountriesViewModelDelegate {
    func reloadData() {
        self.countriesTableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filterCountries?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as? CountriesTableViewCell else { return UITableViewCell() }
        let index = indexPath.item
        let country = viewModel.filterCountries?[index]
        cell.countryLabel.text = country?.name
        cell.countryImage.downloadedsvg(from: URL(string: country!.flag)!)
        
        cell.backgroundColor = UIColor.clear.withAlphaComponent(0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = viewModel.filterCountries?[indexPath.item]
        guard let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else {
            return
        }
       secondViewController.country = country
       self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 20
        
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding / 2)
        cell.layer.mask = maskLayer
    }
}
