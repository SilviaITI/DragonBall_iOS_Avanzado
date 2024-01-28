//
//  HeroLocations.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 15/1/24.
//

import Foundation

struct Location: Codable {
    let id: String?
    let latitud: String?
    let longitud: String?
    let date: String?
    let hero: Hero?
}

