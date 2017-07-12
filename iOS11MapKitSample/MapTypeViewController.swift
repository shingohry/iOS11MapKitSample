//
//  ViewController.swift
//  iOS11MapKitSample
//
//  Created by 平屋真吾 on 2017/07/07.
//  Copyright © 2017 Shingo Hiraya. All rights reserved.
//

import UIKit
import MapKit

class MapTypeViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepare()
    }
    
    @IBAction func segmentedControlDidChange(_ sender: UISegmentedControl) {
        mapView.mapType = sender.selectedSegmentIndex == 0 ? .mutedStandard : .standard
    }
}

extension MapTypeViewController {
    func prepare() {
        mapView.mapType = .mutedStandard
        
        var region = mapView.region
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        region.center = CLLocationCoordinate2D(latitude: 35.65858, longitude: 139.745433)
        mapView.region = region
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 35.65858, longitude: 139.745433)
        annotation.title = "東京タワー"
        annotation.subtitle = "Tokyo Tower" // マーカーを選択すると表示される
        mapView.addAnnotation(annotation)
    }
}
