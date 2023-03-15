import CoreLocation
import MapKit
import UIKit

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    var country: CountriesResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        setupNavigationBar()
        configureAnnotation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            self?.showDetailScreen()
        }
    }
    
    
    private func setupNavigationBar() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 55))
        let imageView = UIImageView(frame: CGRect(x: 4, y: 10, width: 16, height: 16))
        
        if let imgBackArrow = UIImage(named: "backArrow") {
            imageView.image = imgBackArrow
        }
        view.addSubview(imageView)
        let backTap = UITapGestureRecognizer(target: self, action: #selector(backToMain))
        view.addGestureRecognizer(backTap)
        let leftBarButtonItem = UIBarButtonItem(customView: view)
        self.navigationController?.navigationBar.backgroundColor = .clear
        
        let label = UILabel()
        label.text = country?.name
        label.font = .systemFont(ofSize: 22)
        self.navigationItem.titleView = label
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc func backToMain() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureAnnotation() {
        guard let country = self.country,
              let latitude = country.latLng.first,
              let longitude = country.latLng.last else { return }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title =  country.capitalName
        self.mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }
    
    private func showDetailScreen() {
        let vc = CustomModalViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.country = country
        self.present(vc, animated: false)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        showDetailScreen()
    }
}
