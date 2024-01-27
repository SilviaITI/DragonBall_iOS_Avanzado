//
//  DetailViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 21/1/24.
//


import UIKit
import Kingfisher
import MapKit

protocol DetailViewControllerDelegate {
    var vieweState: ((DetailState) -> Void)? {get set}
    func onViewsAppear()
 
}


enum DetailState {
    case loading(_ isLoading: Bool)
    case update(hero: Hero?, locations: [HeroLocations])
}
class DetailViewController: UIViewController {
    var viewModel: DetailViewControllerDelegate?
   
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UITextView!
    
    @IBOutlet weak var mapDetail: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        heroImage.layer.cornerRadius = 20.0
        self.viewModel?.onViewsAppear()
        setObvservers()
       
    }

    private func setObvservers() {
        viewModel?.vieweState = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .loading(let isLoading):
                    self?.loadingView.isHidden = false
                case .update(let hero, let locations):
                    self?.initViews(hero: hero, heroLocations: locations)
                }
            }
        }
    }
    private func initViews(hero: Hero?, heroLocations: [HeroLocations]) {
        heroName.text = hero?.name
        heroImage.kf.setImage(with: hero?.photo)
        heroDescription.text = hero?.description
        
        
        heroLocations.forEach {
            mapDetail.addAnnotation(
          HeroAnnotation(
                    title: hero?.name,
                    info: hero?.id,
                    coordinate: .init(latitude: Double($0.latitud ?? "") ?? 0.0,
                                      longitude: Double($0.longitud ?? "") ?? 0.0)
                )
            )
            self.mapDetail.setNeedsDisplay()
        }
    }
        
    }

