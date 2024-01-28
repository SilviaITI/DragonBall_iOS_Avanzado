//
//  MapViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 23/1/24.
//

import UIKit
import MapKit

// MARK: - Protocol -
protocol MapViewControllerDelegate {
    var viewState:((MapViewState) -> Void)? {get set}
    func onViewsAppear()
}

//MARK: - Enum State -
    enum MapViewState {
        case loading(_ isLoading: Bool)
        case update(locations: [Location])
    }

// MARK: - Class -
class MapViewController: UIViewController {
       
    // MARK: - Outlets -
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var heroesMap: MKMapView!
    
    // MARK: - Properties -
    var viewModel: MapViewControllerDelegate?
    
    // MARK: - Lyfecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.onViewsAppear()
        setObservers()
    }
    
    // MARK: - Functions -
    private func setObservers(){
        viewModel?.viewState = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .loading(_):
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
}

