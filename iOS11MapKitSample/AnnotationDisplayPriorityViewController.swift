//
//  AnnotationDisplayPriorityViewController.swift
//  iOS11MapKitSample
//
//  Created by Shingo Hiraya on 7/16/17.
//  Copyright © 2017 Shingo Hiraya. All rights reserved.
//

import UIKit
import MapKit

class AnnotationDisplayPriorityViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepare()
    }
}

extension AnnotationDisplayPriorityViewController {
    func prepare() {
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.698339, longitude: 139.772908),
                                            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.register(StationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.mapType = .mutedStandard
        
        let annotations = Station.stations()
        mapView.addAnnotations(annotations)
    }
}

fileprivate class StationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            if let station = newValue as? Station {
                displayPriority = station.priority
            }
        }
    }
}
