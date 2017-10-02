//
//  Pokemon.swift
//  Pokedex3
//
//  Created by Hamza Abdulilah on 2017-10-02.
//  Copyright © 2017 Hamza Abdulilah. All rights reserved.
//

import Foundation


class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    
    
    var name: String {
        
        return _name
    }
    
    var pokedexId: Int{
        
        return _pokedexId
    }
    
    
    init(name: String, pokedexId: Int) {
        self._pokedexId = pokedexId
        self._name = name
    }
}
