//
//  Hero.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 15/1/24.
//

import Foundation
typealias Heroes = [Hero]

struct Hero: Codable {
    let id: String?
    let name: String?
    let description: String?
    let photo: String?
    let favorite: Bool?
}
