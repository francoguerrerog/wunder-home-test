import UIKit
import MapKit
import RxSwift

class CarMapViewController: UIViewController {
    
    private let viewModel: CarMapViewModel
    private lazy var mainView = CarMapView.initFromNib()
    
    private let disposeBag = DisposeBag()

    init(viewModel: CarMapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
            
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMapView()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    private func setupMapView() {
        mainView.mapView.delegate = self
    }

    private func bindViewModel() {
        bindPlaceMarks()
    }
    
    private func bindPlaceMarks() {
        viewModel.output.placeMarks
            .subscribe(onNext: { (placemarks) in
                self.setupAnnotations(placemarks)
            }).disposed(by: disposeBag)
    }
    
    private func setupAnnotations(_ placemarks: [PlaceMark]) {
        removeAllAnnotations()
        placemarks.forEach{ addAnnotation($0) }
    }
    
    private func removeAllAnnotations() {
        let allAnnotations = mainView.mapView.annotations
        mainView.mapView.removeAnnotations(allAnnotations)
    }
    
    private func addAnnotation(_ placeMark: PlaceMark) {
        let annotation = MKPointAnnotation()
        annotation.title = placeMark.name
        annotation.coordinate = CLLocationCoordinate2D(latitude: placeMark.coordinates.latitude, longitude: placeMark.coordinates.longitude)
        mainView.mapView.addAnnotation(annotation)
    }
}

extension CarMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
}
