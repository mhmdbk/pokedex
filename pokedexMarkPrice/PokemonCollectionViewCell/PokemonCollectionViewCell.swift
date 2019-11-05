//
//  PokemonCollectionViewCell.swift
//  pokedexMarkPrice
//
//  Created by Mohamad on 11/5/19.
//  Copyright © 2019 Mohamad barek. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5.0
     }
    
    
    func configureCell(pokemon: Pokemon){
        pokeNameLabel.text = pokemon.name
        pokeImageView.image = UIImage(named: "\(pokemon.pokedexId ?? 1)")
    }
}
