//
//  MovieDetailViewController.swift
//  PG5600_eksamen
//
//  Created by Ole Martin Larsen on 24/11/2018.
//  Copyright © 2018 Høyskolen Kristiania. All rights reserved.
//

import UIKit

class FilmDetailViewController: UIViewController {

    var film: Film!
    
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titelLabel.text = film.title
        directorLabel.text = film.director
        producerLabel.text = film.producer
        releaseDateLabel.text = film.release_date
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
