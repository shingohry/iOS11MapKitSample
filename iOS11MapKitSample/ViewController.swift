//
//  ViewController.swift
//  iOS11MapKitSample
//
//  Created by 平屋真吾 on 2017/07/07.
//  Copyright © 2017 Shingo Hiraya. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepare()
    }
}

extension ViewController {
    func prepare() {
        var region = mapView.region
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        region.center = CLLocationCoordinate2D(latitude: 35.65858, longitude: 139.745433)
        mapView.region = region
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 35.65858, longitude: 139.745433)
        annotation.title = "東京タワー"
        mapView.addAnnotation(annotation)
    }
}
