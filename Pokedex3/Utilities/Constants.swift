//
//  Constants.swift
//  Pokedex3
//
//  Created by Hamza Abdulilah on 2017-10-04.
//  Copyright © 2017 Hamza Abdulilah. All rights reserved.
//

import Foundation


let URL_BASE = "https://pokeapi.co/"
let URL_POKEMON = "api/v1/pokemon/"

//Creating a block of code that will run on a specific time. In this example: Wait until downloaded data is availible before displaying it
typealias  DownloadComplete = () -> ()
