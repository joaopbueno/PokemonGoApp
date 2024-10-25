//
//  PokemonAnotacao.swift
//  PokemonGoApp
//
//  Created by João Bueno on 25/10/24.
//

import UIKit
import MapKit

class PokemonAnotacao: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var pokemon: Pokemon
    
    init(coordenadas: CLLocationCoordinate2D, pokemon: Pokemon) {
        self.coordinate = coordenadas
        self.pokemon = pokemon
    }
    
}
