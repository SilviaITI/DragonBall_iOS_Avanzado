//
//  Cell.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 21/1/24.
//

import UIKit

class Cell: UITableViewCell {
     
    // MARK: - Outlets -
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var container: UIView!
    
    // MARK: - Properties -
    static let estimatedHeight: CGFloat = 220
    static let identifier = "Cell"
    
    // MARK: - Lyfecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
    }
    
    // MARK: - Functions -
    func updateData(with hero: Hero) {
        heroName.text = hero.name
        heroImage.kf.setImage(with: hero.photo)
        heroDescription.text = hero.description
    }
    
    private func setCell() {
        container.layer.cornerRadius = 10
        container.layer.shadowColor = UIColor.gray.cgColor
        container.layer.shadowOffset = .zero
        container.layer.shadowRadius = 12
        container.layer.shadowOpacity = 0.8
        heroImage.layer.cornerRadius = 8
        heroImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        selectionStyle = .none
    }
    
    
}
