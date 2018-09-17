//
//  MapViewVC.swift
//  Restaurant
//
//  Created by Mike Milord on 05/08/2018.
//  Copyright © 2018 First Republic. All rights reserved.
//

import UIKit
import MapKit

class MapViewVC: UIViewController {
    
    @IBOutlet weak var restoMapView: MKMapView!
    
    private let locationManager = CLLocationManager()
    private var currentCoordinate: CLLocationCoordinate2D?
    
    // foaling button
    var verticalFloatingButtonConstraint: NSLayoutConstraint?
    
    //*** Part for the cells ***/
    
    @IBOutlet var presentingView: UIView!
    @IBOutlet weak var restosCollection: UICollectionView!
    
    fileprivate var heightViewConstraint = NSLayoutConstraint()
    
    lazy var layoutItemCell : UICollectionViewFlowLayout? = {
        return self.restosCollection?.collectionViewLayout as! UICollectionViewFlowLayout?
    }()
    let restoCell = "smallRestoCell"
    
    
    var restos: [Post] = [Post]()
    
    
    /**** END ****************/
    
    let conf = UXConfigure()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        restoMapView.delegate = self
        restosCollection.delegate = self
        restosCollection.dataSource = self

        addFloatingButton()
        
        configureLocationServices()
        
        registerCell()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        //make the button round
        
        
    }
    
    
    private func configureLocationServices() {
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: locationManager)
            
        }
    }
    
    private func beginLocationUpdates(locationManager: CLLocationManager) {
        restoMapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    private func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
        let zoomRegion = MKCoordinateRegionMakeWithDistance(coordinate, 1500, 1500)
        restoMapView.setRegion(zoomRegion, animated: true)
    }
    
    
    
    




}


// add Floating Button
extension MapViewVC {
    
    fileprivate func addFloatingButton()  {
        
        let yValue = view.frame.height * 0.4
        
        let floatingBtn = UIButton()
        floatingBtn.backgroundColor = .white
        floatingBtn.setTitle("List", for: .normal)
        floatingBtn.setTitleColor(UIColor(red: 153, green: 175, blue: 142, alpha: 1.0), for: .normal)
        floatingBtn.clipsToBounds = true
        floatingBtn.addTarget(self, action: #selector(floatingBtnPressed), for: .touchDown)
        floatingBtn.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(floatingBtn)
        
        if #available(iOS 9.0, *) {
            verticalFloatingButtonConstraint = floatingBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yValue)
            verticalFloatingButtonConstraint?.isActive = true
            floatingBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            floatingBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
            floatingBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
        }
        
        
    }
    
    
    @objc fileprivate func floatingBtnPressed()  {
        
        //print("Hello, I have been pressed")
        self.dismiss(animated: true, completion: nil)
        
    }
}


