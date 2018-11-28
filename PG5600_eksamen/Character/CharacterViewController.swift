//
//  CharactersViewController.swift
//  PG5600_eksamen
//
//  Created by Ole Martin Larsen on 26/11/2018.
//  Copyright © 2018 Høyskolen Kristiania. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    
    var characters = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getNextPage(url: "https://swapi.co/api/people/?page=1")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func getNextPage(url: String){
        guard let url2 = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url2) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let resp = try JSONDecoder().decode(CharacterRoot.self, from: data)
                self.characters = self.characters + resp.results
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
                if(resp.next != nil) { self.getNextPage(url: resp.next!) }
            } catch let jsonError {
                print("JSON ERROR:", jsonError)
            }
            }.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!
        CharacterCollectionViewCell
        
        cell.nameLabel.text = characters[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Clicked")
        let favouriteCharacter = FavouriteCharacter(context: PersistenceService.context)
        favouriteCharacter.name = characters[indexPath.row].name
        PersistenceService.saveContext()
    }
    
}
