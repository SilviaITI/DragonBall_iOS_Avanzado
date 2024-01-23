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
    var heroLocations: HeroLocations? {get}
    func fetchLocations(completion: @escaping () -> ())
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
        viewModel?.fetchLocations {
            self.updateViews()
        }

    }
    
    func setObservers(){
        
    }
    
    private func updateViews() {
        DispatchQueue.main.async {
            self.viewModel?.heroLocations?.forEach {
            self.heroesMap.addAnnotation(
                LocationsAnotations(
                    coordinate: .init(latitude: Double($0.latitude ?? "" ) ?? 0.0,
                                      longitude: Double($0.longitude ?? "" ) ?? 0.0),
                    title:$0.hero?.name,
                    info: $0.hero?.id ?? ""
                    )
                )
                self.heroesMap.setNeedsDisplay()
        }
                    }
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
