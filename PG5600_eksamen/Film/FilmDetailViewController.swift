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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = film.title
        
        titelLabel.text = film.title
        directorLabel.text = film.director
        producerLabel.text = film.producer
        releaseDateLabel.text = film.release_date
        
    }
    
    
    @IBAction func onButtonClick(_ sender: Any) {
        let favouriteFilm = FavouriteFilm(context: PersistenceService.context)
        favouriteFilm.title = film.title
        favouriteFilm.director = film.director
        favouriteFilm.producer = film.producer
        favouriteFilm.releasedate = film.release_date
        PersistenceService.saveContext()
    }
    
}
