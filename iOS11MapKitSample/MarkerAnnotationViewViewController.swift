//
//  MarkerAnnotationViewViewController.swift
//  iOS11MapKitSample
//
//  Created by hiraya.shingo on 2017/07/14.
//  Copyright © 2017年 Shingo Hiraya. All rights reserved.
//

import UIKit
import MapKit

class MarkerAnnotationViewViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepare()
    }
}

extension MarkerAnnotationViewViewController {
    func prepare() {
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.65858, longitude: 139.745433),
                                            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        mapView.delegate = self
        
        mapView.register(MKMarkerAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 35.65858, longitude: 139.745433)
        annotation.title = "東京タワー"
        annotation.subtitle = "Tokyo Tower"
        mapView.addAnnotation(annotation)
    }
}

extension MarkerAnnotationViewViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as! MKMarkerAnnotationView
        view.glyphText = "A+"
        return view
    }
}
