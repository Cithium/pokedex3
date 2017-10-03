//
//  PokeDetailViewController.swift
//  Pokedex3
//
//  Created by Hamza Abdulilah on 2017-10-03.
//  Copyright © 2017 Hamza Abdulilah. All rights reserved.
//

import UIKit

class PokeDetailViewController: UIViewController {

    //This WILL be received from the main ViewController
    var pokemon: Pokemon!

    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon.name
    }

    
 

}
