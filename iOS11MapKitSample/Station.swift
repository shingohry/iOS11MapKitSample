//
//  Station.swift
//  iOS11MapKitSample
//
//  Created by Shingo Hiraya on 7/17/17.
//  Copyright © 2017 Shingo Hiraya. All rights reserved.
//

import MapKit

class Station: MKPointAnnotation {
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

fileprivate class Util {
    static func jsonObject(forResource name: String) -> Any {
        let url = Bundle.main.url(forResource: name,
                                  withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return try! JSONSerialization.jsonObject(with: data,
                                                 options: [])
    }
}