extension MapViewVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print("Did get latest location")
        
        guard let latestLocation = locations.first else { return }
        
        if currentCoordinate == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
           
        }
        
        currentCoordinate = latestLocation.coordinate
         addAnnotations()
        //print("Latest coordinate: \(String(describing: currentCoordinate))")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //print("The status changed")
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: manager)
        }
    }
    
    
    // Anotations
    private func addAnnotations() {
        
        // Sample coordinates
        let restoItLatitude = (currentCoordinate?.latitude)! + 0.02
        let restoItLongitude = (currentCoordinate?.longitude)! + 0.06
        
        let restoCrLatitude = (currentCoordinate?.latitude)! + 0.031
        let restoCrLongitude = (currentCoordinate?.longitude)! + 0.096
        
        print("current coordinate latitude: \(String(describing: currentCoordinate?.latitude))")
        print("current coordinate longitude: \(String(describing: currentCoordinate?.longitude))")
        
        let restoItalianAnnotation = MKPointAnnotation()
        restoItalianAnnotation.title = "Pastamore"
        restoItalianAnnotation.coordinate = CLLocationCoordinate2D(latitude: restoItLatitude, longitude: restoItLongitude)
        
        let restoCreoleAnnotation = MKPointAnnotation()
        restoCreoleAnnotation.title = "Muss & Turners - Smyrna"
        restoCreoleAnnotation.coordinate = CLLocationCoordinate2D(latitude:  restoCrLatitude , longitude: restoCrLongitude)
        
        let restoFrenchAnnotation = MKPointAnnotation()
        restoFrenchAnnotation.title = "A l'Endroit"
        restoFrenchAnnotation.coordinate = CLLocationCoordinate2D(latitude:    48.801400000000001 , longitude: 2.13241000000000001)
        
        let restoSpanishAnnotation = MKPointAnnotation()
        restoSpanishAnnotation.title = "La Pirada"
        restoSpanishAnnotation.coordinate = CLLocationCoordinate2D(latitude:    48.801400000000001 , longitude: 2.12141000000000001)
        
        let restoIndianAnnotation = MKPointAnnotation()
        restoIndianAnnotation.title = "Le Maharajah"
        restoIndianAnnotation.coordinate = CLLocationCoordinate2D(latitude:    48.801400000000001 , longitude: 2.12941000000000001)
        
        restoMapView.addAnnotation(restoItalianAnnotation)
        restoMapView.addAnnotation(restoCreoleAnnotation)
        restoMapView.addAnnotation(restoFrenchAnnotation)
        restoMapView.addAnnotation(restoSpanishAnnotation)
        restoMapView.addAnnotation(restoIndianAnnotation)
    }
}



extension MapViewVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //print("delegate here is working. ...")
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        
        if let title = annotation.title, title == "Pastamore"
            || title == "Muss & Turners - Smyrna"
            || title == "A l'Endroit"
            || title == "La Pirada"
            || title == "Le Maharajah"{
            annotationView?.image = UIImage(named: "resto")
        } else if annotation === mapView.userLocation {
            annotationView?.image = UIImage(named: "user")
        }
        
        annotationView?.canShowCallout = true
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("The annotation was selected: \(String(describing: view.annotation?.title))")

        presentingCollectionViews()
    }
}


extension MapViewVC {
    
    /**** Register and set views **/
    
    fileprivate func registerCell(){
        
        let nib = UINib(nibName: "RestoSmallCell", bundle: nil)
        restosCollection.register(nib, forCellWithReuseIdentifier: restoCell)
        
        
        if let flowLayout = self.layoutItemCell  {
            
            let width = view.frame.width * (2 / 3)
            let height: CGFloat = width * 1.2
            
            flowLayout.itemSize = CGSize(width: width , height: height)
        }
        self.layoutItemCell?.minimumInteritemSpacing = 0
        
        addViews()
        
    }
    
    
    /*** Add view and animation ***/
    
    /** *********** ADD FILTER VIEW ****************** */
    
    fileprivate func presentingCollectionViews(){
        let height = view.frame.height / 2
        animateGrowView(height: height)
    }
    
    fileprivate func addViews(){
        view.insertSubview(self.presentingView, aboveSubview: restoMapView)
        self.presentingView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //Let put the constraint for the view
        
        heightViewConstraint.constant = 0.0
        
        // add constraint for address and payment
        addConstraintToViews(viewItem: self.presentingView, forContainerView: view)
        
        
    }
    
    
    fileprivate func addConstraintToViews(viewItem: UIView, forContainerView view: UIView){
        
        
        let bottomConstraint = NSLayoutConstraint(item: viewItem, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: viewItem, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: viewItem, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        heightViewConstraint = NSLayoutConstraint(item: viewItem, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([bottomConstraint, leadingConstraint, trailingConstraint, heightViewConstraint])
        
    }
    
    
    fileprivate func animateGrowView(height: CGFloat){
        //print("is called")
        
        heightViewConstraint.constant = height
        
        //print("***** frame: \(filterView.frame)")
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
 
 
}

extension MapViewVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: restoCell, for: indexPath) as? RestoSmallCell else {
            return UICollectionViewCell()
        }
        
        cell.post = restos[indexPath.row]
        conf.addCornerShadow(forCell: cell)
        return cell
        
    }
    
}

extension MapViewVC: UICollectionViewDelegate {
    
}
