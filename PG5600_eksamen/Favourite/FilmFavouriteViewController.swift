//
//  FilmFavouriteViewController.swift
//  PG5600_eksamen
//
//  Created by Ole Martin Larsen on 28/11/2018.
//  Copyright © 2018 Høyskolen Kristiania. All rights reserved.
//

import UIKit

class FilmFavouriteViewController: UIViewController {

    var film: FavouriteFilm!
    
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
        releaseDateLabel.text = film.releasedate
        
    }
    
    @IBAction func onButtonClick(_ sender: Any) {
        PersistenceService.context.delete(film)
        PersistenceService.saveContext()
    }

}
