//
//  FavouritesViewController.swift
//  PG5600_eksamen
//
//  Created by Ole Martin Larsen on 27/11/2018.
//  Copyright © 2018 Høyskolen Kristiania. All rights reserved.
//

import UIKit
import CoreData

class FavouritesViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableViewFilm: UITableView!
    @IBOutlet weak var tableViewCharcters: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var titleRecommended: UILabel!
    @IBOutlet weak var movieRecommended: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var favouriteFilms = [FavouriteFilm]()
    var favouriteCharacters = [FavouriteCharacter]()
    
    //let [“Jar Jar’s Topp 1-liste”, “Jabbas favorittfilm”, “Yoda du måda se denne”, “Prinsesse Leia’n på DVD”]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableViewFilm.dataSource = self
        tableViewCharcters.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let fetchRequestFavouriteFilm: NSFetchRequest<FavouriteFilm> = FavouriteFilm.fetchRequest()
        
        do {
            self.favouriteFilms.removeAll()
            let sort = NSSortDescriptor(key: "title", ascending: true)
            fetchRequestFavouriteFilm.sortDescriptors = [sort]
            let favouriteFilms = try PersistenceService.context.fetch(fetchRequestFavouriteFilm)
            self.favouriteFilms = favouriteFilms
            DispatchQueue.main.async {
                self.tableViewFilm.reloadData()
            }
        } catch {}
        
        let fetchRequestFavouriteCharacters: NSFetchRequest<FavouriteCharacter> = FavouriteCharacter.fetchRequest()
        
        do {
            let sort = NSSortDescriptor(key: "name", ascending: true)
            fetchRequestFavouriteCharacters.sortDescriptors = [sort]
            let favouriteCharacters = try PersistenceService.context.fetch(fetchRequestFavouriteCharacters)
            self.favouriteCharacters = favouriteCharacters
            DispatchQueue.main.async {
                self.tableViewCharcters.reloadData()
            }
        } catch {}
        
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            tableViewCharcters.isHidden = true
            tableViewFilm.isHidden = false
            movieRecommended.isHidden = true
            titleRecommended.isHidden = true
            
        case 1:
            tableViewFilm.isHidden = true
            tableViewCharcters.isHidden = false
            movieRecommended.isHidden = false
            titleRecommended.isHidden = false
        default:
            break;
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView == tableViewFilm) {
            return favouriteFilms.count
        }
        else if (tableView == tableViewCharcters) {
            return favouriteCharacters.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == tableViewFilm){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellf", for: indexPath) as!
            FavouriteFilmTableViewCell
            
            cell.titleLabel.text = favouriteFilms[indexPath.row].title
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator;
            cell.selectionStyle = .none
            return cell
        }
        
        else if(tableView == tableViewCharcters){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellc", for: indexPath) as!
            FavouriteCharacterTableViewCell
            
            var episodeIds = ""
            let episodes = favouriteCharacters[indexPath.row].episodeid
            for episode in episodes! {
                episodeIds = episodeIds + "\(episode)" + ", "
            }
    
            
            cell.nameLabel.text = favouriteCharacters[indexPath.row].name
            cell.episodeLabel.text = episodeIds
            
            cell.selectionStyle = .none
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(tableView == tableViewCharcters) {
            print(favouriteCharacters[indexPath.row])
        }
        //let indexPath = tableView.indexPathForSelectedRow
        
        //getting the current cell from the index path
        //let currentCell = tableViewCharcters.cellForRow(at: indexPath!) as! FavouriteCharacterTableViewCell
        
        //currentCell.isSelected
        
        
        
        
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailVC = segue.destination as? FilmFavouriteViewController, let indexPath = tableViewFilm.indexPathForSelectedRow {
            
            let favouriteFilm = favouriteFilms[indexPath.row]
            detailVC.film = favouriteFilm
            
        }
    }
    
}
