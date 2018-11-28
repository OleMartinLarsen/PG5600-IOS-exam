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
    
    
    var favouriteFilms = [FavouriteFilm]()
    var favouriteCharacters = [FavouriteCharacter]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewFilm.dataSource = self
        tableViewCharcters.dataSource = self

        let fetchRequestFavouriteFilm: NSFetchRequest<FavouriteFilm> = FavouriteFilm.fetchRequest()
        
        do {
            let favouriteFilms = try PersistenceService.context.fetch(fetchRequestFavouriteFilm)
            self.favouriteFilms = favouriteFilms
            self.tableViewFilm.reloadData()
        } catch {}
        
        let fetchRequestFavouriteCharacters: NSFetchRequest<FavouriteCharacter> = FavouriteCharacter.fetchRequest()
        
        do {
            let favouriteCharacters = try PersistenceService.context.fetch(fetchRequestFavouriteCharacters)
            self.favouriteCharacters = favouriteCharacters
            self.tableViewCharcters.reloadData()
        } catch {}
        
        
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            tableViewCharcters.isHidden = true
            tableViewFilm.isHidden = false
        case 1:
            tableViewFilm.isHidden = true
            tableViewCharcters.isHidden = false
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!
            FavouriteFilmTableViewCell
            
            cell.titleLabel.text = favouriteFilms[indexPath.row].title
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator;
            cell.selectionStyle = .none
            return cell
        }
        else if(tableView == tableViewCharcters){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!
            FavouriteCharacterTableViewCell
            
            cell.titleLabel.text = favouriteCharacters[indexPath.row].name
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator;
            cell.selectionStyle = .none
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? FilmFavouriteViewController, let indexPath = tableViewFilm.indexPathForSelectedRow {
            
            let favouriteFilm = favouriteFilms[indexPath.row]
            detailVC.film = favouriteFilm
            
        }
    }
    
}
