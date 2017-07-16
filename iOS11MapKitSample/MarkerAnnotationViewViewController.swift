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
        mapView.register(LocationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.mapType = .mutedStandard
        
        let annotation = Location()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 35.65858,
                                                       longitude: 139.745433)
        annotation.title = "東京タワー"
        annotation.subtitle = "Tokyo Tower"
        annotation.type = .famousPlace
        mapView.addAnnotation(annotation)
        
        let annotation2 = Location()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: 35.655353,
                                                        longitude: 139.743462)
        annotation2.title = "ファミリーマート"
        annotation2.subtitle = "東麻布一丁目店"
        annotation2.type = .shop
        mapView.addAnnotation(annotation2)
        
        let annotation3 = Location()
        annotation3.coordinate = CLLocationCoordinate2D(latitude: 35.654682,
                                                        longitude: 139.749910)
        annotation3.title = "芝公園駅"
        annotation3.subtitle = "都営大江戸線"
        annotation3.type = .other
        mapView.addAnnotation(annotation3)
    }
}

fileprivate class Location: MKPointAnnotation {
    enum LocationType: Int {
        case famousPlace
        case shop
        case other
    }
    
    var type: LocationType = .other
}

fileprivate class LocationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            if let location = newValue as? Location {
                switch location.type {
                case .famousPlace:
                    glyphText = "観光"
                    markerTintColor = UIColor(named: "Blue")
                case .shop:
                    // Icon by https://iconmonstr.com/
                    glyphImage = UIImage(named: "sho-cart")
                    
                    markerTintColor = UIColor(named: "Green")
                case .other:
                    break
                }
            }
        }
    }
}
