//
//  ViewController.swift
//  Pokedex3
//
//  Created by Hamza Abdulilah on 2017-10-02.
//  Copyright © 2017 Hamza Abdulilah. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collection: UICollectionView!
    
    var pokemonArray = [Pokemon]()
    var filteredPokemonArray = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        initAudio()
       
    }
    
    func initAudio() {
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        
        do {
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path) )
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
 
        } catch let error as NSError{
            print(error.debugDescription)
        }
       
    }
    
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
          
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let pokemonObject = Pokemon(name: name, pokedexId: pokeId)
                pokemonArray.append(pokemonObject)
            }
        } catch let error as NSError {
            print(error.debugDescription)
        }
     }

    //Här visas och väljs pokemon för att sedan visas i en ny detaljerat view.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as? PokeCell {
            
            //Kolla om det är i SearchMode och displaya rätt array
            
            let pokemonObject: Pokemon!
            
            if inSearchMode {
                pokemonObject = filteredPokemonArray[indexPath.row]
                cell.configCell(pokemon: pokemonObject)
            } else {
                
                pokemonObject = pokemonArray[indexPath.row]
                cell.configCell(pokemon: pokemonObject)
            }
            
        
            return cell
        }else{
            return PokeCell()
        }
        
    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemonArray[indexPath.row]
        } else {
            poke = pokemonArray[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokeDetailViewController", sender: poke)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // inSearchMode är det annat antal pokemons som ska visas
        if inSearchMode {
                return filteredPokemonArray.count
        } else {
                return pokemonArray.count
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 104, height: 104)
    }

    @IBAction func musicButtonPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.stop()
            sender.alpha = 0.5
            
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Om searchBar inte har någon text, collection.reloadData() för att visa vanlig array, annars visa filtrerade
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
            
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            // $0 är en placeholder/referens till vilken pokemon som helst i array/listan
            filteredPokemonArray = pokemonArray.filter({
                $0.name.range(of: lower) != nil
            })
            collection.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokeDetailViewController" {
            if let detailsViewController = segue.destination as? PokeDetailViewController {
                // Om objektet som skickas är Pokemon objekt, tilldela det objekt som finns i destination
                if let poke = sender as? Pokemon {
                    detailsViewController.pokemon = poke
                }
            }
        }
    }
}





















