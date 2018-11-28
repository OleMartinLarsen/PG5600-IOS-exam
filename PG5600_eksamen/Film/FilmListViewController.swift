//
//  ViewController.swift
//  PG5600_eksamen
//
//  Created by Ole Martin Larsen on 24/11/2018.
//  Copyright © 2018 Høyskolen Kristiania. All rights reserved.
//

import UIKit
import CoreData

class FilmListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var films = [Film]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        let jsonUrl = "https://swapi.co/api/films/"

        guard let url = URL(string: jsonUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in

            guard let data = data else { return }
            
            do {
                let films = try JSONDecoder().decode(FilmRoot.self, from: data)
                    self.films = films.results
                
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
            } catch let jsonError {
                print("JSON ERROR:", jsonError)
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!
            FilmTableViewCell
        
        cell.titleLabel.text = films[indexPath.row].title
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator;
        cell.selectionStyle = .none
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? FilmDetailViewController, let indexPath = tableView.indexPathForSelectedRow {
            
            let film = films[indexPath.row]
            detailVC.film = film
            
        }
    }
}

