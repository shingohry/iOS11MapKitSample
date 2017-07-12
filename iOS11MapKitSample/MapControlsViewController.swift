//
//  MapControlsViewController.swift
//  iOS11MapKitSample
//
//  Created by Shingo Hiraya on 7/12/17.
//  Copyright © 2017 Shingo Hiraya. All rights reserved.
//

import UIKit
import MapKit

class MapControlsViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepare()
    }
}

extension MapControlsViewController {
    func prepare() {
        let scaleView = MKScaleView(mapView: mapView)
        scaleView.scaleVisibility = .visible
        stackView.addArrangedSubview(scaleView)
        
        let compassButton = MKCompassButton(mapView: mapView)
        compassButton.compassVisibility = .visible
        stackView.addArrangedSubview(compassButton)
        
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.65858, longitude: 139.745433),
                                            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    }
}

