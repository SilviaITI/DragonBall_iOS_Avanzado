//
//  MapViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 23/1/24.
//

import UIKit
import MapKit

protocol MapViewControllerDelegate {
    var viewState:((MapViewState) -> Void)? {get set}
   // func fetchLocations() -> HeroLocations
}
    enum MapViewState {
        case loading(_ isLoading: Bool)
        case updated
    }
class MapViewController: UIViewController {
    var viewModel: MapViewControllerDelegate?
   
    @IBOutlet weak var heroesMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

       // updateViews()
        

    }
    
    func setObservers(){
        
    }
    
//    private func updateViews( ) {
//   
//            var locationsAnotations = self.viewModel?.fetchLocations()
//            for locationAnotation in locationsAnotations! {
//                print("cacaConrto\(locationAnotation.latitud)")
//            self.heroesMap.addAnnotation(
//                LocationsAnotations(
//                    coordinate: .init(latitude: Double(locationAnotation.latitud ?? "0.0" ) ?? 0.0,
//                                      longitude: Double(locationAnotation.longitud ?? "0.0" ) ?? 0.0),
//                    title: "hola",
//                    info:  "id"
//                    )
//                )
//                self.heroesMap.setNeedsDisplay()
//        }
                    
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }

