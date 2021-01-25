//
//  ViewController.swift
//  xyz
//
//  Created by User on 2021-01-25.
//

import UIKit
import MapKit
//dsdssd
class ViewController: UIViewController {
    @IBOutlet weak var mapView :MKMapView!
    var coooooordinates = [CLLocationCoordinate2D]()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        let coordinates = CLLocationCoordinate2D(latitude: 43.7315, longitude: -79.7624)
        setRegion(coordinates: coordinates)
        //d
       // setPin(coordinates: coordinates)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(touch:)))
        mapView.addGestureRecognizer(tap)
        
    }
    @objc func handleTap(touch : UITapGestureRecognizer){
        let point = touch.location(in: mapView)
        let coordinates = mapView.convert(point, toCoordinateFrom: mapView)
        coooooordinates.append(coordinates)
        setPin(coordinates: coordinates)
        if coooooordinates.count == 3{
            let polu = MKPolygon(coordinates: coooooordinates, count: coooooordinates.count)
            mapView.addOverlay(polu)
            
        }
    }
    func setRegion(coordinates : CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: coordinates , span: span)
        mapView.region = region
    }
    
    func setPin(coordinates : CLLocationCoordinate2D){
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        pin.title = "Hello"
        mapView.addAnnotation(pin)
    }


}
extension ViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let x = overlay as? MKPolygon{
            let poly = MKPolygonRenderer(polygon: x)
            poly.strokeColor = .blue
            poly.lineWidth = 5
            return poly
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}

