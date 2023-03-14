import CoreLocation
import MapKit
import UIKit

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    var country: CountriesResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let country = self.country else { return }
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: country.latLng.first!, longitude: country.latLng.last!)
        annotation1.title =  country.capitalName
        self.mapView.addAnnotation(annotation1)
        mapView.delegate = self
        
        let region = MKCoordinateRegion(center: annotation1.coordinate, latitudinalMeters: 100000, longitudinalMeters: 100000)
        mapView.setRegion(region, animated: true)
        
        let vc = CustomModalViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.country = country
        // keep false
        // modal animation will be handled in VC itself
        self.present(vc, animated: false)
    }
    

}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let vc = CustomModalViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.country = country
        // keep false
        // modal animation will be handled in VC itself
        self.present(vc, animated: false)
        print("didSelectAnnotationTapped")
    }
}
