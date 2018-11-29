//
//  CharactersViewController.swift
//  PG5600_eksamen
//
//  Created by Ole Martin Larsen on 26/11/2018.
//  Copyright © 2018 Høyskolen Kristiania. All rights reserved.
//

import UIKit
import CoreData

class CharacterViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var characters = [Character]()
    var charactersFilms = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getNextPage(url: "https://swapi.co/api/people/?page=1")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func getNextPage(url: String){
        guard let nextUrl = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: nextUrl) { (data, response, err) in
            
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
        
        let fetchRequestFavouriteCharacter: NSFetchRequest<FavouriteCharacter> = FavouriteCharacter.fetchRequest()
        fetchRequestFavouriteCharacter.predicate = NSPredicate(format: "name = %@", characters[indexPath.row].name!)
        
        do{
            if (try PersistenceService.context.fetch(fetchRequestFavouriteCharacter).first) != nil {
                cell.imageView.backgroundColor = UIColor.orange
                
            } else {
                cell.imageView.backgroundColor = UIColor.black
            }
        }catch let err {
            print (err)
        }
        
        cell.nameLabel.text = characters[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CharacterCollectionViewCell
        
        let fetchRequestFavouriteCharacter: NSFetchRequest<FavouriteCharacter> = FavouriteCharacter.fetchRequest()
        fetchRequestFavouriteCharacter.predicate = NSPredicate(format: "name = %@", characters[indexPath.row].name!)
        
        do{
            if let favCharacter = try PersistenceService.context.fetch(fetchRequestFavouriteCharacter).first {
                PersistenceService.context.delete(favCharacter)
                PersistenceService.saveContext()
                cell.imageView.backgroundColor = UIColor.black
                
                
            } else {
                let favouriteCharacter = FavouriteCharacter(context: PersistenceService.context)
                favouriteCharacter.name = characters[indexPath.row].name
                favouriteCharacter.films = characters[indexPath.row].films
                favouriteCharacter.episodeid = []
                PersistenceService.saveContext()
                
                self.getEpisodeIds(for: favouriteCharacter)
                cell.imageView.backgroundColor = UIColor.orange
            }
        }catch let err {
            print (err)
        }
    }
    
    func getEpisodeIds(for character: FavouriteCharacter) {
        
        for film in character.films! {
            guard let url = URL(string: film) else { continue }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                
                do {
                    let filmResp = try JSONDecoder().decode(Film.self, from: data)
                    
                    let fetch: NSFetchRequest<FavouriteCharacter> = FavouriteCharacter.fetchRequest()
                    
                    fetch.predicate = NSPredicate(format: "name == %@", character.name!)
                    
                    let favouriteCharacter = try PersistenceService.context.fetch(fetch).first as! FavouriteCharacter
                    
                    DispatchQueue.main.async {
                        favouriteCharacter.episodeid?.append(filmResp.episode_id!)
                        PersistenceService.saveContext()
                    }
                    
                } catch let jsonError {
                    print("JSON ERROR:", jsonError)
                }
                }.resume()
        }
    }
    
    
}
