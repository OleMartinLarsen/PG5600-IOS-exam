//
//  MovieDetailViewController.swift
//  PG5600_eksamen
//
//  Created by Ole Martin Larsen on 24/11/2018.
//  Copyright © 2018 Høyskolen Kristiania. All rights reserved.
//

import UIKit
import CoreData

class FilmDetailViewController: UIViewController {
    
    var film: Film!
    
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var favoruiteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = film.title
        
        titelLabel.text = film.title
        directorLabel.text = film.director
        producerLabel.text = film.producer
        releaseDateLabel.text = film.release_date
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //favoruiteButton.isEnabled = false
        
        let fetchRequestFavouriteFilm: NSFetchRequest<FavouriteFilm> = FavouriteFilm.fetchRequest()
        fetchRequestFavouriteFilm.predicate = NSPredicate(format: "title = %@", film.title!)
        
        do{
            if (try PersistenceService.context.fetch(fetchRequestFavouriteFilm).first) != nil {
                favoruiteButton.setTitle("Delete from favourites", for: .normal)
            } else {
                favoruiteButton.setTitle("Add to favourites", for: .normal)
            }
        }catch let err {
            print (err)
        }
    }
    
    
    @IBAction func onButtonClick(_ sender: Any) {
        
        let fetchRequestFavouriteFilm: NSFetchRequest<FavouriteFilm> = FavouriteFilm.fetchRequest()
        fetchRequestFavouriteFilm.predicate = NSPredicate(format: "title = %@", film.title!)
        
        do{
            if let favFilm = try PersistenceService.context.fetch(fetchRequestFavouriteFilm).first {
                PersistenceService.context.delete(favFilm)
                PersistenceService.saveContext()
                favoruiteButton.setTitle("Add to favourites", for: .normal)
            } else {
                let favouriteFilm = FavouriteFilm(context: PersistenceService.context)
                favouriteFilm.title = film.title
                favouriteFilm.director = film.director
                favouriteFilm.producer = film.producer
                favouriteFilm.releasedate = film.release_date
                PersistenceService.saveContext()
                favoruiteButton.setTitle("Delete from favourites", for: .normal)
            }
        }catch let err {
            print (err)
        }
    }
    
}
