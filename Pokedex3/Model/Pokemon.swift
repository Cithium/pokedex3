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
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    
    
    
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
