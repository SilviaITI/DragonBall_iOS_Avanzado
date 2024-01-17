//
//  HeroLocations.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 15/1/24.
//

import Foundation

typealias HeroLocations = [HeroLocation]

struct HeroLocation: Codable {
    let id: String?
    let latitude: String?
    let longitude: String?
    let date: String?
    let hero: Hero?
}

