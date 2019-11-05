//
//  Pokemon.swift
//  pokedexMarkPrice
//
//  Created by Mohamad on 11/5/19.
//  Copyright © 2019 Mohamad barek. All rights reserved.
//

import Foundation

class Pokemon {
    var name: String!
    var pokedexId: Int!
    
    init(name: String, pokedexId: Int) {
         self.name = name
        self.pokedexId = pokedexId
    }
}
