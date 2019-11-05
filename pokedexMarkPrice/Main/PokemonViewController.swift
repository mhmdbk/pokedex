//
//  PokemonViewController.swift
//  pokedexMarkPrice
//
//  Created by Mohamad on 11/5/19.
//  Copyright © 2019 Mohamad barek. All rights reserved.
//

import UIKit
import AVFoundation

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var pokeCollectionView: UICollectionView!
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    
    
    var musicPlayer: AVAudioPlayer!
    var pokemonArray = [Pokemon]()
    var inSearchMode = false
    var filteredPokemon = [Pokemon]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        pokemonArray.append(Pokemon(name: "test", pokedexId: 1))
        pokemonArray.append(Pokemon(name: "ratata", pokedexId: 2))
        pokemonArray.append(Pokemon(name: "charizard", pokedexId: 3))
        pokemonArray.append(Pokemon(name: "char", pokedexId: 4))
        pokemonArray.append(Pokemon(name: "cheese", pokedexId: 5))
        pokemonArray.append(Pokemon(name: "tefewr", pokedexId: 6))
        pokemonArray.append(Pokemon(name: "teserttet", pokedexId: 7))
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        pokeCollectionView.delegate = self
        pokeCollectionView.dataSource = self
        pokemonSearchBar.delegate = self
        let collectioViewNib = UINib(nibName: "PokemonCollectionViewCell", bundle: .main)
        pokeCollectionView.register(collectioViewNib, forCellWithReuseIdentifier: "PokemonCollectionViewCell")
        initAudio()
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: url)
            musicPlayer.numberOfLoops = -1
            musicPlayer?.play()
        } catch {
                print(error.localizedDescription)
        }
        
    }
    
    @IBAction func musicButton(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.stop()
            sender.alpha = 0.2
        }
        else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
}
extension PokemonViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105,height: 105)
    }
    
}

extension PokemonViewController: UICollectionViewDelegate {
    
}

extension PokemonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokemonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCollectionViewCell", for: indexPath) as! PokemonCollectionViewCell
        let poke: Pokemon!
        if inSearchMode {
             poke = filteredPokemon[indexPath.row]
        }
        else {
            poke = pokemonArray[indexPath.row]
        }
        cell.configureCell(pokemon: poke)

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension PokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            pokeCollectionView.reloadData()
        }
        else {
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemonArray.filter({$0.name.range(of: lower) != nil})
            pokeCollectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
