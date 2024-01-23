//
//  DetailViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 21/1/24.
//


import UIKit
import Kingfisher

protocol DetailViewControllerDelegate {
    func initViews()
}
class DetailViewController: UIViewController {
    
 
    var hero: Hero?
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heroImage.layer.cornerRadius = 20.0
        initViews()
       
    }

    
    func initViews() {
        heroName.text = hero?.name
        heroImage.kf.setImage(with: hero?.photo)
        heroDescription.text = hero?.description
    }
        
    }

