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
        mainView.mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }

    private func bindViewModel() {
        bindPlaceMarks()
    }
    
    private func bindPlaceMarks() {
        viewModel.output.placeMark
            .subscribe(onNext: { (placemark) in
                self.setupAnnotation(placemark)
            }).disposed(by: disposeBag)
    }
    
    private func setupAnnotation(_ placeMark: PlaceMark) {
        removeAllAnnotations()
        addAnnotation(placeMark)
        setNavBarTitle(placeMark.name)
    }
    
    private func removeAllAnnotations() {
        let allAnnotations = mainView.mapView.annotations
        mainView.mapView.removeAnnotations(allAnnotations)
    }
    
    private func addAnnotation(_ placeMark: PlaceMark) {
        let annotationCoordinate = CLLocationCoordinate2D(latitude: placeMark.coordinates.latitude, longitude: placeMark.coordinates.longitude)
        let annotation = PlaceMarkAnnotation(coordinate: annotationCoordinate, title: placeMark.name, subtitle: placeMark.address)
        mainView.mapView.addAnnotation(annotation)
        mainView.mapView.setRegion(annotation.region, animated: true)
    }
    
    private func setNavBarTitle(_ title: String) {
        self.title = title
    }
}

extension CarMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let placeMarkAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
            placeMarkAnnotation.animatesWhenAdded = true
            placeMarkAnnotation.titleVisibility = .adaptive
            placeMarkAnnotation.subtitleVisibility = .adaptive
        }
        
        return nil
    }
}
