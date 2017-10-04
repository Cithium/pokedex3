//
//  Pokemon.swift
//  Pokedex3
//
//  Created by Hamza Abdulilah on 2017-10-02.
//  Copyright © 2017 Hamza Abdulilah. All rights reserved.
//

import Foundation
import Alamofire


class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: Int!
    private var _height: String!
    private var _weight: String!
    private var _attack: Int!
    private var _nextEvolutionText: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    
    private var _pokemonURL: String!
    
    //Data protection, so app only uses values that actually exists and not nil values
    
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var defense: Int {
        if _defense == nil {
            _defense = 0
        }
        return _defense
    }
    
    var attack: Int {
        if _attack == nil {
            _attack = 0
        }
        return _attack
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    var nextEvolutionText: String {
        if _nextEvolutionText == nil {
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String {
        if  _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
    }
        return _nextEvolutionLevel
        
    }
    
    var name: String {
        
        return _name
    }
    
    var pokedexId: Int{
        
        return _pokedexId
    }
    
    
   init(name: String, pokedexId: Int) {
        self._pokedexId = pokedexId
        self._name = name
        
        self._pokemonURL = URL_BASE + URL_POKEMON + "\(self.pokedexId)/"
        
    }
    
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(self._pokemonURL).responseJSON { response in
            
            
           if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
            
            if let height = dict["height"] as? String {
                    self._height = height
            }
            
            if let defense = dict["defense"] as? Int {
                    self._defense = defense
            }
            
            if let attack = dict["attack"] as? Int {
                    self._attack = attack
            }
            
         /*  Detta var din original lösning... remember this moment
             if let types = dict["types"] as? [Dictionary<String, AnyObject>] {
             
                for index in 0..<types.count {
                    if let tempType = types[index]["name"] as? String {
                        if types.count > 1 && self._type != nil {
                             self._type.append("/" + tempType)
                        } else {
                            self._type = tempType
                        }
             
                    }
                }
            } */
            
            if let types = dict["types"] as? [Dictionary<String, AnyObject>], types.count > 0 {
                
                if let typeName = types[0]["name"] {
                    self._type = typeName.capitalized
                }
                
                if types.count > 1 {
                    for x in 1..<types.count {
                        if let typeName = types[x]["name"] {
                            self._type! += "/\(typeName)"
                        }
                    }
                }
            } else {
                self._type = ""
            }
            
            if let descriptions = dict["descriptions"] as? [Dictionary<String, AnyObject>], descriptions.count > 0 {
                if let url = descriptions[0]["resource_uri"] {
                    let descURL = "\(URL_BASE)\(url)"
                    
                    Alamofire.request(descURL).responseJSON { response in
                        if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                            if let pokeDesc = descDict["description"] as? String {
                                let correctedString = pokeDesc.replacingOccurrences(of: "POKMON", with: "pokemon")
                                self._description = correctedString
                            }
                        }
                        completed()
                    }
                }
            } else {
                self._description = ""
            }
            
            if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                if let nextEvo = evolutions[0]["to"] as? String {
                    //exclude mega
                    if nextEvo.range(of: "mega") == nil {
                        self._nextEvolutionName = nextEvo
                        
                        // Extract the ID number
                      if  let uri = evolutions[0]["resource_uri"] as? String {
                            let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                            let nextEvoID = newString.replacingOccurrences(of: "/", with: "")
                            self._nextEvolutionId = nextEvoID
                        
                        
                            //if level exists prob
                        if let lvlExists = evolutions[0]["level"] {
                            if let lvl = lvlExists as? Int {
                                self._nextEvolutionLevel = "\(lvl)"
                            }
                        
                        } else {
                            self._nextEvolutionLevel = ""
                        }
                    }
                }
            }
            
        }
            completed()
        
        }
    }
}

}








