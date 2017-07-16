//
//  AnnotationClusteringViewController.swift
//  iOS11MapKitSample
//
//  Created by Shingo Hiraya on 7/17/17.
//  Copyright © 2017 Shingo Hiraya. All rights reserved.
//

import UIKit
import MapKit

class AnnotationClusteringViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepare()
    }
}

extension AnnotationClusteringViewController {
    func prepare() {
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.698339, longitude: 139.772908),
                                            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.register(StationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(ClusterStationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        mapView.mapType = .mutedStandard
        
        let annotations = Station.stations()
        mapView.addAnnotations(annotations)
    }
}

fileprivate class StationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            if let station = newValue as? Station {
                // The default value of this property is nil
                // Setting the property to a non nil value it to participate in clustering.
                clusteringIdentifier = "station"
                
                displayPriority = station.priority
            }
        }
    }
}

class ClusterStationView: MKMarkerAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        displayPriority = .defaultHigh
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var annotation: MKAnnotation? {
        willSet {
            if let cluster = newValue as? MKClusterAnnotation {
                markerTintColor = UIColor(named: "Green")
                glyphText = "\(cluster.memberAnnotations.count)"
            }
        }
    }
}
