//
//  DetailViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 21/1/24.
//


import UIKit
import Kingfisher
import MapKit

// MARK: - Protocol -
protocol DetailViewControllerDelegate {
    var vieweState: ((DetailState) -> Void)? {get set}
    func onViewsAppear()
}

//MARK: - Enum State -
enum DetailState {
    case loading(_ isLoading: Bool)
    case update(hero: Hero?, locations: [Location])
}

// MARK: - Class -
class DetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UITextView!
    @IBOutlet weak var mapDetail: MKMapView!
    
    // MARK: - Properties -
    var viewModel: DetailViewControllerDelegate?
    
    // MARK: - Lyfecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeroImage()
        viewModel?.onViewsAppear()
        setObvservers()
    }
    
    // MARK: - Functions -
    private func setObvservers() {
        viewModel?.vieweState = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .loading(_):
                    self?.loadingView.isHidden = false
                case .update(let hero, let locations):
                    self?.initViews(hero: hero, heroLocations: locations)
                }
            }
        }
    }
    
    private func initViews(hero: Hero?, heroLocations: [Location]) {
        DispatchQueue.main.async {
            self.heroName.text = hero?.name
            self.heroImage.kf.setImage(with: hero?.photo)
            self.heroDescription.text = hero?.description
            heroLocations.forEach {
                self.mapDetail.addAnnotation(
                    HeroAnnotation(
                        title: hero?.name,
                        info: hero?.id,
                        coordinate: .init(latitude: Double($0.latitud ?? "") ?? 0.0,
                                          longitude: Double($0.longitud ?? "") ?? 0.0)
                    )
                )
                self.mapDetail.setNeedsDisplay()
                self.mapDetail.region.center.latitude = Double(heroLocations.first?.latitud ?? "") ?? 0.0
                self.mapDetail.region.center.longitude = Double(heroLocations.first?.longitud ?? "") ?? 0.0
                print(HeroAnnotation.self)
            }
        }
    }
    
    private func setHeroImage() {
        heroImage.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        heroImage.contentMode = .scaleAspectFill
        heroImage.layer.cornerRadius = heroImage.frame.size.width / 2
        heroImage.layer.borderWidth = 2.0
        heroImage.layer.borderColor = UIColor.black.cgColor
        heroImage.clipsToBounds = true
    }
}

