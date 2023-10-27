//
//  CustomTableViewCell.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 21/10/23.
//

import UIKit
import Kingfisher
class CustomTableViewCell: UITableViewCell {

    static let identifier: String = "HeroCellView"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 8
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOpacity = 0.4
        
        heroImage.layer.cornerRadius = 8
        heroImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        
        selectionStyle = .none
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        heroImage.image = nil
        descriptionText.text = ""
    }
    func updateCell(
        name: String? = nil,
        photo: String? = nil,
        description: String? = nil
    ) {
        self.nameLabel.text = name
        self.descriptionText.text = description
        self.heroImage.kf.setImage(with: URL(string: photo ?? ""))
    }
        
}
    

    

