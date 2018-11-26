//
//  ViewControllerMapa.swift
//  Proyecto_final_Chavez
//
//  Created by Karen on 11/25/18.
//  Copyright © 2018 Antonio. All rights reserved.
//

import UIKit
import MapKit

final class Anotacion: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    init(cordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate=cordinate
        self.title=title
    }
    var region: MKCoordinateRegion{
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        return MKCoordinateRegion(center: coordinate, span: span)
    }
}

class ViewControllerMapa: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    var name = "Donde rentar"
    var lat: Double?
    var lng: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lat = drand48()
        lng = drand48()
        lat = lat! + Double(arc4random_uniform(250))
        lng = lng! + Double(arc4random_uniform(250))
        // Do any additional setup after loading the view.
        //Agregar anotación en el mapa
        title = name
        map.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        let cordenada = CLLocationCoordinate2D(latitude: lat!, longitude: lng!)
        let anotacion = Anotacion(cordinate: cordenada, title: name)
        let cordenadaO = CLLocationCoordinate2D(latitude: 20.744478, longitude: -103.378901)
        let anotacionO = Anotacion(cordinate: cordenadaO, title: "Origen")
        map.addAnnotation(anotacion)
        map.addAnnotation(anotacionO)
        let inicioLugar = MKPlacemark(coordinate: cordenadaO)
        let finLugar = MKPlacemark(coordinate: cordenada)
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = MKMapItem(placemark: inicioLugar)
        directionRequest.destination = MKMapItem(placemark: finLugar)
        directionRequest.transportType = .automobile
        let direction = MKDirections (request: directionRequest)
        direction.calculate {(response, error) in
            guard let directionsResonse = response else{
                if error != nil{
                    print("Hubo un error")
                }
                return
            }
            let route = directionsResonse.routes[0]
            self.map.add(route.polyline, level: .aboveRoads)
            let ract = route.polyline.boundingMapRect
            self.map.setRegion(MKCoordinateRegionForMapRect(ract), animated: true)
        }
        self.map.delegate = self
        //map.setRegion(anotacion.region, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
