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
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var currentIvoImage: UIImageView!
    @IBOutlet weak var nextIvoImage: UIImageView!
    @IBOutlet weak var evoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Ladda in bilder etc går snabbare i ViewDidLoad, därför du ser små "inladdningar" när appen körs, men inte standard grejern som name, index osv,

        let image = UIImage(named: "\(pokemon.pokedexId)")
        
        nameLabel.text = pokemon.name
        mainImage.image = image
        currentIvoImage.image = image
         pokedexLabel.text = "\(pokemon.pokedexId)"
        
        
        pokemon.downloadPokemonDetails(){
            self.updateUI()
        }
    }
    
    func updateUI() {
        print("Arrived")
        nameLabel.text = pokemon.name
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        attackLabel.text = "\(pokemon.attack)"
        defenseLabel.text = "\(pokemon.defense)"
        pokedexLabel.text = "\(pokemon.pokedexId)"
        
        typeLabel.text = pokemon.type.capitalized
        descriptionLabel.text = pokemon.description
        
        print(pokemon.type)
        
        
        
    }

    
 
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
