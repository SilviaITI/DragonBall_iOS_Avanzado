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
    func onViewsAppear()
}
    enum MapViewState {
        case loading(_ isLoading: Bool)
        case update(locations: [Location])
    }
class MapViewController: UIViewController {
    var viewModel: MapViewControllerDelegate?
   
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var heroesMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.onViewsAppear()
        setObservers()
        

    }
    
    func setObservers(){
        viewModel?.viewState = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .loading(let isLoading):
                    self?.loadingView.isHidden = false
                case .update( let locations):
                    self?.initViews(heroLocations: locations)
                    print(" locations \(locations)")
                }
            }
        }
    }
    
    
private func initViews( heroLocations: [Location]) {
    DispatchQueue.main.async {
        
        heroLocations.forEach {
            self.heroesMap.addAnnotation(
                HeroAnnotation(
                    coordinate: .init(latitude: Double($0.latitud ?? "") ?? 0.0,
                                      longitude: Double($0.longitud ?? "") ?? 0.0)
                )
            )
            self.heroesMap.setNeedsDisplay()
            print(HeroAnnotation.self)
           
        }
     
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

