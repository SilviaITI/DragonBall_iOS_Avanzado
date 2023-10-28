//
//  Hero.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 27/10/23.
//

import Foundation

typealias Heroes = [Hero]

struct Hero: Codable {
    
    let id: String
    let favorite: Bool
    let description: String
    let photo: String
    let name: String
}
