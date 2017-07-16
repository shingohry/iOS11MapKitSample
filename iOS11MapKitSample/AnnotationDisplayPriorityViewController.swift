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

fileprivate class Station: MKPointAnnotation {
    var priority = MKFeatureDisplayPriority.required
}

extension Station {
    class func stations() -> [Station] {
        let jsonStations = Util.jsonObject(forResource: "stations") as! [[String: Any]]
        
        let stations = jsonStations.map { jsonStation -> Station in
            return Station.station(jsonStation)
        }
        
        return stations
    }
    
    class func station(_ jsonStation: [String: Any]) -> Station {
        guard let title = jsonStation["title"] as? String else { fatalError("cannot load title") }
        guard let latitudeString = jsonStation["latitude"] as? String, let latitude = Double(latitudeString) else { fatalError("cannot load latitude") }
        guard let longitudeString = jsonStation["longitude"] as? String, let longitude = Double(longitudeString) else { fatalError("cannot load longitude") }
        guard let priority = jsonStation["priority"] as? NSNumber else { fatalError("cannot load priority") }
        
        let station = Station()
        station.title = title
        station.coordinate = CLLocationCoordinate2D(latitude: latitude,
                                                    longitude: longitude)
        
        if priority == 0 {
            station.priority = .required
        } else if priority == 1 {
            station.priority = .defaultHigh
        } else {
            station.priority = .defaultLow
        }
        
        return station
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

fileprivate class Util {
    static func jsonObject(forResource name: String) -> Any {
        let url = Bundle.main.url(forResource: name,
                                  withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return try! JSONSerialization.jsonObject(with: data,
                                                 options: [])
    }
}
